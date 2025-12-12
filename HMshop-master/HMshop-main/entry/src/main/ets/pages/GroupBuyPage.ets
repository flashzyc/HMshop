import { GetGroupBuyList } from "../api/HomeApi"
import { GroupBuyModel } from "../model/GroupBuyModel"
import { BackBar } from "../view/BackBar";

@Entry
@Component
struct GroupBuyPage {
  @State list:GroupBuyModel[] = []

  async aboutToAppear(){
    const ResData = await GetGroupBuyList(1,10);
    this.list = ResData.data.list;
  }
  @Builder
  grouponListItem(item: GroupBuyModel) {
    Row() {
      Column() {
        Image(item.picUrl).width(88).height(88)
      }

      Column() {
        Row() {
          Text(item.name)
        }

        Row() {
          Text(item.brief).fontColor("#646566")
        }

        Row() {
            Text(item.grouponMember + "人成团")
              .padding(2)
              .fontColor("#1989fa")
              .fontSize(12)
              .border({ width: 1, color: "#1989fa" })
            Text(item.grouponDiscount.toString() + "元再减")
              .padding(2)
              .margin({ left: 4 })
              .fontColor("#ee0a24")
              .fontSize(12)
              .border({ width: 1, color: "#ee0a24" })
        }.margin({ top: 4 })

        Row() {
          Text() {
            Span("￥").fontSize(12)
            Span(item.grouponPrice.toString()).fontSize(14)
            Span("￥" + item.retailPrice)
              .fontSize(10)
              .fontColor("#969799")
              .decoration({ type: TextDecorationType.LineThrough })
          }
        }.margin({ top: 10 })
      }.alignItems(HorizontalAlign.Start).margin({ left: 6 })
    }
  }

  build() {
    Column() {
      BackBar()
      Stack(){
        Image("http://yanxuan.nosdn.127.net/8976116db321744084774643a933c5ce.png").height(250).width('100%').objectFit(ImageFit.Cover)
        Text("团购专区").fontSize(20).fontColor("#fff").textAlign(TextAlign.Center)
      }
      List() {
        ForEach(this.list, (item: GroupBuyModel) => {
          ListItem() {
            this.grouponListItem(item)
          }.width("90%")
          .padding(10)
          .backgroundColor(Color.White)
          .align(Alignment.Start)
          .onClick(()=>{
            this.getUIContext().getRouter().pushUrl({
              url: "pages/DetailPage",
              params: {
                did: item.goodsId
              }
            })
          })
        })
      }.width("100%").alignListItem(ListItemAlign.Center).margin({ top: 10, bottom: 10 })
      Row(){
        Text("没有更多了").fontSize(20).fontColor("#ffb5b5b5").textAlign(TextAlign.Center)
      }
    }
    .backgroundColor("#f2f2f2")
    .height('100%')
    .width('100%')
  }
}
