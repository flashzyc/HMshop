import { GetNewArrivalList } from '../api/HomeApi';
import { NewGoodsListModel } from '../model/NewGoodsListModel';
import { BackBar } from '../view/BackBar';

@Entry
@Component
struct NewArrivalPage {
  @State list: NewGoodsListModel[] = []
  @State page: number = 1;
  // 加载更多时添加防抖和加载状态
  @State isLoading: boolean = false;

  async aboutToAppear() {
    const ResData = await GetNewArrivalList(true, 1, 10);
    this.list = ResData.data.list;
  }

  async getMoreList() {
    if (!this.isLoading) {
      this.isLoading = true;
      this.page++;
      const ResData = await GetNewArrivalList(true, this.page, 10);
      this.list = this.list.concat(ResData.data.list);
      if (ResData.data.list.length < 10) {
        this.isLoading = true;
      }else {
        this.isLoading = false;
      }
    }
  }

  @Builder
  grouponListItem(item: NewGoodsListModel) {
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
          Text() {
            Span("￥").fontSize(12)
            Span(item.counterPrice.toString()).fontSize(14)
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
      Scroll(){
        Column(){
          Stack() {
            Image("http://yanxuan.nosdn.127.net/8976116db321744084774643a933c5ce.png")
              .height(250)
              .width('100%')
              .objectFit(ImageFit.Cover)
            Text("新品首发").fontSize(20).fontColor("#fff").textAlign(TextAlign.Center)
          }

          List() {
            ForEach(this.list, (item: NewGoodsListModel) => {
              ListItem() {
                this.grouponListItem(item)
              }
              .width("90%")
              .padding(10)
              .margin({ bottom: 10 })
              .backgroundColor(Color.White)
              .align(Alignment.Start)
              .onClick(() => {
                this.getUIContext().getRouter().pushUrl({
                  url: "pages/DetailPage",
                  params: {
                    did: item.id
                  }
                })
              })
            })
          }.width("100%").alignListItem(ListItemAlign.Center).margin({ top: 10, bottom: 10 }).onReachEnd(() => {
            this.getMoreList()
          })

          Row() {
            Text("没有更多了").fontSize(20).fontColor("#ffb5b5b5").textAlign(TextAlign.Center)
          }.width("100%").justifyContent(FlexAlign.Center).margin({bottom:60})
        }
      }
    }
    .backgroundColor("#f2f2f2")
    .height('100%')
    .width('100%')
  }
}