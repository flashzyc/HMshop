export interface CartListModel {
  id: number;
  userId: number;
  goodsId: number;
  goodsSn: string;
  goodsName: string;
  productId: number;
  price: number;
  number: number;
  specifications: string[];
  checked: boolean;
  picUrl: string;
  addTime: string;
  updateTime: string;
  deleted: boolean;
}