import { BackBar } from "../view/BackBar"
import { GetOrders, PostDelete } from "../api/OrderApi"
import { OrderDetailModel } from "../model/OrderDetailModel"
import { PromptAction } from "@kit.ArkUI";

@Entry
@Component
struct OrderPage {
  @State curIndex: number = 0;
  @State page: number = 1;
  @State limit: number = 10;
  @State list: Array<OrderDetailModel> = [];
  // 加载更多时添加防抖和加载状态
  @State isLoading: boolean = false;

  aboutToAppear() {
    const params = this.getUIContext().getRouter().getParams() as Record<string, Object>;
    if (params && params.index) {
      this.curIndex = params.index as number;
    }
    this.changeTabBar(this.curIndex)
  }

  async changeTabBar(index: number) {
    const ResData = await GetOrders(index, this.page, this.limit);
    this.list = ResData.data.list;
  }
  async deleteOrder(orderId: number) {
    const ResData = await PostDelete(orderId);
    if (ResData.errno == 0) {
      this.getUIContext().getPromptAction().showDialog({ message: "删除成功" ,})
      this.changeTabBar(this.curIndex)
    }else{
      this.getUIContext().getPromptAction().showDialog({ message: "删除失败" })
    }
  }

  @Builder
  OrderListItem(item: OrderDetailModel) {
    ListItem() {
      Column() {
        // 上面区域：订单编号和状态
        Row() {
          Text(`订单编号：${item.orderSn}`)
            .fontSize(14)
            .fontColor('#333333')


          Text(item.orderStatusText)
            .fontSize(14)
            .fontColor('#FF0000')
        }
        .width('100%')
        .padding({
          left: 15,
          right: 15,
          top: 12,
          bottom: 12
        })
        .justifyContent(FlexAlign.SpaceBetween)

        // 中间区域：商品信息
        Row() {
          // 左边：商品图片
          Image(item.goodsList[0].picUrl)
            .width(80)
            .height(80)
            .objectFit(ImageFit.Cover)
            .borderRadius(4)

          // 中间：商品名称和规格
          Column({ space: 8 }) {
            Text(item.goodsList[0].goodsName)
              .fontSize(14)
              .fontColor('#333333')
              .maxLines(2)
              .textOverflow({ overflow: TextOverflow.Ellipsis })

            // 规格列表
            Row({ space: 6 }) {
              ForEach(item.goodsList[0].specifications, (spec: string) => {
                Text(spec)
                  .fontSize(12)
                  .fontColor('#999999')
                  .padding({
                    left: 8,
                    right: 8,
                    top: 4,
                    bottom: 4
                  })
                  .border({ width: 1, color: '#E0E0E0', radius: 2 })
              })
            }
          }
          .layoutWeight(1)
          .alignItems(HorizontalAlign.Start)
          .margin({ left: 12, right: 12 })

          // 右边：数量
          Text(`x${item.goodsList[0].number}`)
            .fontSize(14)
            .fontColor('#666666')
        }
        .width('100%')
        .padding(15)
        .alignItems(VerticalAlign.Bottom)

        // 底部区域：价格和删除按钮
        Column() {
          // 合计金额
          Row() {
            Text('合计：')
              .fontSize(14)
              .fontColor('#333333')
            Text(`￥${item.actualPrice.toFixed(2)}`)
              .fontSize(16)
              .fontColor('#FF0000')
              .fontWeight(FontWeight.Bold)
            Text('（含运费）')
              .fontSize(12)
              .fontColor('#999999')
              .margin({ left: 4 })
          }
          .width('100%')
          .padding({ left: 15, right: 15, top: 10 })
          .justifyContent(FlexAlign.End)

          // 删除订单按钮
          Row() {
            Button('删除订单')
              .fontSize(14)
              .fontColor('#333333')
              .backgroundColor('#F5F5F5')
              .borderRadius(4)
              .height(32)
              .padding({ left: 20, right: 20 })
              .onClick(() => {
                this.deleteItem(item.id)
              })
          }
          .width('100%')
          .padding({
            left: 15,
            right: 15,
            top: 10,
            bottom: 12
          })
          .justifyContent(FlexAlign.End)
        }

      }
      .width('100%')
      .backgroundColor('#FFFFFF')
      .margin({ top: 10, bottom: 10 })
    }
  }
  @Builder
  noDataShow(){
    Column() {
      Image($r("app.media.gowu"))
        .width(100)
        .height(100)
        .margin({ bottom: 20 })
      Text("暂无数据")
        .fontColor("#999")
        .fontSize(14)
    }
    .width("100%")
    .height("100%")
    .justifyContent(FlexAlign.Center)
  }
  deleteItem(orderId: number) {
  AlertDialog.show({
    title: '提示',
    message: '确定要删除该订单吗？',
    primaryButton: {
      value: '取消',
      action: () => {}
    },
    secondaryButton: {
      value: '确定',
      action: () => {this.deleteOrder(orderId)}
    }
  })
}
  //滚动到底部加载更多
  async listToEnd() {
    if (this.isLoading) {
      return;
    }

    this.isLoading = true;
    try {
      const ResDataList = await GetOrders(this.curIndex, this.page + 1, 10);
      if (ResDataList.data.list.length > 0) {
        this.list = this.list.concat(ResDataList.data.list);
        this.page++;
      }
    } finally {
      this.isLoading = false;
    }
  }
  build() {
    Column() {
      BackBar()
      Tabs({ index: this.curIndex }) {
        TabContent() {
          if (this.list.length>0) {
            List() {
              ForEach(this.list, (item: OrderDetailModel) => {
                this.OrderListItem(item)
              })
            }.onReachEnd(() => {
              this.listToEnd();
            })
          } else {
            this.noDataShow()
          }
        }.tabBar("全部")
        .width('100%')
        .align(Alignment.Top)

        TabContent() {
          if (this.list.length>0) {
            List() {
              ForEach(this.list, (item: OrderDetailModel) => {
                this.OrderListItem(item)
              })
            }
          } else {
            this.noDataShow()
          }
        }.tabBar("待付款")
        .width('100%')
        .align(Alignment.Top)

        TabContent() {
          if (this.list.length>0) {
            List() {
              ForEach(this.list, (item: OrderDetailModel) => {
                this.OrderListItem(item)
              })
            }
          } else {
            this.noDataShow()
          }
        }.tabBar("待发货")
        .width('100%')
        .align(Alignment.Top)

        TabContent() {
          if (this.list.length>0) {
            List() {
              ForEach(this.list, (item: OrderDetailModel) => {
                this.OrderListItem(item)
              })
            }
          } else {
            this.noDataShow()
          }
        }.tabBar("待收货")
        .width('100%')
        .align(Alignment.Top)

        TabContent() {
          if (this.list.length>0) {
            List() {
              ForEach(this.list, (item: OrderDetailModel) => {
                this.OrderListItem(item)
              })
            }
          } else {
            this.noDataShow()
          }
        }.tabBar("待评价")
        .width('100%')
        .align(Alignment.Top)
      }
      .barBackgroundColor(Color.White)
      .scrollable(false)
      .onTabBarClick((index) => {
        this.page = 1; // 重置页码
        this.list = []; // 清空数据
        this.curIndex = index;
        this.changeTabBar(index)
      })
    }
    .height('100%')
    .width('100%')
    .backgroundColor("#f2f2f2")
  }
}
