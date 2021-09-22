package com.redhat.coolstore.service;

import java.util.List;
import java.util.logging.Logger;

import javax.inject.Inject;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import com.redhat.coolstore.model.*;

import io.micrometer.core.instrument.Metrics;
import io.micrometer.core.instrument.Timer;

@Stateless
public class CatalogService {

    @Inject
    Logger log;

    @PersistenceContext
    private EntityManager em;

    Timer timer = Metrics.timer("CatalogTimer");

    public CatalogService() {
    }

    public List<CatalogItemEntity> getCatalogItems() {
        CriteriaBuilder cb = em.getCriteriaBuilder();
        CriteriaQuery<CatalogItemEntity> criteria = cb.createQuery(CatalogItemEntity.class);
        Root<CatalogItemEntity> member = criteria.from(CatalogItemEntity.class);
        criteria.select(member);
        return timer.record( () -> {
            return em.createQuery(criteria).getResultList();
        });
    }

    public CatalogItemEntity getCatalogItemById(String itemId) {
        return em.find(CatalogItemEntity.class, itemId);
    }

    public void updateInventoryItems(String itemId, int deducts) {
        InventoryEntity inventoryEntity = getCatalogItemById(itemId).getInventory();
        int currentQuantity = inventoryEntity.getQuantity();
        inventoryEntity.setQuantity(currentQuantity-deducts);
        em.merge(inventoryEntity);
    }

}
