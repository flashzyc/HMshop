import { BrotherCategoryModel } from "../model/BrotherCategoryModel"
import { CurrentCategoryModel } from "../model/CurrentCategoryModel"

export interface CategoryViewData {
  brotherCategory: Array<BrotherCategoryModel>
  currentCategory: CurrentCategoryModel
}
