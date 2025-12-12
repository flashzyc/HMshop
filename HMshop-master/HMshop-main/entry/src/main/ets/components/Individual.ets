import { GetIndividual } from "../api/IndividualApi"

@Component
export struct Individual {
  @State username: string = AppStorage.get("nickName") as string
  @State userImg: string = AppStorage.get("avatarUrl") as string

  async aboutToAppear() {
    const ResData = await GetIndividual();
  }

  build() {
    Column() { //头像 用户名 部分
      Column() {
        //设置按钮
        Row() {
          Image($r('app.media.shezhi'))
            .width(24)
            .height(24)
            .fillColor(Color.White)
        }
        .onClick(()=>{
          this.getUIContext().getRouter().pushUrl({ url: "pages/InfoPage" })
        })
        .width('100%')
        .justifyContent(FlexAlign.End)
        .margin({ right: 20 })

        //头像
        Row() {
          Image(this.userImg = "http://hmapp.net/static/img/avatar_default.89845f4e.png")
            .width(45)
            .height(45)
            .borderRadius("50%")
        }
        .justifyContent(FlexAlign.Center)
        .width('100%')

        //用户名
        Row() {
          Text(this.username == "" ? "未命名" : this.username)
            .fontColor(Color.White)
            .fontSize(16)
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
      }
      .height(175)
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
      .backgroundImage("http://hmapp.net/static/img/user_head_bg.38dfa566.png")
      .backgroundImageSize({ width: '100%', height: '100%' })

      //分割线
      Row() {

      }
      .backgroundColor('#F2F2F2')
      .height(10)
      .width('100%')

      //订单  部分
      Column() {
        //我的订单
        Row() {
          Text('我的订单')
            .fontSize(14)
            .fontColor('#323233')
            .lineHeight(24)
            .margin({ left: 10 })
          Text('全部订单 >')
            .fontSize(12)
            .fontColor('#999999')
            .margin({ right: 10 })
            .onClick(() => {
              this.getUIContext().getRouter().pushUrl({ url: "pages/OrderPage", params: { index: 0 } })
            })
        }
        .width('100%')
        .padding({ top: 10, bottom: 10 })
        .justifyContent(FlexAlign.SpaceBetween)

        //订单部分
        Row() {
          Column() {
            Image($r('app.media.k1'))
              .height(25).width(25)
              .margin({ top: 5, bottom: 5 })
            Text('待付款')
              .fontSize(12)
              .fontColor(Color.Black)
          }.onClick(() => {
            this.getUIContext().getRouter().pushUrl({ url: "pages/OrderPage", params: { index: 1 } })
          })

          Column() {
            Image($r('app.media.k2'))
              .height(25).width(25)
              .margin({ top: 5, bottom: 5 })
            Text('待发货')
              .fontSize(12)
              .fontColor(Color.Black)
          }.onClick(() => {
            this.getUIContext().getRouter().pushUrl({ url: "pages/OrderPage", params: { index: 2 } })
          })

          Column() {
            Image($r('app.media.k3'))
              .height(25).width(25)
              .margin({ top: 5, bottom: 5 })
            Text('待收货')
              .fontSize(12)
              .fontColor(Color.Black)
          }.onClick(() => {
            this.getUIContext().getRouter().pushUrl({ url: "pages/OrderPage", params: { index: 3 } })
          })

          Column() {
            Image($r('app.media.k4'))
              .height(25).width(25)
              .margin({ top: 5, bottom: 5 })
            Text('已完成')
              .fontSize(12)
              .fontColor(Color.Black)
          }.onClick(() => {
            this.getUIContext().getRouter().pushUrl({ url: "pages/OrderPage", params: { index: 4 } })
          })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceAround)
        .margin({ bottom: 10 })
      }
      .backgroundColor(Color.White)

      //分割线
      Row() {

      }
      .backgroundColor('#F2F2F2')
      .height(10)
      .width('100%')

      //优惠券部分
      Row() {
        Column() {
          //我的优惠券
          Row() {
            Text('我的优惠券')
              .fontSize(14)
              .fontColor('#323233')
              .lineHeight(24)
              .margin({ left: 10 })
            Text('全部优惠券 >')
              .fontSize(12)
              .fontColor('#999999')
              .margin({ right: 10 })
              .onClick(() => {
                this.getUIContext().getRouter().pushUrl({ url: "pages/CouponPage", params: { index: 0 } })
              })
          }
          .width('100%')
          .padding({ top: 10, bottom: 10 })
          .justifyContent(FlexAlign.SpaceBetween)

          //优惠券部分
          Row() {
            Column() {
              Image($r('app.media.wait_pay'))
                .height(25).width(25)
                .margin({ top: 5, bottom: 5 })
              Text('待使用')
                .fontSize(12)
                .fontColor(Color.Black)
            }.onClick(() => {
              this.getUIContext().getRouter().pushUrl({ url: "pages/CouponPage", params: { index: 0 } })
            })

            Column() {
              Image($r('app.media.wait_get'))
                .height(25).width(25)
                .margin({ top: 5, bottom: 5 })
              Text('已使用')
                .fontSize(12)
                .fontColor(Color.Black)
            }.onClick(() => {
              this.getUIContext().getRouter().pushUrl({ url: "pages/CouponPage", params: { index: 1 } })
            })

            Column() {
              Image($r('app.media.wait_pay2'))
                .height(25).width(25)
                .margin({ top: 5, bottom: 5 })
              Text('已过期')
                .fontSize(12)
                .fontColor(Color.Black)
            }.onClick(() => {
              this.getUIContext().getRouter().pushUrl({ url: "pages/CouponPage", params: { index: 2 } })
            })
          }
          .width('100%')
          .padding({ bottom: 10 })
          .justifyContent(FlexAlign.SpaceAround)
        }
        .width('100%')
      }
      .backgroundColor(Color.White)

      //分割线
      Row() {

      }
      .backgroundColor('#F2F2F2')
      .height(10)
      .width('100%')

      //收藏， 地址， 服务中心
      Column() {
        Row() {
          Image($r('app.media.nice'))
            .height(15)
            .width(15)
          Row() {
            Text('我的收藏')
              .fontSize(12)
              .fontColor(Color.Black)
            Text('>')
              .fontSize(12)
              .fontColor('#999999')
          }
          .width('90%')
          .justifyContent(FlexAlign.SpaceBetween)
          .margin({
            left: 5,
            right: 5,
            top: 10,
            bottom: 10
          })
          .onClick(()=>{
            this.getUIContext().getRouter().pushUrl({url: "pages/CollectPage"})
          })
        }
        .width('100%')

        //分割线
        Divider()
          .color('#F2F2F2')

        Row() {
          Image($r('app.media.address'))
            .height(15)
            .width(15)
          Row() {
            Text('收货地址')
              .fontSize(12)
              .fontColor(Color.Black)
            Text('>')
              .fontSize(12)
              .fontColor('#999999')
          }
          .width('90%')
          .justifyContent(FlexAlign.SpaceBetween)
          .margin({
            left: 5,
            right: 5,
            top: 10,
            bottom: 10
          })
          .onClick(()=>{
            this.getUIContext().getRouter().pushUrl({url: "pages/AddressPage"})
          })
        }
        .width('100%')

        //分割线
        Divider()
          .color('#F2F2F2')

        Row() {
          Image($r('app.media.serve_center'))
            .height(15)
            .width(15)
          Row() {
            Text('服务中心')
              .fontSize(12)
              .fontColor(Color.Black)
            Text('>')
              .fontSize(12)
              .fontColor('#999999')
          }
          .width('90%')
          .justifyContent(FlexAlign.SpaceBetween)
          .margin({
            left: 5,
            right: 5,
            top: 10,
            bottom: 10
          })
        }
        .width('100%')
        .onClick(()=>{
          this.getUIContext().getPromptAction().showToast({message: '功能开发中...'})
        })
      }
      .padding({left:20 ,right:20,top:4,bottom:4})
      .backgroundColor(Color.White)
    }
    .height('100%')
    .width('100%')
    .backgroundColor("#f2f2f2")
  }
}