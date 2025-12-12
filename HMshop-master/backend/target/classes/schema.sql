CREATE TABLE IF NOT EXISTS shop_user (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(64) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    nickname VARCHAR(64) NOT NULL,
    avatar VARCHAR(255),
    mobile VARCHAR(32),
    gender INT,
    add_time TIMESTAMP,
    update_time TIMESTAMP
);

CREATE TABLE IF NOT EXISTS user_session (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT,
    token VARCHAR(128) UNIQUE,
    expire_at TIMESTAMP,
    add_time TIMESTAMP,
    CONSTRAINT fk_session_user FOREIGN KEY (user_id) REFERENCES shop_user(id)
);

CREATE TABLE IF NOT EXISTS user_address (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT,
    name VARCHAR(64),
    tel VARCHAR(32),
    country VARCHAR(64),
    province VARCHAR(64),
    city VARCHAR(64),
    county VARCHAR(64),
    area_code VARCHAR(32),
    postal_code VARCHAR(32),
    address_detail VARCHAR(255),
    is_default BOOLEAN,
    add_time TIMESTAMP,
    update_time TIMESTAMP,
    deleted BOOLEAN,
    CONSTRAINT fk_address_user FOREIGN KEY (user_id) REFERENCES shop_user(id)
);

CREATE TABLE IF NOT EXISTS category (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    keywords VARCHAR(255),
    description VARCHAR(255),
    pid BIGINT,
    icon_url VARCHAR(255),
    pic_url VARCHAR(255),
    level VARCHAR(8),
    sort_order INT,
    add_time TIMESTAMP,
    update_time TIMESTAMP,
    deleted BOOLEAN
);

CREATE TABLE IF NOT EXISTS brand (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    description VARCHAR(255),
    pic_url VARCHAR(255),
    sort_order INT,
    floor_price DOUBLE,
    add_time TIMESTAMP,
    update_time TIMESTAMP,
    deleted BOOLEAN
);

CREATE TABLE IF NOT EXISTS goods (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    goods_sn VARCHAR(64),
    name VARCHAR(255),
    category_id BIGINT,
    brand_id BIGINT,
    gallery VARCHAR(1024),
    keywords VARCHAR(255),
    brief VARCHAR(255),
    is_on_sale BOOLEAN,
    sort_order INT,
    pic_url VARCHAR(255),
    share_url VARCHAR(255),
    is_new BOOLEAN,
    is_hot BOOLEAN,
    unit VARCHAR(32),
    counter_price DOUBLE,
    retail_price DOUBLE,
    detail TEXT,
    add_time TIMESTAMP,
    update_time TIMESTAMP,
    deleted BOOLEAN,
    CONSTRAINT fk_goods_category FOREIGN KEY (category_id) REFERENCES category(id),
    CONSTRAINT fk_goods_brand FOREIGN KEY (brand_id) REFERENCES brand(id)
);

CREATE TABLE IF NOT EXISTS goods_attribute (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    goods_id BIGINT,
    attribute VARCHAR(64),
    attr_value VARCHAR(255),
    add_time TIMESTAMP,
    update_time TIMESTAMP,
    deleted BOOLEAN,
    CONSTRAINT fk_attr_goods FOREIGN KEY (goods_id) REFERENCES goods(id)
);

CREATE TABLE IF NOT EXISTS goods_specification (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    goods_id BIGINT,
    specification VARCHAR(64),
    spec_value VARCHAR(255),
    pic_url VARCHAR(255),
    add_time TIMESTAMP,
    update_time TIMESTAMP,
    deleted BOOLEAN,
    CONSTRAINT fk_spec_goods FOREIGN KEY (goods_id) REFERENCES goods(id)
);

CREATE TABLE IF NOT EXISTS goods_product (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    goods_id BIGINT,
    specifications VARCHAR(255),
    price DOUBLE,
    number INT,
    url VARCHAR(255),
    add_time TIMESTAMP,
    update_time TIMESTAMP,
    deleted BOOLEAN,
    CONSTRAINT fk_product_goods FOREIGN KEY (goods_id) REFERENCES goods(id)
);

