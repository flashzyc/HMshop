import { HttpRequest } from "../utils/HttpRequest"
import { ResponseData } from "../utils/ResponseData"
import { AddressViewData } from "../viewmodel/AddressViewData"

export const GetAddressList = (): Promise<ResponseData<AddressViewData>> => {
  return HttpRequest({
    url: "/wx/address/list",
    method: "get",
  })
}

interface FastData {
  errno: number,
  data?: number,
  errmsg: string
}
interface Address {
  name: string;
  tel: string;
  country: string;
  province: string;
  city: string;
  county: string;
  areaCode: string;
  postalCode: string;
  addressDetail: string;
  isDefault: boolean;
}

export const PostAddressDelete = (): Promise<FastData> => {
  return HttpRequest({
    url: "/wx/address/delete",
    method: "post",
  })
}

export const PostSaveAddress = (obj:Address): Promise<FastData> => {
  const params = obj;
  return HttpRequest({
    url: "/wx/address/save",
    method: "post",
    data: params
  })
}