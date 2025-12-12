export interface ResponseData<T> {
  errno: number,
  data: T,
  errmsg: string
}
