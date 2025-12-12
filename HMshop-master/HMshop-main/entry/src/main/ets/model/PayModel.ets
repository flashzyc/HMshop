export interface OrderHandleOption {
  cancel: boolean;
  delete: boolean;
  pay: boolean;
  comment: boolean;
  confirm: boolean;
  refund: boolean;
  rebuy: boolean;
  aftersale: boolean;
}

export interface PayModel {
  consignee: string;
  address: string;
  addTime: string;
  orderSn: string;
  actualPrice: number;
  mobile: string;
  message: string;
  orderStatusText: string;
  aftersaleStatus: number;
  goodsPrice: number;
  couponPrice: number;
  id: number;
  freightPrice: number;
  handleOption: OrderHandleOption;
}
