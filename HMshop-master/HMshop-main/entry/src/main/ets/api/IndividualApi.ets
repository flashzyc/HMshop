import { HttpRequest } from "../utils/HttpRequest"
import { ResponseData } from "../utils/ResponseData"
import { IndividualViewModel } from "../viewmodel/IndividualViewModel"

export const GetIndividual = (): Promise<ResponseData<IndividualViewModel>> => {
  return HttpRequest({
    url: "/wx/user/index",
    method: "get"
  })
}