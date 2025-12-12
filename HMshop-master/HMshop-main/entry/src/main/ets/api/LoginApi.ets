import { HttpRequest } from "../utils/HttpRequest"
import { ResponseData } from "../utils/ResponseData"
import { LoginViewData } from "../viewmodel/LoginViewData"

// 声明登录请求参数接口
interface LoginParams {
  username: string
  password: string
}

export const PostLogin = (username: string, password: string): Promise<ResponseData<LoginViewData>> => {
  const params: LoginParams = {
    username,
    password
  }

  return HttpRequest({
    url: "/wx/auth/login",
    method: "post",
    data: params
  })
}