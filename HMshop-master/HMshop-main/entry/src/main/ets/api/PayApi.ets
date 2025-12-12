import { HttpRequest } from "../utils/HttpRequest"

export interface PayResData {
  errno: number,
  errmsg: string,
}
interface objPage{
  orderId:number,
}
export const PostPay = (orderId: number): Promise<PayResData> => {
  const obj: objPage = {
    orderId: orderId
  }
  return HttpRequest({
    url: "/wx/order/h5pay",
    method: "post",
    data: obj
  });
};
