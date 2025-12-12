import { CartListModel } from "../model/CartListModel";
import { CartTotalModel } from "../model/CartTotalModel";

export interface ShopCartViewData {
  cartList: Array<CartListModel>;
  cartTotal: CartTotalModel;
}