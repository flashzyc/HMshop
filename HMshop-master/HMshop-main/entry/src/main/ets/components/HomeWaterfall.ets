import { GetHostGoodsList, GetSearchData } from "../api/Index"
import { NewGoodsListModel } from "../model/NewGoodsListModel"
import { NewArrivalViewData } from "../viewmodel/HomeViewData"
import { ResponseData } from "../utils/ResponseData"

@Component
export struct HomeWaterfall {
  @State keyword: string = ""
  @State list: Array<NewGoodsListModel> = []
  @State page: number = 1
  @State isLoading: boolean = false
  @State isSearchMode: boolean = false

  async aboutToAppear() {
    await this.loadData(true)
  }

  private async loadData(reset: boolean) {
    if (this.isLoading) {
      return
    }
    this.isLoading = true
    try {
      if (reset) {
        this.page = 1
        this.list = []
      }
      const nextPage: number = this.page
      let res: ResponseData<NewArrivalViewData>
      if (this.isSearchMode && this.keyword.trim().length > 0) {
        res = await GetSearchData(this.keyword.trim(), nextPage, 20, 0)
      } else {
        res = await GetHostGoodsList(true, nextPage, 20)
      }
      if (res.errno === 0 && res.data && res.data.list) {
        this.list = this.list.concat(res.data.list)
        this.page++
      }
    } finally {
      this.isLoading = false
    }
  }

  private async doSearch() {
    this.isSearchMode = this.keyword.trim().length > 0
    await this.loadData(true)
  }

  @Builder
  Footer() {
    Row() {
      Text("加载中...").fontSize(12).fontColor("#999")
    }
    .width("100%")
    .justifyContent(FlexAlign.Center)
    .height(50)
    .visibility(this.isLoading ? Visibility.Visible : Visibility.None)
  }

  @Builder
  WaterfallCard(item: NewGoodsListModel) {
    Column() {
      Image(item.picUrl)
        .width("100%")
        .aspectRatio(1)
        .objectFit(ImageFit.Cover)
        .borderRadius(12)
      Text(item.name)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .margin({ top: 8 })
      Text(item.brief)
        .fontSize(12)
        .fontColor("#8c8c8c")
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .margin({ top: 4 })
      Text() {
        Span("¥").fontSize(12).fontColor("#e54d42")
        Span(item.retailPrice.toString()).fontSize(16).fontColor("#e54d42")
      }.margin({ top: 8 })
    }
    .padding(10)
    .backgroundColor(Color.White)
    .borderRadius(14)
    .shadow({ radius: 6, color: "#1A000000", offsetX: 0, offsetY: 2 })
  }

  build() {
    Column() {
      // 顶部搜索框
      Row() {
        TextInput({ placeholder: "点此输入搜索", text: $$this.keyword })
          .layoutWeight(1)
          .height(40)
          .backgroundColor("#f5f5f5")
          .borderRadius(20)
          .padding({ left: 12, right: 12 })
          .onSubmit(() => {
            this.doSearch()
          })
        Button("搜索")
          .height(40)
          .margin({ left: 8 })
          .backgroundColor("#ffc40e23")
          .borderRadius(20)
          .onClick(() => {
            this.doSearch()
          })
      }
      .padding({ left: 16, right: 16, top: 12, bottom: 8 })

      // 瀑布流内容（滑到底自动加载）
      WaterFlow({ footer: this.Footer() }) {
        ForEach(this.list, (item: NewGoodsListModel) => {
          FlowItem() {
            this.WaterfallCard(item)
          }
          .onClick(() => {
            this.getUIContext().getRouter().pushUrl({
              url: "pages/DetailPage",
              params: { did: item.id }
            })
          })
        }, (item: NewGoodsListModel) => item.id.toString())
      }
      .columnsTemplate("1fr 1fr")
      .columnsGap(14)
      .rowsGap(14)
      .padding({ left: 14, right: 14, bottom: 24 })
      .onReachEnd(() => {
        this.loadData(false)
      })
      .layoutWeight(1)
    }
    .height("100%")
    .width("100%")
    .backgroundColor("#f5f5f5")
  }
}
