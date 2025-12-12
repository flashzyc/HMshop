export interface TopicModel {
  id: number;
  title: string;
  subtitle: string;
  price: number;
  readCount: string;
  picUrl: string;
  sortOrder: number;
  goods: [];
  addTime: string;
  updateTime: string;
  deleted: boolean;
  content: string;
}