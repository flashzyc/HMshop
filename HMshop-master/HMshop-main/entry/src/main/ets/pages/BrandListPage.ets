import { BackBar } from '../view/BackBar'
import { GetBrandList } from "../api/HomeApi"
import { BrandListModel } from '../model/BrandListModel';

@Entry
@Component
struct BrandListPage {
  @State list:BrandListModel[] = [];
  @State page: number = 1;
  // 加载更多时添加防抖和加载状态
  @State isLoading: boolean = false;

  async aboutToAppear() {
    const ResData = await GetBrandList(this.page, 10);
    this.list = ResData.data.list;
  }
  async getMoreList(){
    if(!this.isLoading){
      this.isLoading = true;
      this.page++;
      const ResData = await GetBrandList(this.page, 10);
      this.list = this.list.concat(ResData.data.list);
      this.isLoading = false;
    }
  }
  build() {
    Column() {
      BackBar()
      Column() {
        List(){
          ForEach(this.list, (item:BrandListModel) => {
            ListItem(){
              Column(){
                Stack(){
                  Image(item.picUrl).width("100%").height(180).objectFit(ImageFit.Cover)
                  Column(){
                    Text(item.name).fontSize(20).fontColor("#fff").textAlign(TextAlign.Center)
                    Divider().backgroundColor("#fff").width("100").height(2).margin(4)
                    Text(item.floorPrice.toString()).fontSize(18).fontColor("#fff").textAlign(TextAlign.Center)
                  }
                }
                Row(){
                  Text(item.desc).fontSize(18).fontColor("#666").textAlign(TextAlign.Center)
                }.width("100%").padding(20)
              }
            }
          })
        }.onReachEnd(()=>{
          this.getMoreList()
        })
      }
    }
    .height('100%')
    .width('100%')
  }
}