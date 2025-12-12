import { HttpRequest } from "../utils/HttpRequest"
import { ResponseData } from "../utils/ResponseData"
import { OrderViewData } from "../viewmodel/OrderViewData"

export const GetOrders = (showType: number, page: number, limit: number): Promise<ResponseData<OrderViewData>> => {
  return HttpRequest({
    url: "/wx/order/list",
    method: "get",
    params: {
      showType,
      page,
      limit,
    },
  })
}

export interface OrderResData {
  errno: number,
  errmsg: string,
}
interface objPage{
  orderId:number,
}
export const PostDelete= (orderId: number): Promise<OrderResData> => {
  const obj: objPage = {
    orderId: orderId
  }
  return HttpRequest({
    url: "/wx/order/delete",
    method: "post",
    data: obj,
  })
}