export interface FilterCategoryListModel {
  id: number; // 唯一标识符
  name: string; // 类别名称
  keywords: string | null; // 关键词，可能是空字符串或 null
  desc: string; // 类别描述
  pid: number; // 父级类别 ID
  iconUrl: string; // 图标 URL
  picUrl: string; // 图片 URL
  level: string; // 类别层级
  sortOrder: number; // 排序顺序
  addTime: string; // 添加时间 (字符串格式)
  updateTime: string; // 更新时间 (字符串格式)
  deleted: boolean; // 是否已被删除
}