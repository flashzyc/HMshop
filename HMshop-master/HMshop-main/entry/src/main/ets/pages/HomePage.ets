import { HomeWaterfall } from "../components/HomeWaterfall";
import { Individual } from "../components/Individual";
import { ShopCart } from "../components/ShopCart";
import router from "@ohos.router";

@Entry
@Component
struct HomePage {
  @State currentIndex: number = 0;
  @StorageProp('cartRefresh') cartRefresh: number = 0;

  aboutToAppear() {
    AppStorage.setOrCreate('cartRefresh', this.cartRefresh);
  }

  @Builder
  tarBarBuilder(index: number, url: Resource, text: string) {
    Column() {
      Image(url).width(18).height(18).fillColor(index == this.currentIndex ? "#db3d3c" : "#646566")
      Text(text).fontSize(12).fontColor(index == this.currentIndex ? "#db3d3c" : "#646566").margin({ top: 5 })
    }
  }

  build() {
    Stack() {
      Tabs({ barPosition: BarPosition.End }) {
        TabContent() {
          HomeWaterfall()
        }.tabBar(this.tarBarBuilder(0, $r("app.media.jinxuan"), "首页"))

        TabContent() {
          ShopCart({ refreshKey: this.cartRefresh })
        }.tabBar(this.tarBarBuilder(1, $r("app.media.gowu"), "购物车"))

        TabContent() {
          Individual()
        }.tabBar(this.tarBarBuilder(2, $r("app.media.wode"), "我的"))
      }.onChange((index) => {
        this.currentIndex = index
        if (index === 1) {
          // 切到购物车时触发刷新
          this.cartRefresh = Date.now();
        }
      })
      .height('100%')
      .width('100%')
      .backgroundColor(Color.White)
      .scrollable(false)

      // AI 悬浮球，仅首页显示，固定右下角（组件本身对齐，不铺满全屏）
      if (this.currentIndex === 0) {
        Column() {
          Button({ type: ButtonType.Normal }) {
            Column() {
              Text('智能')
                .fontSize(14)
                .fontWeight(FontWeight.Bold)
                .fontColor(Color.White)
                .textAlign(TextAlign.Center)
              Text('导购')
                .fontSize(14)
                .fontWeight(FontWeight.Bold)
                .fontColor(Color.White)
                .textAlign(TextAlign.Center)
            }
            .width('100%')
            .height('100%')
            .justifyContent(FlexAlign.Center)
            .alignItems(HorizontalAlign.Center)
          }
            .width(72)
            .height(72)
            .linearGradient({
              angle: 135,
              direction: GradientDirection.Left,
              colors: [
                ['#ff7f50', 0],
                ['#db3d3c', 1]
              ]
            })
            .borderRadius(36)
            .shadow({ radius: 8, color: '#33000000', offsetY: 2 })
            .onClick(() => {
              router.pushUrl({ url: 'pages/AiPage' });
            })
        }
        .align(Alignment.BottomEnd)
        // 对齐右下角后再向内偏移，避免覆盖底部 Tab
        .offset({ x: 150, y: 270 })
      }
    }
    .height('100%')
    .width('100%')
    .backgroundColor(Color.White)
  }
}
