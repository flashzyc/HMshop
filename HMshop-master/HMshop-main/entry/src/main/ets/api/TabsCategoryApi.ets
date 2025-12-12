import { HttpRequest } from "../utils/HttpRequest"
import { ResponseData } from "../utils/ResponseData"
import { TabsCategoryViewData } from "../viewmodel/TabsCategoryViewData"

export const GetTabsCategory = (): Promise<ResponseData<TabsCategoryViewData>> => {
  return HttpRequest({
    url: "/wx/catalog/index",
    method: "get"
  })
}

export const GetNewCategoryList = (id:number): Promise<ResponseData<TabsCategoryViewData>> => {
  return HttpRequest({
    url: "/wx/catalog/current",
    method: "get",
    params:{
      id
    }
  })
}