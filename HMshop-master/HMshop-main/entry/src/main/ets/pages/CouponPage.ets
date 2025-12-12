import { CouponModel } from "../model/CouponModel"
import { GetCoupon } from "../api/CouponApi"
import { BackBar } from "../view/BackBar";

@Entry
@Component
struct CouponPage {
  @State status: number = 0;
  @State page: number = 1;
  @State limit: number = 10;
  @State list: Array<CouponModel> = [];

  aboutToAppear() {
    const params = this.getUIContext().getRouter().getParams() as Record<string, Object>;
    if (params && params.index) {
      this.status = params.index as number;
    }
    this.changeTabBar(this.status)
  }

  async changeTabBar(index: number) {
    const ResData = await GetCoupon(index, this.page, this.limit);
    if (ResData.errno != 0) {
      this.getUIContext().getRouter().pushUrl({ url: "pages/LoginPage" })
      this.getUIContext().getPromptAction().showToast({ message: ResData.errmsg })
    }
    this.list = ResData.data.list;
  }

  @Builder
  selfTabBar(index:number ,name: string) {
    Column() {
      Row(){
        Text(name)
          .fontColor(this.status === index ? "#fff" : "#ee0a24")
          .fontSize(16)
          .lineHeight(22)
          .margin({ top: 6, bottom: 6 ,left: 20, right: 20})
      }.width('80%').border({width: 1,color: "#ee0a24"}).backgroundColor(index === this.status ? "#ee0a24" : "#fff")
    }.backgroundColor("#fff")
  }

  @Builder
  noDataShow() {
    Column() {
      Image($r("app.media.gowu"))
        .width(100)
        .height(100)
        .margin({ bottom: 20 })
      Text("暂无优惠券")
        .fontColor("#999")
        .fontSize(14)
    }
    .width("100%")
    .height("100%")
    .justifyContent(FlexAlign.Center)
  }

  @Builder
  couponListItem(item: CouponModel) {
    Row() {
      Column() {
        Text() {
          Span("￥")
            .fontSize(12)
            .fontColor(Color.Red)
          Span(item.discount.toString() + "元")
            .fontSize(24)
            .fontColor(Color.Red)
        }

        Text(`${item.desc}-${item.tag}`)
          .fontColor("#ff858080")
          .fontSize(12)
      }
      .alignItems(HorizontalAlign.Start)
      .width("40%")

      Column() {
        Text(item.name)
          .fontSize(18)
        Text(`有效期：${item.endTime}`)
          .fontColor("#ff858080")
          .fontSize(12)
      }
      .alignItems(HorizontalAlign.Start)
      .margin({ left: 20 })
    }
    .width("100%")
  }

  build() {
    Column() {
      BackBar()
      Tabs({ index: this.status }) {
        TabContent() {
          if (this.list.length > 0) {
            Column(){
              List({ space: 20 }) {
                ForEach(this.list, (item: CouponModel) => {
                  ListItem() {
                    this.couponListItem(item)
                  }
                  .border({
                    width: 1,
                    color: Color.Red,
                    style: BorderStyle.Solid
                  })
                  .padding({ left: 20, right: 20})
                  .height(70)
                  .backgroundColor("#fff")
                  .padding({ left: 20, right: 20})
                  .margin({left:10,right:10})
                })
              }.backgroundColor("#fff")
            }.justifyContent(FlexAlign.Start)
          } else {
            this.noDataShow()
          }
        }.tabBar(this.selfTabBar(0,"未使用"))
        .width('100%')
        .align(Alignment.Top)

        TabContent() {
          if (this.list.length > 0) {
            Column(){
              List({ space: 20 }) {
                ForEach(this.list, (item: CouponModel) => {
                  ListItem() {
                    this.couponListItem(item)
                  }
                  .border({
                    width: 1,
                    color: Color.Red,
                    style: BorderStyle.Solid
                  })
                  .padding({ left: 20, right: 20})
                  .height(70)
                  .backgroundColor("#fff")
                  .padding({ left: 20, right: 20})
                  .margin({left:10,right:10})
                })
              }.backgroundColor("#fff")
            }.justifyContent(FlexAlign.Start)
          } else {
            this.noDataShow()
          }
        }.tabBar(this.selfTabBar(1,"已使用"))
        .width('100%')
        .align(Alignment.Top)

        TabContent() {
          if (this.list.length > 0) {
            Column(){
              List({ space: 20 }) {
                ForEach(this.list, (item: CouponModel) => {
                  ListItem() {
                    this.couponListItem(item)
                  }
                  .border({
                    width: 1,
                    color: Color.Red,
                    style: BorderStyle.Solid
                  })
                  .padding({ left: 20, right: 20})
                  .height(70)
                  .backgroundColor("#fff")
                  .padding({ left: 20, right: 20})
                  .margin({left:10,right:10})
                })
              }.backgroundColor("#fff")
            }.justifyContent(FlexAlign.Start)
          } else {
            this.noDataShow()
          }
        }.tabBar(this.selfTabBar(2,"已过期"))
        .width('100%')
        .align(Alignment.Top)
      }
      .scrollable(false)
      .barBackgroundColor(Color.White)
      .onTabBarClick((index) => {
        this.page = 1; // 重置页码
        this.list = []; // 清空数据
        this.status = index;
        this.changeTabBar(index)
      })
    }
    .height('100%')
    .width('100%')
    .backgroundColor("#f2f2f2")
  }
}