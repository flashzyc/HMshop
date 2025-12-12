import { BackBar } from "../view/BackBar"
import { GetDetailGoods } from "../api/Index"
import { InfoDetailModel } from "../model/InfoDetailModel";
import { AttributeDialog } from "../components/dialog/AttributeDialog"
import { AttributeModel } from "../model/AttributeModel";
import { SpecificationModel } from "../model/SpecificationModel";
import { GoodsSKUModel } from "../model/GoodsSKUModel";
import { ProductDialog } from "../components/dialog/ProductDialog"

@Entry
@Component
struct DetailPage {
  @State did: number = 1055016;
  @State info: Partial<InfoDetailModel> = {};
  @State attribute:AttributeModel[] = [];
  @State images: string[] = [];
  @State specificationList: Array<SpecificationModel> = []
  @State productList: Array<GoodsSKUModel> = []

  attributeDialogController: CustomDialogController = new CustomDialogController({
    builder: AttributeDialog({ attributeList: this.attribute }),
    alignment: DialogAlignment.BottomEnd,
    cornerRadius: {
      bottomLeft: 0,
      bottomRight: 0
    },
    width: "100%",
    height: "50%",
    showInSubWindow: true,
    backgroundColor: Color.White
  });

  productDialogController: CustomDialogController = new CustomDialogController({
    builder: ProductDialog({ specification: this.specificationList, product: this.productList }),
    alignment: DialogAlignment.BottomEnd,
    cornerRadius: {
      bottomLeft: 0,
      bottomRight: 0
    },
    width: "100%",
    height: "65%",
    showInSubWindow: true,
    backgroundColor: Color.White
  });

  async aboutToAppear() {
    const params = this.getUIContext().getRouter().getParams() as Record<string, Object>;
    if (params && params.did) {
      this.did = params.did as number;
    }
    const ResData = await GetDetailGoods(this.did);
    this.info = ResData.data.info;
    this.extractImageUrls(this.info.detail || "");
    this.attribute = ResData.data.attribute;
    this.specificationList = ResData.data.specificationList;
    this.productList = ResData.data.productList;
  }

  // 解析http图片函数
  extractImageUrls(htmlString: string) {
    const imageUrls: string[] = [];
    const imgTagRegex = /<img.*?src="(.*?)".*?>/g;

    let match: RegExpExecArray | null;

    while ((match = imgTagRegex.exec(htmlString)) !== null) {
      // match[1] 包含了捕获组 1 的内容，即图片的 URL
      if (match && match[1]) {
        imageUrls.push(match[1]);
      }
    }

    this.images = imageUrls;
  }

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Scroll() {
        Column() {
          // 返回
          BackBar()

          // 轮播图
          Swiper() {
            ForEach(this.info.gallery, (item: string) => {
              Image(item).width(375).height(375).objectFit(ImageFit.Cover)
            })
          }
          .autoPlay(true)
          .loop(true)
          .duration(200)

          // 标题
          Column() {
            Row() {
              Text() {
                Span("￥").fontColor("#ee0a24")
                Span(this.info.retailPrice?.toString())
                  .padding(2)
                  .fontColor("#ee0a24")
                  .fontSize(16)
              }

              Text() {
                Span("￥").fontColor("#969799")
                Span(this.info.counterPrice?.toString())
                  .padding(2)
                  .fontColor("#969799")
                  .decoration({ type: TextDecorationType.LineThrough })
                  .fontSize(12)
              }.margin({ left: 10 })
            }.margin({ top: 20, bottom: 6 }).justifyContent(FlexAlign.Start)

            Text(this.info.name).fontSize(18)
            Text(this.info.brief).fontSize(14).fontColor('#969799').margin({ top: 5, bottom: 10 })
          }.width('90%').justifyContent(FlexAlign.Start).alignItems(HorizontalAlign.Start)

          // 属性
          Column() {
            Row() {
              Row() {
                Text("规格").fontSize(16)
              }

              Row() {
                Text("请选择").fontSize(16).fontColor("#ff838383")
                Image($r("app.media.next")).margin({ left: 10 }).width(14)
              }
            }
            .width("100%")
            .justifyContent(FlexAlign.SpaceBetween)
            .padding({
              top: 10,
              bottom: 10,
              left: 20,
              right: 20
            })
            .border({ width: { bottom: 1 }, color: { bottom: "#f2f2f2" } })
            .onClick(() => {
              this.productDialogController.open();
            })

            Row() {
              Row() {
                Text("属性").fontSize(16)
              }

              Row() {
                Text("请选择").fontSize(16).fontColor("#ff838383")
                Image($r("app.media.next")).margin({ left: 10 }).width(14)
              }
            }
            .width("100%")
            .justifyContent(FlexAlign.SpaceBetween)
            .padding({
              top: 10,
              bottom: 10,
              left: 20,
              right: 20
            })
            .border({ width: { bottom: 1 }, color: { bottom: "#f2f2f2" } })
            .onClick(() => {
              this.attributeDialogController.open();
            })

            Row() {
              Text("运费").fontSize(16)
              Text("满88免邮费").fontSize(16).fontColor("#ff838383")
            }
            .width("100%")
            .justifyContent(FlexAlign.SpaceBetween)
            .padding({
              top: 10,
              bottom: 10,
              left: 20,
              right: 20
            })
          }.width("100%").border({
            width: { top: 14, bottom: 14 },
            color: { top: "#f2f2f2", bottom: "#f2f2f2" }
          })

          // 商品详情
          Column() {
            Row() {
              Text("商品详情").margin(10)
            }

            ForEach(this.images, (item: string) => {
              Image(item).width('100%')
            })
          }
        }
      }.width("100%").height("100%")

      Row() {
        Column() {
          Image($r("app.media.tongzhi")).width(30)
        }.margin({ left: 20 })

        Row() {
          Column() {
            Button("加入购物车")
              .padding({
                top: 10,
                bottom: 10,
                left: 20,
                right: 20
              })
              .fontColor(Color.White)
              .type(ButtonType.Normal)
              .linearGradient({
                angle: 90,
                direction: GradientDirection.Left,
                colors: [
                  ["#ffd01e", 0],
                  ["#ff8917", 1]
                ]
              })
              .borderRadius({ topLeft: '50%', bottomLeft: '50%', })
              .onClick(() => {
                this.productDialogController.open();
              })
          }

          Column() {
            Button("立即购买")
              .padding({
                top: 10,
                bottom: 10,
                left: 20,
                right: 20
              })
              .margin({ right: 10 })
              .fontColor(Color.White)
              .type(ButtonType.Normal)
              .linearGradient({
                angle: 90,
                direction: GradientDirection.Left,
                colors: [
                  ["#ff6034", 0],
                  ["#ee0a24", 1]
                ]
              })
              .borderRadius({ topRight: '50%', bottomRight: '50%', })
              .onClick(() => {
                this.productDialogController.open();
              })
          }
        }
      }.width("100%").height(60).border({width:{top:1},color:{top:"#f2f2f2"}}).backgroundColor(Color.White).justifyContent(FlexAlign.SpaceBetween)
    }
  }
}