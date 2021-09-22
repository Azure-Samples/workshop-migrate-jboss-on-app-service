create table INVENTORY (
    itemId varchar(255) not null,
    link varchar(255),
    location varchar(255),
    quantity int,
    primary key (itemId)
);

create table ORDERS (
    orderId bigint not null,
    customerEmail varchar(255),
    customerName varchar(255),
    discount float not null,
    orderValue float not null,
    retailPrice float not null,
    shippingDiscount float not null,
    shippingFee float not null,
    primary key (orderId)
);

create table ORDER_ITEMS (
    ID int not null,
    productId varchar(255),
    quantity int not null,
    ORDER_ID bigint,
    primary key (ID)
);

create table PRODUCT_CATALOG (
    itemId varchar(255) not null,
    description text,
    name varchar(80),
    price float,
    primary key (itemId)
);

alter table ORDER_ITEMS
    add constraint FK2BFF474F65938E8
    foreign key (ORDER_ID)
    references ORDERS;

create sequence hibernate_sequence;