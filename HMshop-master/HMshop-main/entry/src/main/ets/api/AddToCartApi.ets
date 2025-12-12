import { HttpRequest } from "../utils/HttpRequest"
import { ResponseData } from "../utils/ResponseData"

interface PostAddCartParams {
  goodsId: number
  number: number
  productId: number
}
interface PromiseResponse {
  errno: number,
  data: number,
  errmsg: string
}
export const PostAddCart = (goodsId: number, number: number, productId: number): Promise<PromiseResponse> => {
  const params: PostAddCartParams = {
    goodsId,
    number,
    productId
  }

  return HttpRequest({
    url: "/wx/cart/add",
    method: "post",
    data: params
  })
}