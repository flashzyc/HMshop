import { HttpRequest } from "../utils/HttpRequest"
import { ResponseData } from "../utils/ResponseData"
import { CategoryViewData } from "../viewmodel/CategoryViewData"
import { ToCategoryListModel } from "../model/ToCategoryListModel"

export const GetCategory = (id: number): Promise<ResponseData<CategoryViewData>> => {
  return HttpRequest({
    url: "/wx/goods/category",
    method: "get",
    params: {
      id
    },
  })
}

export const GetCategoryList =
  (categoryId: number, page: number, limit: number): Promise<ResponseData<ToCategoryListModel>> => {
    return HttpRequest({
      url: "/wx/goods/list",
      method: "get",
      params: {
        categoryId,
        page,
        limit
      }
    })
  }