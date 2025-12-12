import { UserInfoModel } from "../model/UserInfoModel"

export interface LoginViewData {
  userInfo: UserInfoModel;
  token: string;
}