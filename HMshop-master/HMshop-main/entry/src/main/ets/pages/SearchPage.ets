import { GetSearchData } from "../api/Index"
import { SearchModel } from "../model/SearchModel"

@Entry
@Component
struct SearchPage {
  @State hasData: boolean = false
  @State searchText: string = ''
  @State searchList: Array<SearchModel> = []

  async goToSearch(keyword: string, page: number, limit: number, categoryId: number) {
    const ResData = await GetSearchData(keyword, page, limit, categoryId);
    this.searchList = ResData.data.list;
    this.hasData = ResData.data.list.length > 0;
  }

  @Builder
  hotGoodsListItem(item: SearchModel) {
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

  build() {
    Column() {
      Search({ placeholder: "请输入商品名称", value: this.searchText })
        .onSubmit(() => {
          this.goToSearch(encodeURIComponent(this.searchText), 1, 10, 0)
        })
      Row() {
        Text("历史记录")
        Row() {
          Image($r("app.media.delete")).width(16).height(16)
          Text("清空历史记录").fontSize(14).fontColor("#8a8a8a").margin({left:4})
        }
      }.width('100%').padding(20).justifyContent(FlexAlign.SpaceBetween).padding(20)

      if (this.hasData) {
        List(){
          ForEach(this.searchList, (item: SearchModel) => {
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
        }
      } else {
        // 空购物车提示
        Column() {
          Image($r("app.media.gowu"))
            .width(100)
            .height(100)
            .margin({ bottom: 20 })
          Text("占无相关数据")
            .fontColor("#999")
            .fontSize(14)
        }
        .width("100%")
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)
      }
    }
    .height('100%')
    .width('100%')
  }
}