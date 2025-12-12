export interface CategoryListModel {
  id: number; // 商品唯一标识符
  name: string; // 商品名称
  brief: string; // 商品简介/宣传语
  picUrl: string; // 商品图片 URL
  isNew: boolean; // 是否为新品
  isHot: boolean; // 是否为热销商品
  counterPrice: number; // 吊牌价/市场价
  retailPrice: number; // 实际零售价
}