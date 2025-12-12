import { PostLogin } from "../api/Index"
interface userinfo {
  nickName: string;
  avatarUrl: string;
}

@Entry
@Component
struct LoginPage {
  @State username: string = "";
  @State password: string = "";

  async login(username: string, password: string) {
    const ResData = await PostLogin(username, password);
    if (ResData.errno == 0) {
      this.getUIContext().getPromptAction().showToast({ message: ResData.errmsg });
      AppStorage.setOrCreate("token", ResData.data.token);
      AppStorage.setOrCreate("nickName", ResData.data.userInfo.nickName);
      AppStorage.setOrCreate("avatarUrl", ResData.data.userInfo.avatarUrl);
      this.getUIContext().getRouter().back();
    } else {
      this.getUIContext().getPromptAction().showToast({ message: ResData.errmsg });
      this.username = "";
      this.password = "";
    }
  }

  build() {
    Column() {
      Column() {
        Image("http://hmapp.net/static/img/avatar_default.89845f4e.png").width(55).height(55).borderRadius("50%")
        Text("HMShop").fontSize(14).margin({ top: 10 })
      }.width('100%').height(120).justifyContent(FlexAlign.Center).alignItems(HorizontalAlign.Center)

      Column() {
        Row() {
          Image($r('app.media.username'))
            .width(20)
            .height(20)
            .margin({ left: 8 })

          TextInput({ placeholder: '请输入用户名', text: $$this.username })
            .layoutWeight(1)
            .backgroundColor("transparent")
        }.width("90%").border({ width: 1, color: "#FFD7D5D5", radius: 5 }).margin({ bottom: 20 })

        Row() {
          Image($r('app.media.password'))
            .width(20)
            .height(20)
            .margin({ left: 8 })

          TextInput({ placeholder: '请输入密码', text: $$this.password })
            .type(InputType.Password)
            .layoutWeight(1) // 占据剩余空间
            .backgroundColor("transparent")
        }.width("90%").border({ width: 1, color: "#FFD7D5D5", radius: 5 }).margin({ bottom: 10 })
      }.width("100%").justifyContent(FlexAlign.Center)

      Row() {
        Text("免费注册").fontSize(14).onClick(()=>{
          this.getUIContext().getRouter().pushUrl({ url: "pages/RegisterPage" });
        })
        Text("忘记密码").fontSize(14).onClick(()=>{
          this.getUIContext().getRouter().pushUrl({ url: "pages/ForgetPage" });
        })
      }.width("90%").margin({ top: 4 }).justifyContent(FlexAlign.SpaceBetween)

      Button("登录")
        .width("90%")
        .margin({ top: 20 })
        .borderRadius(4)
        .backgroundColor("#ffc40e23")
        .onClick(() => {
          this.login(this.username, this.password)
        })
    }
    .height('100%')
    .width('100%')
  }
}