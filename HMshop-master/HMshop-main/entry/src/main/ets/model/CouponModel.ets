export interface CouponModel {
  id: number;
  cid: number;
  name: string;
  desc: string;
  tag: string;
  min: number;
  discount: number;
  startTime: string;
  endTime: string;
  available: boolean;
}