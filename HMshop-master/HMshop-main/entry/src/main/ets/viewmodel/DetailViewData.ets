import { InfoDetailModel } from "../model/InfoDetailModel"
import { AttributeModel } from "../model/AttributeModel"
import { SpecificationModel } from "../model/SpecificationModel"
import { GoodsSKUModel } from "../model/GoodsSKUModel"

export interface DetailViewData {
  info: InfoDetailModel,
  attribute: Array<AttributeModel>,
  specificationList: Array<SpecificationModel>,
  productList: Array<GoodsSKUModel>
}
