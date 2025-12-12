import { BannerModel } from "../model/BannerModel"
import { ChannelModel } from "../model/ChannelModel"
import { CouponListModel } from "../model/CouponListModel"
import { NewGoodsListModel } from "../model/NewGoodsListModel"
import { GrouponListModel } from "../model/GrouponListModel"
import { BrandListModel } from "../model/BrandListModel"
import { HotGoodsListModel } from "../model/HotGoodsListModel"
import { TopicListModel } from "../model/TopicListModel"
import { BrandDetailModel } from "../model/BrandDetailModel"
import { BrandDetailListModel } from "../model/BrandDetailListModel"
import { GroupBuyModel } from "../model/GroupBuyModel"
import { TopicModel } from "../model/TopicModel"
import { TopicMoreModel } from "../model/TopicMoreModel"

export interface HomeViewData {
  banner: Array<BannerModel>
  channel: Array<ChannelModel>
  couponList: Array<CouponListModel>
  newGoodsList: Array<NewGoodsListModel>
  grouponList: Array<GrouponListModel>
  brandList: Array<BrandListModel>
  hotGoodsList: Array<HotGoodsListModel>
  topicList: Array<TopicListModel>
}

export interface BrandViewData{
  list: Array<BrandListModel>
}

export interface BrandDetailViewData{
  list: Array<BrandDetailListModel>
}

export interface GroupBuyViewData{
  list: Array<GroupBuyModel>
}

export interface NewArrivalViewData{
  list: Array<NewGoodsListModel>
}

export interface TopicViewData{
  topic: TopicModel
}

export interface TopicMoreViewData{
  list: Array<TopicMoreModel>
}