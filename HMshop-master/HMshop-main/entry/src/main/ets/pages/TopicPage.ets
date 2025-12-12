import { GetTopData } from "../api/HomeApi"
import { TopicModel } from "../model/TopicModel"
import { BackBar } from "../view/BackBar"

@Entry
@Component
struct TopicPage {
  @State tid: number = 272
  @State topicData: Partial<TopicModel> = {}
  @State imageUrls: string[] = []

  async aboutToAppear() {
    const params = this.getUIContext().getRouter().getParams() as Record<string, Object>;
    if (params && params.tid) {
      this.tid = params.tid as number;
    }
    const ResData = await GetTopData(this.tid)
    this.topicData = ResData.data.topic
    this.imageUrls = this.extractImageUrls(this.topicData.content as string)
  }

  extractImageUrls(htmlString: string): string[] {
    const imageUrls: string[] = [];
    const regex = /\/\/yanxuan\.nosdn\.127\.net\/[a-zA-Z0-9-_.]+\.jpg/g;
    let match: RegExpExecArray | null;

    while ((match = regex.exec(htmlString)) !== null) {
      imageUrls.push(`https:${match[0]}`);
    }

    return imageUrls;
  }

  build() {
    Column() {
      BackBar()
      Scroll(){
        Column(){
          ForEach(this.imageUrls, (item:string)=>{
            Image(item)
              .width('100%')
              .objectFit(ImageFit.Contain)
          })
        }
      }
    }
    .height('100%')
    .width('100%')
  }
}