import { HttpRequest } from "../utils/HttpRequest";
import { ResponseData } from "../utils/ResponseData";
import { SubmitModel } from "../model/SubmitModel";
import { PayViewData } from "../viewmodel/PayViewData"

export interface SubmitOrderRequest {
  addressId: string;
  cartId: string;
  couponId: string;
  userCouponId: string;
  grouponLinkId: number;
  grouponRulesId: number;
  message: string;
}

export const PostSubmitOrder = (orderParams: SubmitOrderRequest): Promise<ResponseData<SubmitModel>> => {
  return HttpRequest({
    url: "/wx/order/submit",
    method: "post",
    data: orderParams,
  });
};

export const GetOrderInfo = (orderId: number): Promise<ResponseData<PayViewData>> => {
  return HttpRequest({
    url: "/wx/order/detail",
    method: "get",
    params: {
      orderId: orderId,
    },
  });
};
