import { GetTabsCategory, GetNewCategoryList } from "../api/Index"
import { TabsCategoryModel } from "../model/TabsCategoryModel"
import { SearchBar } from "../view/SearchBar"
import { CommonModifier } from "@kit.ArkUI";
import { NewCurrentCategoryModel } from "../model/NewCurrentCategoryModel";
import { CurrentSubCategoryModel } from "../model/CurrentSubCategoryModel";

@Component
export struct Selected {
  @State curId: number = 1005000;
  @State tabBarModifier: CommonModifier = new CommonModifier();
  @State categoryList: Array<TabsCategoryModel> = [];
  @State currentCategory: NewCurrentCategoryModel | null = null;
  @State currentSubCategory: Array<CurrentSubCategoryModel> = [];

  async aboutToAppear() {
    const ResData = await GetTabsCategory();
    this.categoryList = ResData.data.categoryList;
    this.currentCategory = ResData.data.currentCategory;
    this.curId = ResData.data.currentCategory.id;
    this.currentSubCategory = ResData.data.currentSubCategory;
  }

  // 切换重新请求数据
  async onTabBarClick(id: number) {
    const ResData = await GetNewCategoryList(id);
    this.currentCategory = ResData.data.currentCategory;
    this.currentSubCategory = ResData.data.currentSubCategory;
  }

  build() {
    Column() {
      // 搜索框
      SearchBar()
      // 标签
      Tabs({
        barPosition: BarPosition.Start,
        barModifier: this.tabBarModifier = this.tabBarModifier.align(Alignment.Top)
      }) {
        ForEach(this.categoryList, (item: TabsCategoryModel) => {
          TabContent() {
            Column() {
              if (this.currentCategory) {
                Row() {
                  Image(this.currentCategory?.picUrl).width(250).height(82)
                }.width("100%").alignItems(VerticalAlign.Center).justifyContent(FlexAlign.Center)

                Row() {
                  Text(this.currentCategory?.desc).fontSize(16).fontColor("#646566")
                }.margin({ top: 6 }).alignItems(VerticalAlign.Center).justifyContent(FlexAlign.Center)
              } else {
                Row() {
                  Text("加载中...").fontSize(16).margin({ top: 6 }).textAlign(TextAlign.Center).fontColor("#646566")
                }.width("100%")
              }
              Grid() {
                ForEach(this.currentSubCategory, (cur: CurrentSubCategoryModel) => {
                  GridItem() {
                    Column() {
                      Image(cur.picUrl).width(70).height(70)
                      Text(cur.name)
                        .fontSize(16)
                        .margin({ top: 6 })
                        .textAlign(TextAlign.Center)
                        .fontColor("#646566")
                        .maxLines(1)
                        .textOverflow({ overflow: TextOverflow.Ellipsis })
                    }
                  }.onClick(()=>{
                    this.getUIContext().getRouter().pushUrl({
                      url: "pages/CategoryPage",
                      params: {
                        cid: cur.id
                      }
                    })
                  })
                })
              }.columnsTemplate("repeat(3,1fr)").columnsGap(6).rowsGap(10)
            }.width("100%").padding(10)
          }.tabBar(item.name).align(Alignment.Top)
        })
      }
      .vertical(true)
      .scrollable(false)
      .barMode(BarMode.Scrollable)
      // .animationMode(2)
      .divider({ strokeWidth: 1, color: "#f2f2f2" })
      .onTabBarClick((index) => {
        this.curId = this.categoryList[index].id;
        this.onTabBarClick(this.curId);
      })
    }
    .height('100%')
    .width('100%')
    .backgroundColor(Color.White)
  }
}