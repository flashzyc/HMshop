import { GetHome } from '../api/HomeApi';
import { BannerModel } from '../model/BannerModel';
import { BrandListModel } from '../model/BrandListModel';
import { ChannelModel } from '../model/ChannelModel';
import { CouponListModel } from "../model/CouponListModel"
import { GrouponListModel } from '../model/GrouponListModel';
import { NewGoodsListModel } from "../model/NewGoodsListModel";
import { HotGoodsListModel } from "../model/HotGoodsListModel"
import { TopicListModel } from "../model/TopicListModel"
import { SearchBar } from "../view/SearchBar"

@Component
export struct Category {
  @State banner: Array<BannerModel> = [];
  @State channel: Array<ChannelModel> = [];
  @State couponList: Array<CouponListModel> = [];
  @State newGoodsList: Array<NewGoodsListModel> = [];
  @State grouponList: Array<GrouponListModel> = [];
  @State brandList: Array<BrandListModel> = [];
  @State hotGoodsList: Array<HotGoodsListModel> = [];
  @State topicList: Array<TopicListModel> = [];

  async aboutToAppear() {
    let ResData = await GetHome();
    this.banner = ResData.data.banner;
    this.channel = ResData.data.channel;
    this.couponList = ResData.data.couponList;
    this.newGoodsList = ResData.data.newGoodsList;
    this.grouponList = ResData.data.grouponList;
    this.brandList = ResData.data.brandList;
    this.hotGoodsList = ResData.data.hotGoodsList;
    this.topicList = ResData.data.topicList;
  }

  @Builder
  channelGridItem(item: ChannelModel) {
    Column() {
      Image(item.iconUrl).width(25).height(25).margin({ bottom: 5 })
      Text(item.name)
    }
  }

