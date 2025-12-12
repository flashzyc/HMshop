import { HttpRequest } from "../utils/HttpRequest"
import { ResponseData } from "../utils/ResponseData"

interface FastData {
  errno: number,
  errmsg: string
}

interface InfoViewData {
  gender: number,
  nickName: string,
  mobile: string,
  avatar: string
}

export const GetInfo = (): Promise<ResponseData<InfoViewData>> => {
  return HttpRequest({
    url: "/wx/auth/info",
    method: "get",
  })
}

export const PostLogout = (): Promise<FastData> => {
  return HttpRequest({
    url: "/wx/auth/logout",
    method: "post",
  })
}