import { GetTopMoreData } from "../api/HomeApi"
import { TopicMoreModel } from "../model/TopicMoreModel"
import { BackBar } from "../view/BackBar";


@Entry
@Component
struct TopicMorePage {
  @State list: TopicMoreModel[] = []
  @State page: number = 1;
  // 加载更多时添加防抖和加载状态
  @State isLoading: boolean = false;

  async aboutToAppear() {
    const ResData = await GetTopMoreData(1, 10);
    this.list = ResData.data.list;
  }

  async getMoreList() {
    if (!this.isLoading) {
      this.isLoading = true;
      this.page++;
      const ResData = await GetTopMoreData(this.page, 10);
      this.list = this.list.concat(ResData.data.list);
      if (ResData.data.list.length < 10) {
        this.isLoading = true;
      } else {
        this.isLoading = false;
      }
    }
  }

  build() {
    Column() {
      BackBar()
      List() {
        ForEach(this.list, (item: TopicMoreModel) => {
          ListItem() {
            Column() {
              Stack() {
                Image(item.picUrl).width("100%").height(180).objectFit(ImageFit.Cover)
                Column() {
                  Text(item.title).fontSize(20).fontColor("#fff").textAlign(TextAlign.Center)
                  Divider().backgroundColor("#fff").width("100").height(2).margin(4)
                  Text(`阅读次数：${item.readCount}`).fontSize(18).fontColor("#fff").textAlign(TextAlign.Center)
                }.justifyContent(FlexAlign.Center)
              }
              Row() {
                Text(item.subtitle).fontSize(18).fontColor("#666").textAlign(TextAlign.Center)
              }.width("100%").padding(20)
            }
          }.onClick(()=>{
            this.getUIContext().getRouter().pushUrl({
              url: "pages/TopicPage",
              params: {
                tid: item.id
              }
            })
          })
        })
      }.onReachEnd(() => {
        this.getMoreList()
      })
    }
    .height('100%')
    .width('100%')
  }
}