import { GetCategory, GetCategoryList } from "../api/CategoryApi";
import { BrotherCategoryModel } from "../model/BrotherCategoryModel";
import { BackBar } from "../view/BackBar";
import { CurrentCategoryModel } from "../model/CurrentCategoryModel";

@Entry
@Component
struct CategoryPage {
  @State cid: number = 1008002;
  @State page: number = 1;
  @State isLoading: boolean = false;
  @State brotherCategory: Array<BrotherCategoryModel> = [];
  @State getCategoryList: Array<CurrentCategoryModel> = [];
  @State currentIndex: number = 0;

  async aboutToAppear() {
    const params = this.getUIContext().getRouter().getParams() as Record<string, Object>;
    if (params && params.cid) {
      this.cid = params.cid as number;
    }
    await this.loadCategory(this.cid);
  }

  async loadCategory(id: number) {
    const tabRes = await GetCategory(id);
    this.cid = tabRes.data.currentCategory.id;
    this.brotherCategory = tabRes.data.brotherCategory;
    this.currentIndex = this.brotherCategory.findIndex(item => item.id === this.cid) ?? 0;

    const listRes = await GetCategoryList(this.cid, 1, 10);
    this.page = 1;
    this.getCategoryList = listRes.data.list;
  }

  async tabClickListChange(id: number) {
    this.cid = id;
    await this.loadCategory(id);
  }

  async listToEnd() {
    if (this.isLoading) {
      return;
    }
    this.isLoading = true;
    try {
      const res = await GetCategoryList(this.cid, this.page + 1, 10);
      if (res.data.list.length > 0) {
        this.getCategoryList = this.getCategoryList.concat(res.data.list);
        this.page++;
      }
    } finally {
      this.isLoading = false;
    }
  }

  @Builder
  CategoryListItem(item: CurrentCategoryModel) {
    Column() {
      Image(item.picUrl)
        .width(140)
        .height(140)
        .objectFit(ImageFit.Cover)
        .borderRadius(12)
      Text(item.name)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .margin({ top: 6 })
      Text(item.brief)
        .fontColor("#8c8c8c")
        .fontSize(12)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .margin({ top: 4 })
      Text() {
        Span("¥").fontSize(12).fontColor("#e54d42")
        Span(item.retailPrice.toString()).fontSize(16).fontColor("#e54d42")
      }.margin({ top: 6 })
    }
    .width("100%")
    .padding(12)
    .backgroundColor("#ffffff")
    .borderRadius(14)
    .shadow({ radius: 6, color: "#1A000000", offsetX: 0, offsetY: 2 })
  }

  build() {
    Column() {
      Stack({ alignContent: Alignment.Top }) {
        Tabs({ index: this.currentIndex }) {
          ForEach(this.brotherCategory, (item: BrotherCategoryModel) => {
            TabContent() {
              Column() {
                // 分类标题
                Column({ space: 4 }) {
                  Text(item.name)
                    .fontSize(18)
                    .fontWeight(FontWeight.Medium)
                    .maxLines(1)
                    .textOverflow({ overflow: TextOverflow.Ellipsis })
                    .textAlign(TextAlign.Center)
                  Text(item.desc)
                    .fontSize(13)
                    .fontColor("#999")
                    .maxLines(1)
                    .textOverflow({ overflow: TextOverflow.Ellipsis })
                    .textAlign(TextAlign.Center)
                }.width("100%").padding({ top: 12, bottom: 12 })

                // 商品网格
                Scroll() {
                  Grid() {
                    ForEach(this.getCategoryList, (cur: CurrentCategoryModel) => {
                      GridItem() {
                        this.CategoryListItem(cur)
                      }
                      .onClick(() => {
                        this.getUIContext().getRouter().pushUrl({
                          url: "pages/DetailPage",
                          params: { did: cur.id }
                        })
                      })
                    }, (cur: CurrentCategoryModel) => cur.id.toString())
                  }
                  .columnsTemplate("repeat(2, 1fr)")
                  .columnsGap(14)
                  .rowsGap(14)
                  .padding({ left: 14, right: 14, bottom: 28 })
                  .onReachEnd(() => this.listToEnd())
                }
                .width("100%")
                .height("100%")
              }
              .width("100%")
              .backgroundColor("#f5f5f5")
            }.tabBar(item.name)
            .align(Alignment.Top)
          })
        }
        .margin({ top: 50 })
        .scrollable(false)
        .barMode(BarMode.Scrollable)
        .onTabBarClick((index) => {
          this.currentIndex = index;
          this.tabClickListChange(this.brotherCategory[index].id);
        })

        BackBar().alignSelf(ItemAlign.Start)
      }
    }
    .height('100%')
    .width('100%')
    .backgroundColor("#f5f5f5")
  }
}
