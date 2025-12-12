// 1.导入模块
import axios, { InternalAxiosRequestConfig, AxiosResponse, AxiosError } from "@ohos/axios"

// 2.创建axios实例
export const HttpRequest = axios.create({
  // 指向局域网后端
  baseURL: "http://10.21.213.157:5344"
})

// 3.设置拦截器
HttpRequest.interceptors.request.use((request: InternalAxiosRequestConfig) => {
  request.headers["x-litemall-token"] = AppStorage.get("token")
  return request; // 请求拦截器：可以设置token cookie ...
}, (error: AxiosError) => {
  return Promise.reject(error);
})

HttpRequest.interceptors.response.use((response: AxiosResponse) => {
  return response.data; // 响应拦截器
}, (error: AxiosError) => {
  return Promise.reject(error);
})
