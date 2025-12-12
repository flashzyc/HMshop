export interface GroupBuyModel {
  id: number;
  goodsId: number;
  name: string;
  brief: string;
  picUrl: string;
  counterPrice: number;
  retailPrice: number;
  grouponPrice: number;
  grouponDiscount: number;
  grouponMember: number;
  expireTime: string;
}
