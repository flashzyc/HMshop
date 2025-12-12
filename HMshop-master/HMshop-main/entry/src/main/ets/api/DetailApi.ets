import { HttpRequest } from "../utils/HttpRequest"
import { ResponseData } from "../utils/ResponseData"
import { DetailViewData } from "../viewmodel/DetailViewData"

export const GetDetailGoods = (id: number): Promise<ResponseData<DetailViewData>> => {
  return HttpRequest({
    url: "/wx/goods/detail",
    method: "get",
    params: {
      id
    },
  })
}