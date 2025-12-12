// ShopCartApi.ets
import { HttpRequest } from "../utils/HttpRequest"
import { ResponseData } from "../utils/ResponseData"
import { ShopCartViewData } from "../viewmodel/ShopCartViewData"

interface SimpleResponse {
  errno: number,
  errmsg: string,
}

interface ShopCartListParams {
  productIds: Array<number>,
  isChecked: number
}

interface UpdateCart {
  number: number,
  goodsId: number,
  id: number,
  productId: number
}

interface DeleteCartParams {
  productIds: Array<number>
}

export const GetShopCartList = (): Promise<ResponseData<ShopCartViewData>> => {
  return HttpRequest({
    url: "/wx/cart/index",
    method: "get"
  })
}

export const PostShopCartList =
  (productIds: Array<number>, isChecked: number): Promise<ResponseData<ShopCartViewData>> => {
    const params: ShopCartListParams = {
      productIds,
      isChecked
    }
    return HttpRequest({
      url: "/wx/cart/checked",
      method: "post",
      data: params
    })
  }

export const PostDeleteShop = (productIds: Array<number>): Promise<ResponseData<ShopCartViewData>> => {
  const params: DeleteCartParams = {
    productIds
  }
  return HttpRequest({
    url: "/wx/cart/delete",
    method: "post",
    data: params
  })
}

export const PostUpdate = (number: number, goodsId: number, id: number, productId: number): Promise<SimpleResponse> => {
  const params: UpdateCart = {
    number,
    goodsId,
    id,
    productId
  }
  return HttpRequest({
    url: "/wx/cart/update",
    method: "post",
    data: params
  })
}