export interface SpecificationModel {
  name: string;
  valueList: SpecificationValue[];
}

export interface SpecificationValue {
  id: number;
  goodsId: number;
  specification: string; // 注意这里的字段名是 specification，不是 attribute
  value: string;
  picUrl: string;
  addTime: string;
  updateTime: string;
  deleted: boolean;
}