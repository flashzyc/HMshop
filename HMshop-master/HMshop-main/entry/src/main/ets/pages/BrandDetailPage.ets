import { GetBrandDetail,GetBrandDetailList } from "../api/HomeApi"
import { BrandDetailListModel } from "../model/BrandDetailListModel";
import { BrandDetailModel } from "../model/BrandDetailModel";
import { BackBar } from "../view/BackBar";

@Entry
@Component
struct BrandDetailPage {
  @State bid: number = 1001000
  @State data:Partial<BrandDetailModel> = {}
  @State list: Array<BrandDetailListModel> = []

  async aboutToAppear() {
    const params = this.getUIContext().getRouter().getParams() as Record<string, Object>;
    if (params && params.bid) {
      this.bid = params.bid as number;
    }
    const ResData = await GetBrandDetail(this.bid);
    this.data = ResData.data;
    const ResList = await GetBrandDetailList(this.bid);
    this.list = ResList.data.list;
  }

  build() {
    Column() {
      BackBar()
      Stack() {
        Image(this.data.picUrl).width("100%").height(180).objectFit(ImageFit.Cover)
        Column() {
          Text(this.data.name).fontSize(20).fontColor("#fff").textAlign(TextAlign.Center)
          Divider().backgroundColor("#fff").width("100").height(2).margin(4)
          Text(this.data.floorPrice?.toString()).fontSize(18).fontColor("#fff").textAlign(TextAlign.Center)
        }
      }
      Grid(){
        ForEach(this.list, (item: BrandDetailListModel) => {
          GridItem(){
            Column() {
              Image(item.picUrl).width(150).height(150).objectFit(ImageFit.Cover)
              Text(item.name).fontSize(16).fontColor("#333").textAlign(TextAlign.Start).padding({ top: 10}).maxLines(1).textOverflow({overflow:TextOverflow.Ellipsis})
              Text(`￥${item.retailPrice}`).fontColor("#ab956d").fontSize(14).alignSelf(ItemAlign.Start).padding({ top: 10,bottom:20})
            }.width(150).padding(10).backgroundColor("#f2f2f2")
          }.width("100%").onClick(()=>{
            this.getUIContext().getRouter().pushUrl({
              url: "pages/DetailPage",
              params: {
                did: item.id
              }
            })
          })
        })
      }.width("100%").columnsTemplate("1fr 1fr")
    }
    .backgroundColor("#f2f2f2")
    .height('100%')
    .width('100%')
  }
}