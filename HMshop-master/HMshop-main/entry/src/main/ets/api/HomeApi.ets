import { HttpRequest } from "../utils/HttpRequest"
import { ResponseData } from "../utils/ResponseData"
import {
  BrandViewData,
  HomeViewData,
  BrandDetailViewData,
  NewArrivalViewData,
  TopicViewData,
  TopicMoreViewData
} from "../viewmodel/HomeViewData"
import { BrandDetailModel } from "../model/BrandDetailModel"
import { GroupBuyViewData } from "../viewmodel/HomeViewData"

export const GetHome = (): Promise<ResponseData<HomeViewData>> => {
  return HttpRequest({
    url: "/wx/home/index",
    method: "get"
  })
}

export const GetBrandList = (page: number, limit: number): Promise<ResponseData<BrandViewData>> => {
  return HttpRequest({
    url: "/wx/brand/list",
    method: "get",
    params: {
      page,
      limit
    }
  })
}

export const GetBrandDetail = (id: number): Promise<ResponseData<BrandDetailModel>> => {
  return HttpRequest({
    url: "/wx/brand/detail",
    method: "get",
    params: {
      id
    }
  })
}

export const GetBrandDetailList = (brandId: number): Promise<ResponseData<BrandDetailViewData>> => {
  return HttpRequest({
    url: "/wx/goods/list",
    method: "get",
    params: {
      brandId
    }
  })
}

export const GetGroupBuyList = (page: number, limit: number): Promise<ResponseData<GroupBuyViewData>> => {
  return HttpRequest({
    url: "/wx/groupon/list",
    method: "get",
    params: {
      page,
      limit
    }
  })
}

export const GetNewArrivalList =
  (isNew: boolean, page: number, limit: number): Promise<ResponseData<NewArrivalViewData>> => {
    return HttpRequest({
      url: "/wx/goods/list",
      method: "get",
      params: {
        isNew,
        page,
        limit
      }
    })
  }

export const GetHostGoodsList =
  (isHot: boolean, page: number, limit: number): Promise<ResponseData<NewArrivalViewData>> => {
    return HttpRequest({
      url: "/wx/goods/list",
      method: "get",
      params: {
        isHot,
        page,
        limit
      }
    })
  }

export const GetTopData = (id: number): Promise<ResponseData<TopicViewData>> => {
  return HttpRequest({
    url: "/wx/topic/detail",
    method: "get",
    params: {
      id
    }
  })
}

export const GetTopMoreData = (page: number, limit: number): Promise<ResponseData<TopicMoreViewData>> => {
  return HttpRequest({
    url: "/wx/topic/list",
    method: "get",
    params: {
      page,
      limit
    }
  })
}

interface FastData {
  errno: number,
  data: number,
  errmsg: string
}
interface fastObj{
  goodsId:number,
  number:number,
  productId:number
}
export const PostFastAdd = (goodsId: number, number: number, productId: number): Promise<FastData> => {
  const obj:fastObj = {
    goodsId,
    number,
    productId
  }
  return HttpRequest({
    url: "/wx/cart/fastadd",
    method: "post",
    data: obj
  })
}