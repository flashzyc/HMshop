import { BackBar } from "../view/BackBar"

@Entry
@Component
struct ForgetPage {
  build() {
    RelativeContainer() {
      Column() {
        BackBar()

        Row() {
          Image($r('app.media.phone'))
            .width(20)
            .height(20)
            .margin({ left: 8 })

          TextInput({ placeholder: '请输入手机号' })
            .layoutWeight(1)
            .backgroundColor("transparent")
        }.width("90%").border({ width: 1, color: "#FFD7D5D5", radius: 5 }).margin({ top:20,bottom: 20 })

        Row() {
          Image($r('app.media.password'))
            .width(20)
            .height(20)
            .margin({ left: 8 })

          TextInput({ placeholder: '请输入短信验证码' })
            .layoutWeight(1)
            .backgroundColor("transparent")

          Text("获取验证码")
            .margin({ left: 4 ,right: 4})
            .fontColor("#ffc40e23")
        }.width("90%").border({ width: 1, color: "#FFD7D5D5", radius: 5 }).margin({ bottom: 10 })

        Button("下一步")
          .width("90%")
          .margin({ top: 20 })
          .borderRadius(4)
          .backgroundColor("#ffc40e23")

      }
    }
    .height('100%')
    .width('100%')
  }
}