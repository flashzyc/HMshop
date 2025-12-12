@Component
export struct BackBar {
  build() {
    Row() {
      Image($r("app.media.next")).rotate({ angle: 180 }).fillColor("#1989fa").width(16)
      Text("返回").fontColor("#1989fa")
    }.onClick(()=>{
      this.getUIContext().getRouter().back()
    })
    .width("100%")
    .height(50)
    .backgroundColor(Color.White)
    .padding({ left: 10 })
    .border({ width: { bottom: 1 }, color: { bottom: "#e4e7ed" } })
    .justifyContent(FlexAlign.Start)
    .alignItems(VerticalAlign.Center)
  }
}