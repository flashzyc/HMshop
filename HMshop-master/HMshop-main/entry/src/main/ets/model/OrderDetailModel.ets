export interface GoodsItem {
  number: number;
  picUrl: string;
  price: number;
  id: number;
  goodsName: string;
  specifications: string[];
}

export interface HandleOption {
  cancel: boolean;
  delete: boolean;
  pay: boolean;
  comment: boolean;
  confirm: boolean;
  refund: boolean;
  rebuy: boolean;
  aftersale: boolean;
}

export interface OrderDetailModel {
  orderStatusText: string;
  aftersaleStatus: number;
  isGroupin: boolean;
  orderSn: string;
  actualPrice: number;
  goodsList: GoodsItem[];
  id: number;
  handleOption: HandleOption;
}
