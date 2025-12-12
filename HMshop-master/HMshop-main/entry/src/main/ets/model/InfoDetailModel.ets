export interface InfoDetailModel {
  id: number;
  goodsSn: string;
  name: string;
  categoryId: number;
  brandId: number;
  gallery: string[];
  keywords: string;
  brief: string;
  isOnSale: boolean;
  sortOrder: number;
  picUrl: string;
  shareUrl: string;
  isNew: boolean;
  isHot: boolean;
  unit: string;
  counterPrice: number;
  retailPrice: number;
  addTime: string;
  updateTime: string;
  deleted: boolean;
  detail: string;
}
