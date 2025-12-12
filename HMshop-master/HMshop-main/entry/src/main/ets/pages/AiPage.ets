import { AiRecommend } from "../components/AiRecommend";
import router from "@ohos.router";

@Entry
@Component
struct AiPage {
  build() {
    Column() {
      // 顶部返回
      Row() {
        Text("←")
          .fontSize(20)
          .fontColor("#333")
          .onClick(() => router.back())
        Text("AI 智能导购")
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .margin({ left: 10 })
      }
      .width("100%")
      .padding({ left: 12, right: 12, top: 12, bottom: 8 })
      .backgroundColor(Color.White)
      .justifyContent(FlexAlign.Start)
      .alignItems(VerticalAlign.Center)

      // AI 内容
      AiRecommend()
        .layoutWeight(1)
        .width("100%")
    }
    .width("100%")
    .height("100%")
    .backgroundColor("#f5f5f5")
  }
}