  @Builder
  couponListItem(item: CouponListModel) {
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
        Text(`有效期：${item.days}`)
          .fontColor("#ff858080")
          .fontSize(12)
      }
      .alignItems(HorizontalAlign.Start)
      .margin({ left: 30 })
    }
    .width('80%')
  }

  @Builder
  grouponListItem(item: GrouponListModel) {
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

  @Builder
  brandGridItem(item: BrandListModel) {
    Column() {
      Image(item.picUrl).width(137)
      Text(item.name).margin({ top: 4 })
    }
  }

  @Builder
  newGridItem(item: NewGoodsListModel) {
    Column() {
      Row() {
        Image(item.picUrl).width(180).height(180)
      }.alignItems(VerticalAlign.Center).justifyContent(FlexAlign.Center)

      Row() {
        Text(item.name)
          .fontColor("rgb(123, 116, 116)")
          .fontSize(16)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .maxLines(1)
          .padding(4)
      }.alignItems(VerticalAlign.Center).justifyContent(FlexAlign.Center)

      Row() {
        Text("￥" + item.retailPrice.toString()).fontColor("rgb(171, 149, 109)").fontSize(14)
      }.alignItems(VerticalAlign.Center).justifyContent(FlexAlign.Center)
    }.width("100%")
  }

  @Builder
  hotGoodsListItem(item: HotGoodsListModel) {
    Row() {
      Column() {
        Image(item.picUrl).width(88).height(88)
      }

      Column() {
        Row() {
          Text(item.name).maxLines(1).textOverflow({ overflow: TextOverflow.Ellipsis })
        }

        Row() {
          Text(item.brief).fontColor("#646566")
        }

        Row() {
          Text() {
            Span("￥").fontSize(12)
            Span(item.retailPrice.toString()).fontSize(14)
            Span("￥" + item.counterPrice)
              .fontSize(10)
              .fontColor("#969799")
              .decoration({ type: TextDecorationType.LineThrough })
          }
        }.margin({ top: 10 })
      }.width("70%").alignItems(HorizontalAlign.Start).margin({ left: 6 })
    }
  }

  @Builder
  topicListItem(item: TopicListModel) {
    Column() {
      Row() {
        Image(item.picUrl).width(155)
      }

      Row() {
        Text(item.title)
          .margin({ top: 4 })
          .padding({ left: 2, right: 2 })
          .fontColor("rgb(171, 149, 109)")
          .fontSize(16)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .textAlign(TextAlign.Center)
      }

      Row() {
        Text(item.subtitle)
          .margin({ top: 4 })
          .padding({ left: 2, right: 2 })
          .fontColor("rgb(171, 149, 109)")
          .fontSize(12)
          .maxLines(3)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .textAlign(TextAlign.Center)
      }
    }.width("100%")
  }

  build() {
    Scroll() {
      Column() {
        //搜索框 -- 完成
        SearchBar()

        //轮播图 -- 完成
        Row() {
          Swiper() {
            ForEach(this.banner, (item: BannerModel) => {
              Image(item.url)
            })
          }
          .autoPlay(true)
          .loop(true)
          .duration(200)
        }

        //分类 -- 完成
        Row() {
          Grid() {
            ForEach(this.channel, (item: ChannelModel) => {
              GridItem() {
                this.channelGridItem(item)
              }.onClick(() => {
                this.getUIContext().getRouter().pushUrl({ url: "pages/CategoryPage", params: { cid: item.id } })
              })
            })
          }.columnsTemplate("repeat(6,1fr)").columnsGap(10).rowsGap(10)
        }.margin({ top: 10, bottom: 20 }).padding({ top: 5 }).height(120).backgroundColor(Color.White)

        //优惠券 -- 完成
        Column() {
          Row() {
            Text("优惠券").textAlign(TextAlign.Start).padding(10)
          }.width("100%")
          if(this.couponList.length > 0){
            List({ space: 20 }) {
              ForEach(this.couponList, (item: CouponListModel) => {
                ListItem() {
                  this.couponListItem(item)
                }
                .border({
                  width: 1,
                  color: Color.Red,
                  style: BorderStyle.Solid
                })
                .width('100%')
                .height(70)
                .onClick(()=>{
                  this.getUIContext().getRouter().pushUrl({
                    url: "pages/CouponPage",
                    params: { index: 2}
                  })
                })
              })
            }.padding(10)
          }else{
            Text("暂无优惠券").textAlign(TextAlign.Center).padding(10)
          }

        }.backgroundColor(Color.White)

        //团购专区 -- 完成
        Column() {
          Row() {
            Text("团购专区")
            Text() {
              Span("更多团购商品").fontColor("#ff858080")
              ImageSpan($r("app.media.next")).width(12).height(12).margin({ bottom: 5, left: 4 })
            }.onClick(()=>{
              this.getUIContext().getRouter().pushUrl({
                url: "pages/GroupBuyPage"
              })
            })
          }
          .width("100%")
          .padding({ left: 10, right: 10, top: 6 })
          .height(30)
          .alignItems(VerticalAlign.Center)
          .justifyContent(FlexAlign.SpaceBetween)

          List() {
            ForEach(this.grouponList, (item: GrouponListModel) => {
              ListItem() {
                this.grouponListItem(item)
              }.width("90%")
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
        }.width("100%").backgroundColor(Color.White).margin({ top: 20 })

        //品牌商直供 -- 完成
        Column() {
          Row() {
            Text("品牌商直供")
            Text() {
              Span("更多品牌商").fontColor("#ff858080")
              ImageSpan($r("app.media.next")).width(12).height(12).margin({ bottom: 5, left: 4 })
            }.onClick(()=>{
              this.getUIContext().getRouter().pushUrl({ url: "pages/BrandListPage" })
            })
          }
          .width("100%")
          .padding({ left: 10, right: 10, top: 6 })
          .height(30)
          .alignItems(VerticalAlign.Center)
          .justifyContent(FlexAlign.SpaceBetween)

          Grid() {
            ForEach(this.brandList, (item: BrandListModel) => {
              GridItem() {
                this.brandGridItem(item)
              }.onClick(()=>{
                this.getUIContext().getRouter().pushUrl({
                  url: "pages/BrandDetailPage",
                  params: {
                    bid: item.id
                  }
                })
              })
            })
          }.width("100%").margin({ top: 10, bottom: 10 }).columnsTemplate("repeat(2,1fr)").rowsGap(10)

        }.width("100%").backgroundColor(Color.White).margin({ top: 20 })

        //新品首发 -- 完成
        Column() {
          Row() {
            Text("新品首发")
            Text() {
              Span("更多新品首发").fontColor("#ff858080")
              ImageSpan($r("app.media.next")).width(12).height(12).margin({ bottom: 5, left: 4 })
            }.onClick(()=>{
              this.getUIContext().getRouter().pushUrl({ url: "pages/NewArrivalPage" })
            })
          }
          .width("100%")
          .padding({ left: 10, right: 10, top: 6 })
          .height(30)
          .alignItems(VerticalAlign.Center)
          .justifyContent(FlexAlign.SpaceBetween)

          Grid() {
            ForEach(this.newGoodsList, (item: NewGoodsListModel) => {
              GridItem() {
                this.newGridItem(item)
              }.onClick(()=>{
                this.getUIContext().getRouter().pushUrl({
                  url: "pages/DetailPage",
                  params: {
                    did: item.id
                  }
                })
              })
            })
          }.columnsTemplate("repeat(2,1fr)").columnsGap(10).rowsGap(10).margin({ bottom: 10 })
        }.width("100%").backgroundColor(Color.White).margin({ top: 20 })

        //人气推荐 -- 完成
        Column() {
          Row() {
            Text("人气推荐")
            Text() {
              Span("更多人气推荐").fontColor("#ff858080")
              ImageSpan($r("app.media.next")).width(12).height(12).margin({ bottom: 5, left: 4 })
            }.onClick(()=>{
              this.getUIContext().getRouter().pushUrl({ url: "pages/HotGoodsListPage" })
            })
          }
          .width("100%")
          .padding({ left: 10, right: 10, top: 6 })
          .height(30)
          .alignItems(VerticalAlign.Center)
          .justifyContent(FlexAlign.SpaceBetween)

          List() {
            ForEach(this.hotGoodsList, (item: HotGoodsListModel) => {
              ListItem() {
                this.hotGoodsListItem(item)
              }.width("90%")
              .align(Alignment.Start)
              .onClick(()=>{
                this.getUIContext().getRouter().pushUrl({
                  url: "pages/DetailPage",
                  params: {
                    did: item.id
                  }
                })
              })
            })
          }.width("100%").alignListItem(ListItemAlign.Center).margin({ top: 10, bottom: 10 })
        }.width("100%").backgroundColor(Color.White).margin({ top: 20 })

        //专题精选 -- 完成
        Column() {
          Row() {
            Text("人气推荐")
            Text() {
              Span("更多人气推荐").fontColor("#ff858080")
              ImageSpan($r("app.media.next")).width(12).height(12).margin({ bottom: 5, left: 4 })
            }.onClick(()=>{
              this.getUIContext().getRouter().pushUrl({ url: "pages/TopicMorePage" })
            })
          }
          .width("100%")
          .padding({ left: 10, right: 10, top: 6 })
          .height(30)
          .alignItems(VerticalAlign.Center)
          .justifyContent(FlexAlign.SpaceBetween)

          // 瀑布流布局
          WaterFlow() {
            ForEach(this.topicList, (item: TopicListModel) => {
              FlowItem() {
                this.topicListItem(item)
              }.margin({ top: 10, bottom: 10 })
              .onClick(()=>{
                this.getUIContext().getRouter().pushUrl({
                  url: "pages/TopicPage",
                  params: {
                    tid: item.id
                  }
                })
              })
            })
          }.columnsTemplate("repeat(2,1fr)")
        }.width("100%").backgroundColor(Color.White).margin({ top: 20 })
      }
      .width('100%')
      .backgroundColor("#f2f2f2")
    }
    .height('100%')
  }
}
