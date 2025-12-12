import { GetCheckout } from "../api/ChectOutApi"
import { CheckedAddress, CheckedGoodsItem } from "../model/CheckoutModel"
import { BackBar } from "../view/BackBar"

@Entry
@Component
struct CheckoutPage {
  @State checkedGoodsList: CheckedGoodsItem[] = [];
  @State checkedAddress: Partial<CheckedAddress> = {};
  @State orderTotalPrice: number = 0;
  @State availableCouponLength: number = 0;
  @State goodsTotalPrice: number = 0;
  @State freightPrice: number = 0;
  @State couponPrice: number = 0;
  @State cartId:number = 0;
  @State addressId:number = 0;
  @State orderMessage: string = "";

  async aboutToAppear() {
    const params = this.getUIContext().getRouter().getParams() as Record<string, Object>;
    if (params && params.dataId) {
      this.cartId = params.dataId as number;
    }
    if(params && params.addressId){
      this.addressId = params.addressId as number;
    }
    const ResData = await GetCheckout(this.cartId, this.addressId, 0, 0, 0);
    this.checkedGoodsList = ResData.data.checkedGoodsList;
    this.checkedAddress = ResData.data.checkedAddress;
    this.orderTotalPrice = ResData.data.goodsTotalPrice;
    this.availableCouponLength = ResData.data.availableCouponLength;
    this.goodsTotalPrice = ResData.data.goodsTotalPrice;
    this.freightPrice = ResData.data.freightPrice;
    this.couponPrice = ResData.data.couponPrice;
  }

