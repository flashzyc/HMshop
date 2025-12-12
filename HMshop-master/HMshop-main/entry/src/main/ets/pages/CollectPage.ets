import { GetCollectList } from '../api/CollectApi';
import { BackBar } from '../view/BackBar';

@Entry
@Component
struct CollectPage {
  @State list: string[] = [];

  async aboutToAppear(){
    const ResData = await GetCollectList(0,1,10);
    this.list = ResData.data.list;
  }
  build() {
    Column() {
      BackBar()
      if (this.list.length > 0){

      }else {
        Column() {
          Image($r("app.media.gowu"))
            .width(100)
            .height(100)
            .margin({ bottom: 20 })
          Text("没有商品收藏")
            .fontColor("#999")
            .fontSize(14)
        }
        .width("100%")
        .height("100%")
        .justifyContent(FlexAlign.Center)
      }
    }
    .height('100%')
    .width('100%')
  }
}