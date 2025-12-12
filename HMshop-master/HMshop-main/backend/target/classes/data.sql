-- 设置全局图片路径变量 (修改此处即可切换IP)
SET @img_base = 'http://10.21.213.157:5344/img/';
SET @old_base = 'http://hmapp.net/static/img/';

INSERT INTO shop_user (id, username, password, nickname, avatar, mobile, gender, add_time, update_time)
VALUES (1, 'bupt2023', '2023bupt', 'IG-theshy', 'http://hmapp.net/static/img/avatar.png', '18015006975', 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO user_address (id, user_id, name, tel, country, province, city, county, area_code, postal_code, address_detail, is_default, add_time, update_time, deleted)
VALUES (10, 1, '周希泰', '15247066805', '中国', '北京市', '北京市', '昌平区', '440305', '518000', '雁北学生公寓', TRUE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE);

-- 顶级分类
INSERT INTO category (id, name, keywords, description, pid, icon_url, pic_url, level, sort_order, add_time, update_time, deleted)
VALUES (1008000, '数码电器', '手机,平板', '数码潮品', 0, 'http://hmapp.net/static/img/cat_icon.png', 'http://hmapp.net/static/img/cat_pic.png', 'L1', 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE);
-- 二级分类
INSERT INTO category (id, name, keywords, description, pid, icon_url, pic_url, level, sort_order, add_time, update_time, deleted)
VALUES (1008002, '手机通讯', '手机', '旗舰机与性价比', 1008000, 'http://hmapp.net/static/img/cat_icon2.png', 'http://hmapp.net/static/img/cat_pic2.png', 'L2', 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE);

INSERT INTO brand (id, name, description, pic_url, sort_order, floor_price, add_time, update_time, deleted)
VALUES (1001000, 'HUAWEI', '华为终端产品', 'http://hmapp.net/static/img/brand.png', 1, 1999, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE);

INSERT INTO goods (id, goods_sn, name, category_id, brand_id, gallery, keywords, brief, is_on_sale, sort_order, pic_url, share_url, is_new, is_hot, unit, counter_price, retail_price, detail, add_time, update_time, deleted)
VALUES (1055016, 'HM-001', 'HUAWEI Mate 80 Pro', 1008002, 1001000,
        'http://hmapp.net/static/img/goods1.png,http://hmapp.net/static/img/goods1b.png,http://hmapp.net/static/img/goods1c.png',
        '手机,Mate', '超可靠玄武架构，双卫星通信', TRUE, 1, 'http://hmapp.net/static/img/goods1.png', 'http://hmapp.net/static/img/goods1.png',
        TRUE, TRUE, '台', 6999, 6999,
        '<p>HUAWEI Mate 80 Pro 搭载鸿蒙操作系统4.0，支持卫星通话。</p><img src=\"http://hmapp.net/static/img/goods1.png\"/>',
        CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE);

INSERT INTO goods_attribute (goods_id, attribute, attr_value, add_time, update_time, deleted)
VALUES (1055016, '屏幕', '6.82英寸 OLED', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE),
       (1055016, '电池', '5000mAh', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE);

INSERT INTO goods_specification (id, goods_id, specification, spec_value, pic_url, add_time, update_time, deleted)
VALUES (50101, 1055016, '颜色', '云杉绿', 'http://hmapp.net/static/img/goods1.png', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE),
       (50102, 1055016, '颜色', '白沙银', 'http://hmapp.net/static/img/goods1b.png', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE),
       (50103, 1055016, '存储', '512GB', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE),
       (50104, 1055016, '存储', '1TB', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE);

INSERT INTO goods_product (id, goods_id, specifications, price, number, url, add_time, update_time, deleted)
VALUES (60101, 1055016, '云杉绿,512GB', 6999, 50, 'http://hmapp.net/static/img/goods1.png', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE),
       (60102, 1055016, '白沙银,1TB', 7999, 30, 'http://hmapp.net/static/img/goods1b.png', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE);

INSERT INTO banner (name, link, url, position, content, enabled, add_time, update_time, deleted)
VALUES ('新品首发', '/pages/DetailPage?did=1055016', 'http://hmapp.net/static/img/banner1.png', 1, 'Harmony X', TRUE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE);

INSERT INTO channel (name, icon_url, url)
VALUES ('手机', 'http://hmapp.net/static/img/icon_phone.png', '/pages/CategoryPage?cid=1008002'),
       ('配件', 'http://hmapp.net/static/img/icon_parts.png', '/pages/CategoryPage?cid=1008002'),
       ('优惠', 'http://hmapp.net/static/img/icon_coupon.png', '/pages/CouponPage'),
       ('会员', 'http://hmapp.net/static/img/icon_vip.png', '/pages/LoginPage');

INSERT INTO topic (title, subtitle, price, read_count, pic_url, sort_order, goods, add_time, update_time, deleted, content)
VALUES ('鸿蒙精品', '生态精选', 1999, '1.2k', 'http://hmapp.net/static/img/topic1.png', 1, '[]', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE, '<p>鸿蒙生态产品专题</p>');

INSERT INTO coupon (id, name, description, tag, discount, min, start_time, end_time, days, enabled)
VALUES (1, '新人立减', '全场通用', '新人', 50, 299, CURRENT_TIMESTAMP, DATEADD('DAY', 30, CURRENT_TIMESTAMP), 0, TRUE),
       (2, '手机配件券', '配件使用', '配件', 20, 99, CURRENT_TIMESTAMP, DATEADD('DAY', 60, CURRENT_TIMESTAMP), 0, TRUE);

INSERT INTO coupon_user (user_id, coupon_id, status, start_time, end_time, used_time, add_time)
VALUES (1, 1, 0, CURRENT_TIMESTAMP, DATEADD('DAY', 30, CURRENT_TIMESTAMP), NULL, CURRENT_TIMESTAMP),
       (1, 2, 1, DATEADD('DAY', -10, CURRENT_TIMESTAMP), DATEADD('DAY', 20, CURRENT_TIMESTAMP), DATEADD('DAY', -1, CURRENT_TIMESTAMP), CURRENT_TIMESTAMP);

-- 以下演示用的订单/购物车/收藏/团购数据移除，避免干扰真实订单展示

-- 新增分类：智能家居
INSERT INTO category (id, name, keywords, description, pid, icon_url, pic_url, level, sort_order, add_time, update_time, deleted)
VALUES (1008010, '智能家居', '智慧屏,音箱', '打造智慧生活', 0, 'http://hmapp.net/static/img/cat_icon_home.png', 'http://hmapp.net/static/img/cat_pic_home.png', 'L1', 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE);

INSERT INTO category (id, name, keywords, description, pid, icon_url, pic_url, level, sort_order, add_time, update_time, deleted)
VALUES (1008011, '智慧屏', '电视,智慧屏', '家庭娱乐中心', 1008010, 'http://hmapp.net/static/img/cat_icon_tv.png', 'http://hmapp.net/static/img/cat_pic_tv.png', 'L2', 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE);

INSERT INTO category (id, name, keywords, description, pid, icon_url, pic_url, level, sort_order, add_time, update_time, deleted)
VALUES (1008012, '智能音箱', '音箱,Sound', '高保真音质', 1008010, 'http://hmapp.net/static/img/cat_icon_speaker.png', 'http://hmapp.net/static/img/cat_pic_speaker.png', 'L2', 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE);

-- 新增品牌：SoundX
INSERT INTO brand (id, name, description, pic_url, sort_order, floor_price, add_time, update_time, deleted)
VALUES (1001001, 'SoundX', '极致声学体验', 'http://hmapp.net/static/img/brand_sound.png', 2, 999, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE);

-- 新增商品：HUAWEI Vision S 86 (智慧屏)
INSERT INTO goods (id, goods_sn, name, category_id, brand_id, gallery, keywords, brief, is_on_sale, sort_order, pic_url, share_url, is_new, is_hot, unit, counter_price, retail_price, detail, add_time, update_time, deleted)
VALUES (1055030, 'HM-TV-001', 'HUAWEI Vision S 86', 1008011, 1001000,
        'http://hmapp.net/static/img/goods_tv1.png,http://hmapp.net/static/img/goods_tv2.png',
        '智慧屏,电视', '120Hz鸿蒙炫彩屏', TRUE, 2, 'http://hmapp.net/static/img/goods_tv1.png', 'http://hmapp.net/static/img/goods_tv1.png',
        TRUE, TRUE, '台', 6499, 5999,
        '<p>HUAWEI Vision S 86 带来沉浸式视听体验。</p><img src=\"http://hmapp.net/static/img/goods_tv1.png\"/>',
        CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE);

-- 新增商品：HUAWEI Sound X NEW (智能音箱)
INSERT INTO goods (id, goods_sn, name, category_id, brand_id, gallery, keywords, brief, is_on_sale, sort_order, pic_url, share_url, is_new, is_hot, unit, counter_price, retail_price, detail, add_time, update_time, deleted)
VALUES (1055031, 'HM-SPK-001', 'HUAWEI Sound X NEW', 1008012, 1001001,
        'http://hmapp.net/static/img/goods_spk1.png,http://hmapp.net/static/img/goods_spk2.png',
        '音箱,HiFi', '帝瓦雷联合设计，三分频智慧音箱', TRUE, 3, 'http://hmapp.net/static/img/goods_spk1.png', 'http://hmapp.net/static/img/goods_spk1.png',
        TRUE, TRUE, '台', 2199, 1999,
        '<p>HUAWEI Sound X NEW 震撼音质，一碰传音。</p><img src=\"http://hmapp.net/static/img/goods_spk1.png\"/>',
        CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE);

-- 商品参数
INSERT INTO goods_attribute (goods_id, attribute, attr_value, add_time, update_time, deleted)
VALUES (1055030, '屏幕尺寸', '86英寸', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE),
       (1055030, '分辨率', '4K', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE),
       (1055031, '扬声器', '8单元三分频', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE),
       (1055031, '连接', '蓝牙5.0/WiFi', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE);

-- 商品规格
INSERT INTO goods_specification (id, goods_id, specification, spec_value, pic_url, add_time, update_time, deleted)
VALUES (50201, 1055030, '安装方式', '挂架式', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE),
       (50202, 1055030, '安装方式', '底座式', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE),
       (50301, 1055031, '颜色', '韵律黑', 'http://hmapp.net/static/img/goods_spk1.png', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE),
       (50302, 1055031, '颜色', '悦动白', 'http://hmapp.net/static/img/goods_spk2.png', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE);

-- 商品库存 (Product)
INSERT INTO goods_product (id, goods_id, specifications, price, number, url, add_time, update_time, deleted)
VALUES (60201, 1055030, '挂架式', 5999, 100, 'http://hmapp.net/static/img/goods_tv1.png', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE),
       (60202, 1055030, '底座式', 6099, 50, 'http://hmapp.net/static/img/goods_tv1.png', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE),
       (60301, 1055031, '韵律黑', 1999, 200, 'http://hmapp.net/static/img/goods_spk1.png', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE),
       (60302, 1055031, '悦动白', 1999, 150, 'http://hmapp.net/static/img/goods_spk2.png', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE);

-- 新增 Banner
INSERT INTO banner (name, link, url, position, content, enabled, add_time, update_time, deleted)
VALUES ('智慧生活节', '/pages/CategoryPage?cid=1008010', 'http://hmapp.net/static/img/banner_home.png', 2, 'Smart Home', TRUE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE);

-- 新增 Topic
INSERT INTO topic (title, subtitle, price, read_count, pic_url, sort_order, goods, add_time, update_time, deleted, content)
VALUES ('打造智慧家', '全屋智能方案', 9999, '5k+', 'http://hmapp.net/static/img/topic_home.png', 2, '[1055030, 1055031]', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE, '<p>从客厅到卧室，全屋智能体验。</p>');

-- 新增 Coupon
INSERT INTO coupon (id, name, description, tag, discount, min, start_time, end_time, days, enabled)
VALUES (3, '智能家居券', '仅限智能家居品类', '智能', 100, 1000, CURRENT_TIMESTAMP, DATEADD('DAY', 30, CURRENT_TIMESTAMP), 0, TRUE);

-- 新增分类：电脑办公
INSERT INTO category (id, name, keywords, description, pid, icon_url, pic_url, level, sort_order, add_time, update_time, deleted)
VALUES (1008003, '电脑办公', '笔记本,台式机', '高效生产力', 1008000, 'http://hmapp.net/static/img/cat_icon_pc.png', 'http://hmapp.net/static/img/cat_pic_pc.png', 'L2', 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE);

-- 新增分类：平板电脑
INSERT INTO category (id, name, keywords, description, pid, icon_url, pic_url, level, sort_order, add_time, update_time, deleted)
VALUES (1008004, '平板电脑', '平板,MatePad', '创造力工具', 1008000, 'http://hmapp.net/static/img/cat_icon_pad.png', 'http://hmapp.net/static/img/cat_pic_pad.png', 'L2', 3, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE);

-- 新增商品：HUAWEI Mate XT 非凡大师 (三折叠)
INSERT INTO goods (id, goods_sn, name, category_id, brand_id, gallery, keywords, brief, is_on_sale, sort_order, pic_url, share_url, is_new, is_hot, unit, counter_price, retail_price, detail, add_time, update_time, deleted)
VALUES (1055040, 'HM-XT-001', 'HUAWEI Mate XT 非凡大师', 1008002, 1001000,
        'http://hmapp.net/static/img/goods_xt1.png,http://hmapp.net/static/img/goods_xt2.png',
        '三折叠,非凡大师', '全球首款三折叠屏手机', TRUE, 1, 'http://hmapp.net/static/img/goods_xt1.png', 'http://hmapp.net/static/img/goods_xt1.png',
        TRUE, TRUE, '台', 19999, 19999,
        '<p>HUAWEI Mate XT 非凡大师，展开即是10.2英寸大屏。</p><img src=\"http://hmapp.net/static/img/goods_xt1.png\"/>',
        CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE);

INSERT INTO goods_attribute (goods_id, attribute, attr_value, add_time, update_time, deleted)
VALUES (1055040, '屏幕', '10.2英寸 三折叠', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE),
       (1055040, '厚度', '展开3.6mm', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE);

INSERT INTO goods_specification (id, goods_id, specification, spec_value, pic_url, add_time, update_time, deleted)
VALUES (50401, 1055040, '颜色', '瑞红', 'http://hmapp.net/static/img/goods_xt1.png', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE),
       (50402, 1055040, '颜色', '玄黑', 'http://hmapp.net/static/img/goods_xt2.png', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE);

INSERT INTO goods_product (id, goods_id, specifications, price, number, url, add_time, update_time, deleted)
VALUES (60401, 1055040, '瑞红', 19999, 10, 'http://hmapp.net/static/img/goods_xt1.png', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE),
       (60402, 1055040, '玄黑', 19999, 10, 'http://hmapp.net/static/img/goods_xt2.png', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE);

-- 新增商品：HUAWEI MateBook X Pro (电脑)
INSERT INTO goods (id, goods_sn, name, category_id, brand_id, gallery, keywords, brief, is_on_sale, sort_order, pic_url, share_url, is_new, is_hot, unit, counter_price, retail_price, detail, add_time, update_time, deleted)
VALUES (1055041, 'HM-PC-001', 'HUAWEI MateBook X Pro', 1008003, 1001000,
        'http://hmapp.net/static/img/goods_pc1.png,http://hmapp.net/static/img/goods_pc2.png',
        '笔记本,轻薄本', '980g超轻薄，高性能', TRUE, 2, 'http://hmapp.net/static/img/goods_pc1.png', 'http://hmapp.net/static/img/goods_pc1.png',
        TRUE, TRUE, '台', 11199, 10999,
        '<p>HUAWEI MateBook X Pro 开启高性能轻薄本新时代。</p><img src=\"http://hmapp.net/static/img/goods_pc1.png\"/>',
        CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE);

INSERT INTO goods_attribute (goods_id, attribute, attr_value, add_time, update_time, deleted)
VALUES (1055041, '处理器', 'Core Ultra 9', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE),
       (1055041, '重量', '980g', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE);

INSERT INTO goods_specification (id, goods_id, specification, spec_value, pic_url, add_time, update_time, deleted)
VALUES (50501, 1055041, '颜色', '晴蓝', 'http://hmapp.net/static/img/goods_pc1.png', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE),
       (50502, 1055041, '颜色', '砚黑', 'http://hmapp.net/static/img/goods_pc2.png', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE);

INSERT INTO goods_product (id, goods_id, specifications, price, number, url, add_time, update_time, deleted)
VALUES (60501, 1055041, '晴蓝', 10999, 50, 'http://hmapp.net/static/img/goods_pc1.png', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE),
       (60502, 1055041, '砚黑', 10999, 50, 'http://hmapp.net/static/img/goods_pc2.png', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE);

-- 新增商品：HUAWEI MatePad Pro 13.2 (平板)
INSERT INTO goods (id, goods_sn, name, category_id, brand_id, gallery, keywords, brief, is_on_sale, sort_order, pic_url, share_url, is_new, is_hot, unit, counter_price, retail_price, detail, add_time, update_time, deleted)
VALUES (1055042, 'HM-PAD-001', 'HUAWEI MatePad Pro 13.2', 1008004, 1001000,
        'http://hmapp.net/static/img/goods_pad1.png,http://hmapp.net/static/img/goods_pad2.png',
        '平板,OLED', '13.2英寸柔性OLED屏', TRUE, 3, 'http://hmapp.net/static/img/goods_pad1.png', 'http://hmapp.net/static/img/goods_pad1.png',
        TRUE, TRUE, '台', 5199, 4999,
        '<p>HUAWEI MatePad Pro 13.2 刷新平板轻薄极限。</p><img src=\"http://hmapp.net/static/img/goods_pad1.png\"/>',
        CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE);

INSERT INTO goods_attribute (goods_id, attribute, attr_value, add_time, update_time, deleted)
VALUES (1055042, '屏幕', '13.2英寸 OLED', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE),
       (1055042, '厚度', '5.5mm', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE);

INSERT INTO goods_specification (id, goods_id, specification, spec_value, pic_url, add_time, update_time, deleted)
VALUES (50601, 1055042, '颜色', '雅川青', 'http://hmapp.net/static/img/goods_pad1.png', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE),
       (50602, 1055042, '颜色', '曜金黑', 'http://hmapp.net/static/img/goods_pad2.png', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE);

INSERT INTO goods_product (id, goods_id, specifications, price, number, url, add_time, update_time, deleted)
VALUES (60601, 1055042, '雅川青', 4999, 100, 'http://hmapp.net/static/img/goods_pad1.png', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE),
       (60602, 1055042, '曜金黑', 4999, 100, 'http://hmapp.net/static/img/goods_pad2.png', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE);

-- 新增分类：数码配件
INSERT INTO category (id, name, keywords, description, pid, icon_url, pic_url, level, sort_order, add_time, update_time, deleted)
VALUES (1008005, '数码配件', '耳机,手表', '数码好搭档', 1008000, 'http://hmapp.net/static/img/cat_icon_acc.png', 'http://hmapp.net/static/img/cat_pic_acc.png', 'L2', 4, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE);

-- 新增商品：HUAWEI Pura 70 Ultra (手机)
INSERT INTO goods (id, goods_sn, name, category_id, brand_id, gallery, keywords, brief, is_on_sale, sort_order, pic_url, share_url, is_new, is_hot, unit, counter_price, retail_price, detail, add_time, update_time, deleted)
VALUES (1055080, 'HM-PURA-001', 'HUAWEI Pura 70 Ultra', 1008002, 1001000,
        'http://hmapp.net/static/img/goods_pura1.png,http://hmapp.net/static/img/goods_pura2.png',
        'Pura,影像', '超聚光伸缩摄像头', TRUE, 11, 'http://hmapp.net/static/img/goods_pura1.png', 'http://hmapp.net/static/img/goods_pura1.png',
        TRUE, TRUE, '台', 9999, 9999,
        '<p>HUAWEI Pura 70 Ultra 追逐本心，锐意向前。</p><img src=\"http://hmapp.net/static/img/goods_pura1.png\"/>',
        CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE);
INSERT INTO goods_attribute (goods_id, attribute, attr_value, add_time, update_time, deleted)
VALUES (1055080, '屏幕', '6.8英寸 OLED', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE),
       (1055080, '摄像头', '超聚光伸缩', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE);
INSERT INTO goods_specification (id, goods_id, specification, spec_value, pic_url, add_time, update_time, deleted)
VALUES (50801, 1055080, '颜色', '香颂绿', 'http://hmapp.net/static/img/goods_pura1.png', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE),
       (50802, 1055080, '颜色', '摩卡棕', 'http://hmapp.net/static/img/goods_pura2.png', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE);
INSERT INTO goods_product (id, goods_id, specifications, price, number, url, add_time, update_time, deleted)
VALUES (60801, 1055080, '香颂绿', 9999, 50, 'http://hmapp.net/static/img/goods_pura1.png', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE),
       (60802, 1055080, '摩卡棕', 9999, 50, 'http://hmapp.net/static/img/goods_pura2.png', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE);

-- 新增商品：HUAWEI MateBook D 16 (电脑)
INSERT INTO goods (id, goods_sn, name, category_id, brand_id, gallery, keywords, brief, is_on_sale, sort_order, pic_url, share_url, is_new, is_hot, unit, counter_price, retail_price, detail, add_time, update_time, deleted)
VALUES (1055081, 'HM-PC-002', 'HUAWEI MateBook D 16', 1008003, 1001000,
        'http://hmapp.net/static/img/goods_matebookd1.png,http://hmapp.net/static/img/goods_matebookd2.png',
        '笔记本,大屏', '16英寸护眼全面屏', TRUE, 21, 'http://hmapp.net/static/img/goods_matebookd1.png', 'http://hmapp.net/static/img/goods_matebookd1.png',
        TRUE, FALSE, '台', 4999, 4599,
        '<p>HUAWEI MateBook D 16 轻薄大屏，办公利器。</p><img src=\"http://hmapp.net/static/img/goods_matebookd1.png\"/>',
        CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE);
INSERT INTO goods_attribute (goods_id, attribute, attr_value, add_time, update_time, deleted)
VALUES (1055081, '处理器', 'i5-13500H', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE),
       (1055081, '屏幕', '16英寸', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE);
INSERT INTO goods_specification (id, goods_id, specification, spec_value, pic_url, add_time, update_time, deleted)
VALUES (50811, 1055081, '颜色', '皓月银', 'http://hmapp.net/static/img/goods_matebookd1.png', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE),
       (50812, 1055081, '颜色', '深空灰', 'http://hmapp.net/static/img/goods_matebookd2.png', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE);
INSERT INTO goods_product (id, goods_id, specifications, price, number, url, add_time, update_time, deleted)
VALUES (60811, 1055081, '皓月银', 4599, 100, 'http://hmapp.net/static/img/goods_matebookd1.png', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE),
       (60812, 1055081, '深空灰', 4599, 100, 'http://hmapp.net/static/img/goods_matebookd2.png', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE);

-- 新增商品：HUAWEI MatePad 11.5 S (平板)
INSERT INTO goods (id, goods_sn, name, category_id, brand_id, gallery, keywords, brief, is_on_sale, sort_order, pic_url, share_url, is_new, is_hot, unit, counter_price, retail_price, detail, add_time, update_time, deleted)
VALUES (1055082, 'HM-PAD-002', 'HUAWEI MatePad 11.5 S', 1008004, 1001000,
        'http://hmapp.net/static/img/goods_pad11_1.png,http://hmapp.net/static/img/goods_pad11_2.png',
        '平板,柔光屏', '云晰柔光屏，防眩护眼', TRUE, 31, 'http://hmapp.net/static/img/goods_pad11_1.png', 'http://hmapp.net/static/img/goods_pad11_1.png',
        TRUE, TRUE, '台', 2599, 2299,
        '<p>HUAWEI MatePad 11.5 S 更好看的柔光屏。</p><img src=\"http://hmapp.net/static/img/goods_pad11_1.png\"/>',
        CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE);
INSERT INTO goods_attribute (goods_id, attribute, attr_value, add_time, update_time, deleted)
VALUES (1055082, '屏幕', '11.5英寸 144Hz', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE),
       (1055082, '特色', '柔光屏', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE);
INSERT INTO goods_specification (id, goods_id, specification, spec_value, pic_url, add_time, update_time, deleted)
VALUES (50821, 1055082, '颜色', '羽砂紫', 'http://hmapp.net/static/img/goods_pad11_1.png', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE),
       (50822, 1055082, '颜色', '冰霜银', 'http://hmapp.net/static/img/goods_pad11_2.png', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE);
INSERT INTO goods_product (id, goods_id, specifications, price, number, url, add_time, update_time, deleted)
VALUES (60821, 1055082, '羽砂紫', 2299, 100, 'http://hmapp.net/static/img/goods_pad11_1.png', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE),
       (60822, 1055082, '冰霜银', 2299, 100, 'http://hmapp.net/static/img/goods_pad11_2.png', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE);

-- 新增商品：HUAWEI FreeBuds Pro 3 (配件)
INSERT INTO goods (id, goods_sn, name, category_id, brand_id, gallery, keywords, brief, is_on_sale, sort_order, pic_url, share_url, is_new, is_hot, unit, counter_price, retail_price, detail, add_time, update_time, deleted)
VALUES (1055083, 'HM-ACC-001', 'HUAWEI FreeBuds Pro 3', 1008005, 1001000,
        'http://hmapp.net/static/img/goods_buds1.png,http://hmapp.net/static/img/goods_buds2.png',
        '耳机,降噪', '超CD级无损音质', TRUE, 41, 'http://hmapp.net/static/img/goods_buds1.png', 'http://hmapp.net/static/img/goods_buds1.png',
        TRUE, TRUE, '个', 1499, 1199,
        '<p>HUAWEI FreeBuds Pro 3 巅峰音质。</p><img src=\"http://hmapp.net/static/img/goods_buds1.png\"/>',
        CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE);
INSERT INTO goods_attribute (goods_id, attribute, attr_value, add_time, update_time, deleted)
VALUES (1055083, '降噪', '智慧动态降噪3.0', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE),
       (1055083, '音质', 'L2HC 3.0', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE);
INSERT INTO goods_specification (id, goods_id, specification, spec_value, pic_url, add_time, update_time, deleted)
VALUES (50831, 1055083, '颜色', '雅川青', 'http://hmapp.net/static/img/goods_buds1.png', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE),
       (50832, 1055083, '颜色', '陶瓷白', 'http://hmapp.net/static/img/goods_buds2.png', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE);
INSERT INTO goods_product (id, goods_id, specifications, price, number, url, add_time, update_time, deleted)
VALUES (60831, 1055083, '雅川青', 1199, 200, 'http://hmapp.net/static/img/goods_buds1.png', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE),
       (60832, 1055083, '陶瓷白', 1199, 200, 'http://hmapp.net/static/img/goods_buds2.png', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE);

-- 新增商品：HUAWEI Watch GT 4 (配件)
INSERT INTO goods (id, goods_sn, name, category_id, brand_id, gallery, keywords, brief, is_on_sale, sort_order, pic_url, share_url, is_new, is_hot, unit, counter_price, retail_price, detail, add_time, update_time, deleted)
VALUES (1055084, 'HM-ACC-002', 'HUAWEI Watch GT 4', 1008005, 1001000,
        'http://hmapp.net/static/img/goods_watch1.png,http://hmapp.net/static/img/goods_watch2.png',
        '手表,运动', '几何美学，强劲续航', TRUE, 42, 'http://hmapp.net/static/img/goods_watch1.png', 'http://hmapp.net/static/img/goods_watch1.png',
        TRUE, TRUE, '个', 1588, 1488,
        '<p>HUAWEI Watch GT 4 科学运动，健康管理。</p><img src=\"http://hmapp.net/static/img/goods_watch1.png\"/>',
        CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE);
INSERT INTO goods_attribute (goods_id, attribute, attr_value, add_time, update_time, deleted)
VALUES (1055084, '续航', '最长14天', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE),
       (1055084, '防水', 'IP68', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE);
INSERT INTO goods_specification (id, goods_id, specification, spec_value, pic_url, add_time, update_time, deleted)
VALUES (50841, 1055084, '颜色', '云杉绿', 'http://hmapp.net/static/img/goods_watch1.png', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE),
       (50842, 1055084, '颜色', '曜石黑', 'http://hmapp.net/static/img/goods_watch2.png', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE);
INSERT INTO goods_product (id, goods_id, specifications, price, number, url, add_time, update_time, deleted)
VALUES (60841, 1055084, '云杉绿', 1488, 100, 'http://hmapp.net/static/img/goods_watch1.png', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE),
       (60842, 1055084, '曜石黑', 1488, 100, 'http://hmapp.net/static/img/goods_watch2.png', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, FALSE);

-- 批量更新图片路径 (将默认域名替换为配置的IP)
UPDATE shop_user SET avatar = REPLACE(avatar, @old_base, @img_base);
UPDATE category SET icon_url = REPLACE(icon_url, @old_base, @img_base), pic_url = REPLACE(pic_url, @old_base, @img_base);
UPDATE brand SET pic_url = REPLACE(pic_url, @old_base, @img_base);
UPDATE goods SET pic_url = REPLACE(pic_url, @old_base, @img_base), share_url = REPLACE(share_url, @old_base, @img_base), gallery = REPLACE(gallery, @old_base, @img_base), detail = REPLACE(detail, @old_base, @img_base);
UPDATE goods_specification SET pic_url = REPLACE(pic_url, @old_base, @img_base);
UPDATE goods_product SET url = REPLACE(url, @old_base, @img_base);
UPDATE banner SET url = REPLACE(url, @old_base, @img_base);
UPDATE channel SET icon_url = REPLACE(icon_url, @old_base, @img_base);
UPDATE topic SET pic_url = REPLACE(pic_url, @old_base, @img_base);
UPDATE cart SET pic_url = REPLACE(pic_url, @old_base, @img_base);
UPDATE order_item SET pic_url = REPLACE(pic_url, @old_base, @img_base);