CREATE TABLE IF NOT EXISTS banner (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    link VARCHAR(255),
    url VARCHAR(255),
    position INT,
    content VARCHAR(255),
    enabled BOOLEAN,
    add_time TIMESTAMP,
    update_time TIMESTAMP,
    deleted BOOLEAN
);

CREATE TABLE IF NOT EXISTS channel (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    icon_url VARCHAR(255),
    url VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS topic (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255),
    subtitle VARCHAR(255),
    price DOUBLE,
    read_count VARCHAR(64),
    pic_url VARCHAR(255),
    sort_order INT,
    goods TEXT,
    add_time TIMESTAMP,
    update_time TIMESTAMP,
    deleted BOOLEAN,
    content TEXT
);

CREATE TABLE IF NOT EXISTS coupon (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    description VARCHAR(255),
    tag VARCHAR(64),
    discount DOUBLE,
    min DOUBLE,
    start_time TIMESTAMP,
    end_time TIMESTAMP,
    days INT,
    enabled BOOLEAN
);

CREATE TABLE IF NOT EXISTS coupon_user (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT,
    coupon_id BIGINT,
    status INT,
    start_time TIMESTAMP,
    end_time TIMESTAMP,
    used_time TIMESTAMP,
    add_time TIMESTAMP,
    CONSTRAINT fk_coupon_user_user FOREIGN KEY (user_id) REFERENCES shop_user(id),
    CONSTRAINT fk_coupon_user_coupon FOREIGN KEY (coupon_id) REFERENCES coupon(id)
);

CREATE TABLE IF NOT EXISTS cart (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT,
    goods_id BIGINT,
    goods_sn VARCHAR(64),
    goods_name VARCHAR(255),
    product_id BIGINT,
    price DOUBLE,
    number INT,
    specifications VARCHAR(255),
    checked BOOLEAN,
    pic_url VARCHAR(255),
    add_time TIMESTAMP,
    update_time TIMESTAMP,
    deleted BOOLEAN,
    fast_add BOOLEAN,
    CONSTRAINT fk_cart_user FOREIGN KEY (user_id) REFERENCES shop_user(id)
);

CREATE TABLE IF NOT EXISTS orders (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT,
    order_sn VARCHAR(64),
    order_status INT,
    actual_price DOUBLE,
    goods_price DOUBLE,
    freight_price DOUBLE,
    coupon_price DOUBLE,
    message VARCHAR(255),
    consignee VARCHAR(64),
    mobile VARCHAR(32),
    address VARCHAR(255),
    aftersale_status INT,
    add_time TIMESTAMP,
    update_time TIMESTAMP,
    pay_time TIMESTAMP,
    ship_time TIMESTAMP,
    confirm_time TIMESTAMP,
    deleted BOOLEAN,
    CONSTRAINT fk_order_user FOREIGN KEY (user_id) REFERENCES shop_user(id)
);

CREATE TABLE IF NOT EXISTS order_item (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    order_id BIGINT,
    goods_id BIGINT,
    goods_name VARCHAR(255),
    goods_sn VARCHAR(64),
    product_id BIGINT,
    number INT,
    price DOUBLE,
    specifications VARCHAR(255),
    pic_url VARCHAR(255),
    CONSTRAINT fk_order_item_order FOREIGN KEY (order_id) REFERENCES orders(id)
);

CREATE TABLE IF NOT EXISTS collect (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT,
    value_id BIGINT,
    type INT,
    add_time TIMESTAMP,
    deleted BOOLEAN,
    CONSTRAINT fk_collect_user FOREIGN KEY (user_id) REFERENCES shop_user(id)
);

CREATE TABLE IF NOT EXISTS groupon_rules (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    goods_id BIGINT,
    discount DOUBLE,
    discount_member INT,
    expire_time TIMESTAMP,
    enabled BOOLEAN
);

CREATE TABLE IF NOT EXISTS groupon_record (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    order_id BIGINT,
    rules_id BIGINT,
    user_id BIGINT,
    status INT,
    add_time TIMESTAMP
);
