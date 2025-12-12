import { ChatWithAi } from "../api/AiApi"
import { NewGoodsListModel } from "../model/NewGoodsListModel"
import router from '@ohos.router'

class ChatMessage {
  isUser: boolean
  content: string
  recommendations?: NewGoodsListModel[]

  constructor(isUser: boolean, content: string, recommendations?: NewGoodsListModel[]) {
    this.isUser = isUser
    this.content = content
    this.recommendations = recommendations
  }
}

@Component
export struct AiRecommend {
  @State messages: Array<ChatMessage> = []
  @State inputText: string = ""
  @State isLoading: boolean = false
  scroller: Scroller = new Scroller()

  aboutToAppear() {
    // 初始欢迎语
    this.messages.push(new ChatMessage(false, "你好！我是你的智能购物助手。告诉我你想买什么，或者让我为你推荐一些好物。"))
  }

  async sendMessage() {
    if (this.inputText.trim().length === 0 || this.isLoading) {
      return
    }

    const userMsg = this.inputText
    this.messages.push(new ChatMessage(true, userMsg))
    this.inputText = ""
    this.isLoading = true
    this.scroller.scrollEdge(Edge.Bottom)

    try {
      const res = await ChatWithAi(userMsg)
      if (res.errno === 0 && res.data) {
        this.messages.push(new ChatMessage(false, res.data.reply, res.data.recommendations))
      } else {
        this.messages.push(new ChatMessage(false, "抱歉，我遇到了一些问题，请稍后再试。"))
      }
    } catch (e) {
      this.messages.push(new ChatMessage(false, "网络连接失败，请检查网络。"))
    } finally {
      this.isLoading = false
      this.scroller.scrollEdge(Edge.Bottom)
    }
  }

  @Builder
  ProductCard(item: NewGoodsListModel) {
    Column() {
      Image(item.picUrl).width(100).height(100).borderRadius(8)
      Text(item.name)
        .fontSize(12)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .margin({ top: 5 })
      Text("¥" + item.retailPrice)
        .fontSize(14)
        .fontColor(Color.Red)
        .fontWeight(FontWeight.Bold)
    }
    .width(110)
    .padding(5)
    .backgroundColor(Color.White)
    .borderRadius(8)
    .margin({ right: 8 })
    .onClick(() => {
      router.pushUrl({
        url: 'pages/DetailPage',
        params: { did: item.id }
      })
    })
  }

  build() {
    Column() {
      // 标题栏
      Text("AI 智能导购")
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding(12)
        .backgroundColor(Color.White)
        .shadow({ radius: 2, color: '#1A000000', offsetY: 1 })

      // 聊天记录区域
      List({ scroller: this.scroller }) {
        ForEach(this.messages, (msg: ChatMessage) => {
          ListItem() {
            Column() {
              // 消息气泡
              Row() {
                if (msg.isUser) {
                  Blank()
                  Text(msg.content)
                    .fontSize(16)
                    .fontColor(Color.White)
                    .padding(12)
                    .backgroundColor('#007AFF')
                    .borderRadius({ topLeft: 16, topRight: 4, bottomLeft: 16, bottomRight: 16 })
                    .margin({ left: 40 })
                } else {
                  Column() {
                    Text(msg.content)
                      .fontSize(16)
                      .fontColor('#333')
                      .padding(12)
                      .backgroundColor(Color.White)
                      .borderRadius({ topLeft: 4, topRight: 16, bottomLeft: 16, bottomRight: 16 })
                      .margin({ right: 40 })
                    
                    // 推荐商品列表
                    if (msg.recommendations && msg.recommendations.length > 0) {
                      List({ space: 0, initialIndex: 0 }) {
                        ForEach(msg.recommendations, (item: NewGoodsListModel) => {
                          ListItem() {
                            this.ProductCard(item)
                          }
                        })
                      }
                      .listDirection(Axis.Horizontal)
                      .height(160)
                      .width('100%')
                      .margin({ top: 10 })
                    }
                  }
                  .alignItems(HorizontalAlign.Start)
                  Blank()
                }
              }
              .width('100%')
              .padding({ left: 12, right: 12, top: 8, bottom: 8 })
            }
          }
        })

        if (this.isLoading) {
          ListItem() {
            Row() {
              Column() {
                Text("正在思考中......")
                  .fontSize(14)
                  .fontColor('#999')
                  .padding(12)
                  .backgroundColor(Color.White)
                  .borderRadius({ topLeft: 4, topRight: 16, bottomLeft: 16, bottomRight: 16 })
                  .margin({ right: 40 })
              }
              .alignItems(HorizontalAlign.Start)
              Blank()
            }
            .width('100%')
            .padding({ left: 12, right: 12, top: 8, bottom: 8 })
          }
        }
      }
      .layoutWeight(1)
      .width('100%')
      .backgroundColor('#f5f5f5')

      // 底部输入框
      Row() {
        TextInput({ placeholder: "我想买...", text: $$this.inputText })
          .layoutWeight(1)
          .height(40)
          .backgroundColor(Color.White)
          .borderRadius(20)
          .padding({ left: 16, right: 16 })
          .onSubmit(() => this.sendMessage())
        
        Button(this.isLoading ? "..." : "发送")
          .height(40)
          .width(70)
          .margin({ left: 10 })
          .backgroundColor('#db3d3c')
          .borderRadius(20)
          .onClick(() => this.sendMessage())
      }
      .padding(10)
      .backgroundColor('#f0f0f0')
    }
    .width('100%')
    .height('100%')
  }
}
