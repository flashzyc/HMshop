import { PostPay } from "../api/PayApi"
import { PostSubmitOrder, SubmitOrderRequest, GetOrderInfo,  } from "../api/SubmitApi"

import { SubmitModel } from "../model/SubmitModel"
import { BackBar } from "../view/BackBar"

@Entry
@Component
struct SubmitPage {
  submitParams: SubmitOrderRequest = {
    addressId: "0",
    cartId: "0",
    couponId: "0",
    userCouponId: "0",
    grouponLinkId: 0,
    grouponRulesId: 0,
    message: ""
  }
  @State orderId: number = 0;
  @State grouponLinkId: number = 0;
  @State payed: boolean = false;
  @State actualPrice: number = 0;

  async aboutToAppear() {
    const params = this.getUIContext().getRouter().getParams() as Partial<SubmitOrderRequest> | undefined;
    this.submitParams = {
      addressId: params?.addressId?.toString() ?? "0",
      cartId: params?.cartId?.toString() ?? "0",
      couponId: params?.couponId?.toString() ?? "0",
      userCouponId: params?.userCouponId?.toString() ?? "0",
      grouponLinkId: params?.grouponLinkId ?? 0,
      grouponRulesId: params?.grouponRulesId ?? 0,
      message: params?.message ?? ""
    };

    const ResData = await PostSubmitOrder(this.submitParams);
    if (ResData.errno != 0) {
      this.getUIContext().getPromptAction().showToast({ message: ResData.errmsg })
      this.getUIContext().getRouter().back();
    } else {
      this.orderId = ResData.data.orderId;
      this.grouponLinkId = ResData.data.grouponLinkId;
      this.payed = ResData.data.payed;
      const OrderData = await GetOrderInfo(this.orderId);
      this.actualPrice = OrderData.data.orderInfo.actualPrice;
    }
  }

  async goToPay(orderId: number) {
    console.log("开始支付")
    const ResData = await PostPay(orderId);
    console.log(JSON.stringify(ResData))
    if (ResData.errno != 0) {
      this.getUIContext().getPromptAction().showToast({ message: ResData.errmsg })
      console.log("支付失败")
    } else {
      this.getUIContext().getPromptAction().showToast({ message: ResData.errmsg })
      console.log("支付成功")
      this.payed = true;
      this.getUIContext().getRouter().replaceUrl({ url: "pages/HomePage" });
    }
  }

  build() {
    Column() {
      BackBar();
      Column() {
        Row() {
          Text("请在").fontSize(14)
          Text("半小时内").fontColor("#db3d3c").fontSize(14)
          Text("完成付款，否则系统自动取消订单").fontSize(14)
        }.width("100%").backgroundColor("#fffeec").padding({ top: 10, bottom: 10, left: 20 }).margin({ bottom: 20 })

        Row() {
          Text("订单编号：")
          Text(this.grouponLinkId.toString()).fontColor("#969799")
        }
        .width("100%")
        .padding({
          left: 20,
          right: 20,
          top: 10,
          bottom: 10
        })
        .backgroundColor(Color.White)
        .justifyContent(FlexAlign.SpaceBetween)

        Row() {
          Text("实付金额：")
          Text(`￥${this.actualPrice}`).fontColor("#db3d3c")
        }
        .width("100%")
        .padding({
          left: 20,
          right: 20,
          top: 10,
          bottom: 10
        })
        .backgroundColor(Color.White)
        .justifyContent(FlexAlign.SpaceBetween)

        Column() {
          Row() {
            Text("请选择支付方式")
          }.width("100%").padding({ top: 10, bottom: 10, left: 20 })

          Row() {
            Image("http://hmapp.net/static/img/ali_pay.41a79780.png").height(30)
            Radio({ value: 'wxPay', group: 'radioGroup' }).checked(true)
          }
          .width("100%")
          .padding({
            top: 10,
            bottom: 10,
            left: 20,
            right: 20
          })
          .justifyContent(FlexAlign.SpaceBetween)

          Row() {
            Image("http://hmapp.net/static/img/wx_pay.2731abb7.png").height(30)
            Radio({ value: 'zfbPay', group: 'radioGroup' }).checked(false)
          }
          .width("100%")
          .padding({
            top: 10,
            bottom: 10,
            left: 20,
            right: 20
          })
          .justifyContent(FlexAlign.SpaceBetween)
        }.width("100%").backgroundColor(Color.White).margin({ top: 20 })
      }.layoutWeight(1)

      Row() {
        Button("去支付")
          .width("100%")
          .borderRadius(0)
          .fontColor(Color.White)
          .alignSelf(ItemAlign.Center)
          .backgroundColor("#07c160")
          .onClick(() => {
            this.goToPay(this.orderId)
          })
      }
      .height(50)
      .alignItems(VerticalAlign.Bottom)
      .width('100%')
      .backgroundColor("#07c160")
      .justifyContent(FlexAlign.End)
    }
    .height('100%')
    .width('100%')
    .backgroundColor("#f2f2f2")
  }
}
