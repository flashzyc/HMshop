import { HttpRequest } from "../utils/HttpRequest"
import { ResponseData } from "../utils/ResponseData"
import { NewGoodsListModel } from "../model/NewGoodsListModel"

export interface AiChatResponse {
  reply: string;
  recommendations: NewGoodsListModel[];
}

class ChatRequest {
  message: string
  constructor(message: string) {
    this.message = message
  }
}

export const GetAiRecommend = (): Promise<ResponseData<NewGoodsListModel[]>> => {

  return HttpRequest({
    url: "/wx/ai/recommend",
    method: "get"
  })
}

export const ChatWithAi = (message: string): Promise<ResponseData<AiChatResponse>> => {
  return HttpRequest({
    url: "/wx/ai/chat",
    method: "post",
    data: new ChatRequest(message)
  })
}


