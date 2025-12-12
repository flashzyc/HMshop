@Component
export struct SearchBar {
  build() {
    Row() {
      Row() {
        Image($r("app.media.search")).width(16).height(16).margin({ left: 10 })
        Text("点击前往搜索").fontSize(14).fontColor("#8a8a8a").margin({ left: 4 })
      }
      .width("89%")
      .height(30)
      .margin({
        left: 20,
        right: 20,
        top: 10,
        bottom: 10
      })
      .backgroundColor("#ffececec")
      .borderRadius(4)
      .onClick(() => {
        this.getUIContext().getRouter().pushUrl({url: "pages/SearchPage"})
      })
    }.width("100%").height(50).backgroundColor(Color.White)
  }
}