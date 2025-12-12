import { HttpRequest } from "../utils/HttpRequest"
import { ResponseData } from "../utils/ResponseData"

interface CollectViewData {
  list: Array<string>
}

export const GetCollectList = (type: number, page: number, limit: number): Promise<ResponseData<CollectViewData>> => {
  return HttpRequest({
    url: "/wx/collect/list",
    method: "get",
    params: {
      type,
      page,
      limit,
    },
  })
}