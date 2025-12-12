export interface AddressModel {
  id: number;
  name: string;
  userId: number;
  province: string;
  city: string;
  county: string;
  addressDetail: string;
  areaCode: string;
  postalCode: string;
  tel: string;
  isDefault: boolean;
  addTime: string;
  updateTime: string;
  deleted: boolean;
}