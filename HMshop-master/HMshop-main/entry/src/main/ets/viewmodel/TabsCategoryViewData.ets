import { TabsCategoryModel } from "../model/TabsCategoryModel"
import { NewCurrentCategoryModel } from "../model/NewCurrentCategoryModel"
import { CurrentSubCategoryModel } from "../model/CurrentSubCategoryModel"

export interface TabsCategoryViewData {
  categoryList: Array<TabsCategoryModel>
  currentCategory: NewCurrentCategoryModel
  currentSubCategory: Array<CurrentSubCategoryModel>
}