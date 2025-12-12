import { BackBar } from "../view/BackBar"

@Entry
@Component
struct RegisterPage {
  build() {
    Column() {
      BackBar()

      Row() {
        Text("我们将验证码发送到您的手机").fontSize(14)
      }.width("90%").margin({ top: 20, bottom: 10 })

      Row() {
        Image($r('app.media.phone'))
          .width(20)
          .height(20)
          .margin({ left: 8 })

        TextInput({ placeholder: '请输入手机号' })
          .layoutWeight(1)
          .backgroundColor("transparent")
      }.width("90%").border({ width: 1, color: "#FFD7D5D5", radius: 5 }).margin({ bottom: 10 })

      Button("下一步")
        .width("90%")
        .margin({ top: 20 })
        .borderRadius(4)
        .backgroundColor("#ffc40e23")

      Row() {
        Text() {
          Span("已有帐号").fontSize(14)
          Span("登录").fontSize(14).fontColor("#ffc40e23")
        }.onClick(()=>{
          this.getUIContext().getRouter().pushUrl({ url: "pages/LoginPage"});
        })
      }.width("90%").margin({ top: 10 }).justifyContent(FlexAlign.End)
    }
    .height('100%')
    .width('100%')
  }
}