  @Builder
  PayListItem(item: CheckedGoodsItem) {
    Row() {
      // 商品图片
      Image(item.picUrl)
        .width(80)
        .height(80)
        .borderRadius(4)
        .margin({ right: 10 })

      // 商品信息
      Column() {
        Text(item.goodsName)
          .fontSize(14)
          .fontColor("#333")
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .margin({ bottom: 5 })

        Text(item.specifications.join(' '))
          .fontSize(12)
          .fontColor("#999")
          .margin({ bottom: 5 })

        Row() {
          Text(`￥${item.price.toFixed(2)}`)
            .fontSize(16)
            .fontColor("#ff0000")
            .fontWeight(FontWeight.Bold)

          Blank()

          Text(`x${item.number}`)
            .fontSize(14)
            .fontColor("#666")
        }
        .width("100%")
        .margin({ bottom: 5 })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width("100%")
    .padding(10)
    .backgroundColor(Color.White)
    .borderRadius(8)
    .margin({ bottom: 10 })
  }

  build() {
    Column() {
      // 返回
      BackBar()
      // 列表
      Scroll() {
        Column() {
          // 收货地址
          Column() {
            Row() {
              Text("收货地址").fontSize(18)
              Image($r("app.media.next")).width(18).height(18)
                .onClick(()=>{
                  this.getUIContext().getRouter().pushUrl({url:  "pages/AddressPage"})
                })
            }.justifyContent(FlexAlign.SpaceBetween).width('100%').padding({ left: 20, right: 20 ,bottom: 10,top:20})


            Row() {
              Text(this.checkedAddress.name).fontSize(14).fontColor("#969799")
              Text(this.checkedAddress.tel).fontSize(14).fontColor("#969799").margin({ left: 10 })
            }.justifyContent(FlexAlign.Start).width('100%').padding({ left: 20, right: 20 })

            Row() {
              Text(
                `${this.checkedAddress.province ?? ""}` +
                  `${this.checkedAddress.city ?? ""}` +
                  `${this.checkedAddress.county ?? ""}` +
                  `${this.checkedAddress.addressDetail ?? ""}` +
                  `${this.checkedAddress.areaCode ?? ""}` +
                  `${this.checkedAddress.postalCode ?? ""}`)
                .fontSize(14)
                .fontColor("#969799")
                .maxLines(1)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
            }.justifyContent(FlexAlign.Start).width('100%').padding({ left: 20, right: 20 ,bottom: 10})
          }.width('100%').backgroundColor(Color.White)

          // 优惠券
          Column() {
            if (this.availableCouponLength > 0) {
              Row() {
                Text("优惠券").fontSize(18)
                Image($r("app.media.next")).width(18).height(18)
              }.justifyContent(FlexAlign.SpaceBetween).width('100%').padding(20)
            } else {
              Row() {
                Text("优惠券").fontSize(18)
                Row(){
                  Text("没有更多的优惠可用")
                  Image($r("app.media.next")).width(18).height(18)
                }
              }.justifyContent(FlexAlign.SpaceBetween).width('100%').padding(20)
            }
          }.width('100%').backgroundColor(Color.White).margin({top:20})

          // 订单
          List() {
            ForEach(this.checkedGoodsList, (item: CheckedGoodsItem) => {
              ListItem() {
                this.PayListItem(item)
              }.backgroundColor(Color.White).margin({ top: 20 })
            })
          }.width("100%").padding(20).scrollBar(BarState.Off).backgroundColor(Color.White).margin({top:20})

          // 商品金额
          Row() {
            Text("商品金额")
              .fontSize(16)
            Text(`￥${this.goodsTotalPrice?.toFixed(2) || '0.00'}`)
              .fontSize(16)
              .fontColor("#ff0000")
          }
          .width("100%")
          .padding(20)
          .justifyContent(FlexAlign.SpaceBetween)
          .border({ width: { bottom: 1 }, color: { bottom: "#ebebeb" } })
          .backgroundColor(Color.White).margin({top:20})

          // 运费
          Row() {
            Text("运费")
              .fontSize(16)
            Text(`￥${this.freightPrice?.toFixed(2) || '0.00'}`)
              .fontSize(16)
              .fontColor("#ff0000")
          }
          .width("100%")
          .padding(20)
          .justifyContent(FlexAlign.SpaceBetween)
          .border({ width: { bottom: 1 }, color: { bottom: "#ebebeb" } })
          .backgroundColor(Color.White)

          // 优惠
          Row() {
            Text("优惠")
              .fontSize(16)
            Text(`-￥${this.couponPrice?.toFixed(2) || '0.00'}`)
              .fontSize(16)
              .fontColor("#ff0000")
          }
          .width("100%")
          .padding(20)
          .justifyContent(FlexAlign.SpaceBetween)
          .border({ width: { bottom: 1 }, color: { bottom: "#ebebeb" } })
          .backgroundColor(Color.White)

          // 订单备注
          Row() {
            Text("订单备注")
              .fontSize(16)
            TextInput({ placeholder: "请输入订单备注" })
              .margin({ left: 20 })
              .backgroundColor("transparent")
              .onChange((value: string) => {
                this.orderMessage = value;
              })
          }.padding({ left: 20 }).width("100%").backgroundColor(Color.White)
        }
      }.layoutWeight(1)

      // 提交
      Row() {
        Row() {
          Text("合计:")
            .fontSize(14)
            .fontColor("#666")
          Text(`￥${this.orderTotalPrice?.toFixed(2) || '0.00'}`)
            .fontSize(18)
            .fontColor("#ff0000")
            .fontWeight(FontWeight.Bold)
        }
        .alignItems(VerticalAlign.Center)
        .margin({ right: 15 })

        // 结算按钮
        Button("提交订单")
          .fontSize(16)
          .height(40)
          .borderRadius("50%")
          .fontColor(Color.White)
          .type(ButtonType.Normal)
          .linearGradient({
            angle: 90,
            direction: GradientDirection.Left,
            colors: [
              ["#ff6034", 0],
              ["#ee0a24", 1]
            ]
          })
          .onClick(() => {
            const addrId = (this.checkedAddress as CheckedAddress | undefined)?.id ?? 0;
            this.getUIContext().getRouter().pushUrl({
              url: "pages/SubmitPage",
              params: {
                cartId: this.cartId,
                addressId: addrId,
                couponId: 0,
                userCouponId: 0,
                grouponLinkId: 0,
                grouponRulesId: 0,
                message: this.orderMessage
              }
            })
          })
          .margin({right:20})
      }.height(50).alignItems(VerticalAlign.Bottom).width('100%').backgroundColor(Color.White).justifyContent(FlexAlign.End)
    }
    .height('100%')
    .width('100%')
    .backgroundColor("#f2f2f2")
  }
}
