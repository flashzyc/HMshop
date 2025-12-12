import { HttpRequest } from "../utils/HttpRequest"
import { ResponseData } from "../utils/ResponseData"
import { CouponViewData } from "../viewmodel/CouponViewData"

export const GetCoupon = (status: number, page: number, limit: number): Promise<ResponseData<CouponViewData>> => {
  return HttpRequest({
    url: "/wx/coupon/mylist",
    method: "get",
    params: {
      status,
      page,
      limit,
    },
  })
}