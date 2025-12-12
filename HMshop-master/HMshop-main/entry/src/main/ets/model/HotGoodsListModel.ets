export interface HotGoodsListModel {
  id: number;
  name: string;
  brief: string;
  picUrl: string;
  isNew: boolean;
  isHot: boolean;
  counterPrice: number;
  retailPrice: number;
}