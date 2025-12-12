import { CurrentCategoryModel } from "./CurrentCategoryModel";
import { FilterCategoryListModel } from "./FilterCategoryListModel"

export interface ToCategoryListModel {
  total: number,
  pages: number,
  limit: number,
  page: number,
  list: Array<CurrentCategoryModel>,
  filterCategoryList: Array<FilterCategoryListModel>
}