import { SearchViewData } from "../viewmodel/SearchViewData"
import { ResponseData } from "../utils/ResponseData"
import { HttpRequest } from "../utils/HttpRequest"

export const GetSearchData =
  (keyword: string, page: number, limit: number, categoryId: number): Promise<ResponseData<SearchViewData>> => {
    return HttpRequest({
      url: "/wx/goods/list",
      method: "get",
      params: {
        keyword,
        page,
        limit,
        categoryId,
      },
    })
  }