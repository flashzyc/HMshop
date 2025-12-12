import { GetInfo, PostLogout } from '../api/Index';

@Entry
@Component
struct InfoPage {
  @State gender: number = 1;
  @State nickName: string = ""
  @State mobile: string = ""
  @State avatar: string = ""

  async aboutToAppear() {
    const ResData = await GetInfo()
    this.gender = ResData.data.gender
    this.nickName = ResData.data.nickName
    this.mobile = ResData.data.mobile
    this.avatar = ResData.data.avatar
  }

  build() {
    Column() {
      Row() {
        Text("姓名：").fontSize(16).fontColor("#646566").width(100)
        Text(this.nickName).fontSize(16)
      }
      .backgroundColor(Color.White)
      .width('100%')
      .padding({
        left: 20,
        right: 20,
        top: 10,
        bottom: 10
      })
      Row() {
        Text("手机号：").fontSize(16).fontColor("#646566").width(100)
        Text(this.mobile).fontSize(16)
      }
      .backgroundColor(Color.White)
      .width('100%')
      .padding({
        left: 20,
        right: 20,
        top: 10,
        bottom: 10
      })
      Row(){
        Button("退出登陆")
          .width("100%")
          .height(40)
          .backgroundColor("#ee0a24")
          .fontColor(Color.White)
          .onClick(async () => {
             const res = await PostLogout()
             if (res.errno == 0) {
              AppStorage.clear()
               this.getUIContext().getRouter().replaceUrl({url: "pages/HomePage"})
            }
          })
      }.width('100%')
      .height(60)
      .padding({ left: 20, right: 20, top: 10, bottom: 10 })
      .backgroundColor(Color.White)
    }
    .backgroundColor("#f2f2f2")
    .height('100%')
    .width('100%')
  }
}