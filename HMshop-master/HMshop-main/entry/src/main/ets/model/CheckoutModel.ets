export interface CheckedGoodsItem {
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

export interface CheckedAddress {
  id: number;
  name: string;
  userId: number;
  province: string;
  city: string;
  county: string;
  addressDetail: string;
  areaCode: string;
  postalCode: string;
  tel: string;
  isDefault: boolean;
  addTime: string;
  updateTime: string;
  deleted: boolean;
}

export interface OrderCheckoutResponse {
  grouponRulesId: number;
  actualPrice: number;
  orderTotalPrice: number;
  cartId: number;
  userCouponId: number;
  couponId: number;
  goodsTotalPrice: number;
  addressId: number;
  grouponPrice: number;
  checkedAddress: CheckedAddress;
  couponPrice: number;
  availableCouponLength: number;
  freightPrice: number;
  checkedGoodsList: CheckedGoodsItem[];
}