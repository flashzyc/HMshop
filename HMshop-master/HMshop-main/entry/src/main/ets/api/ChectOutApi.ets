import { HttpRequest } from "../utils/HttpRequest"
import { ResponseData } from "../utils/ResponseData"
import { OrderCheckoutResponse } from "../model/CheckoutModel"

export const GetCheckout = (cartId: number, addressId: number, couponId: number, userCouponId: number,
  grouponRulesId: number): Promise<ResponseData<OrderCheckoutResponse>> => {
  return HttpRequest({
    url: "/wx/cart/checkout",
    method: "get",
    params: {
      cartId,
      addressId,
      couponId,
      userCouponId,
      grouponRulesId
    }
  })
}