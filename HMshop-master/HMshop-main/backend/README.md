# HMShop Spring Boot 后端

用于配合鸿蒙前端运行的简化商城后端，包含登录、地址、分类、商品、购物车、订单、优惠券等接口，启动后占用 `8080` 端口。

## 快速启动
- 依赖：JDK 17、Maven（已经内置 H2，无需安装数据库）。
- 进入 `backend` 目录执行：
  ```bash
  mvn spring-boot:run
  ```
- 前端默认请求 `http://hmapp.net:8080`，请将 `entry/src/main/ets/utils/HttpRequest.ets` 的 `baseURL` 改为 `http://127.0.0.1:8080` 指向本地。

### 账号
- 用户名：`demo`
- 密码：`123456`

## 已覆盖的接口（与前端一致）
- `/wx/auth/login|info|logout`
- `/wx/home/index`、`/wx/brand/list|detail`、`/wx/groupon/list`、`/wx/topic/detail|list`
- `/wx/catalog/index|current`、`/wx/goods/list|detail|category`
- `/wx/cart/index|add|fastadd|checked|delete|update|checkout`
- `/wx/coupon/mylist`
- `/wx/address/list|save|delete`
- `/wx/order/submit|detail|list|delete|h5pay`
- `/wx/user/index`
- `/wx/collect/list`

## 数据库设计（20 张表）
使用 `schema.sql` + `data.sql` 自动初始化，表包括：
`shop_user`、`user_session`、`user_address`、`category`、`brand`、`goods`、`goods_attribute`、`goods_specification`、`goods_product`、`banner`、`channel`、`topic`、`coupon`、`coupon_user`、`cart`、`orders`、`order_item`、`collect`、`groupon_rules`、`groupon_record`。

## 预置数据要点
- 分类：`1008000`（数码电器）/ `1008002`（手机通讯）
- 品牌：`1001000`
- 商品：`1055016`（Harmony Phone X）含规格/sku
- 默认地址：ID `10`
- 预置优惠券 2 张（1 张未使用）
- 预置购物车和订单示例记录
