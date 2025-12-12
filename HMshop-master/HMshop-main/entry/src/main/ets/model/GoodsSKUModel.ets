export interface GoodsSKUModel {
  id: number;
  goodsId: number;
  specifications: string[]; // 这是一个字符串数组，例如 ["标准"]
  price: number;
  number: number; // 库存数量
  url: string; // 图片 URL
  addTime: string;
  updateTime: string;
  deleted: boolean;
}