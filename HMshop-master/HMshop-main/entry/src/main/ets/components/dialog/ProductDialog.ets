import { SpecificationModel, SpecificationValue } from "../../model/SpecificationModel"
import { GoodsSKUModel } from "../../model/GoodsSKUModel"
import { PostAddCart, PostFastAdd } from "../../api/Index"

@Component
@CustomDialog
export struct ProductDialog {
  controller: CustomDialogController
  @Prop specification: SpecificationModel[];
  @Prop product: GoodsSKUModel[];
  @State count: number = 1
  @State selectedSpecs: Map<string, string> = new Map() // 存储每个规格类型选中的值
  @State currentProduct: GoodsSKUModel | null = null // 当前匹配的商品
  @State canOperate: boolean = false // 是否可以操作（所有规格都已选择）
  @State productId: number = 0 // 当前商品的productId
  @State goodsId: number = 0 // 当前商品的goodsId
  @State dataId: number = 0

  aboutToAppear() {
    // 默认不选中任何规格
    this.updateCurrentProduct()
  }

  // 更新当前匹配的商品
  updateCurrentProduct() {
    // 检查是否所有规格都已选择
    this.canOperate = this.selectedSpecs.size === this.specification.length

    if (!this.canOperate) {
      this.currentProduct = null
      this.productId = 0
      this.goodsId = 0
      return
    }

    // 获取所有选中的规格值
    const selectedValues: string[] = []
    this.specification.forEach(spec => {
      const value = this.selectedSpecs.get(spec.name)
      if (value) {
        selectedValues.push(value)
      }
    })

    // 在 productList 中查找匹配的商品
    this.currentProduct = this.product.find(p => {
      if (!p.specifications || p.specifications.length !== selectedValues.length) {
        return false
      }
      // 检查规格是否完全匹配（不考虑顺序）
      return selectedValues.every(val => p.specifications.includes(val))
    }) || null

    // 更新 productId 和 goodsId
    if (this.currentProduct) {
      this.productId = this.currentProduct.id
      this.goodsId = this.currentProduct.goodsId
      this.count = 1
    } else {
      this.productId = 0
      this.goodsId = 0
    }
  }

  // 选择规格
  selectSpecification(specName: string, value: string) {
    this.selectedSpecs.set(specName, value)
    this.updateCurrentProduct()
  }

  // 检查是否选中
  isSelected(specName: string, value: string): boolean {
    return this.selectedSpecs.get(specName) === value
  }

  // 获取显示的价格
  getDisplayPrice(): number {
    return this.currentProduct ? this.currentProduct.price : this.product[0]?.price || 0
  }

  // 获取显示的图片
  getDisplayImage(): string {
    return this.currentProduct?.url || this.product[0]?.url || ''
  }

  // 获取显示的规格文本
  getDisplaySpecs(): string {
    if (!this.canOperate) {
      return "请选择"
    }
    const specs: string[] = []
    this.specification.forEach(spec => {
      const value = this.selectedSpecs.get(spec.name)
      if (value) {
        specs.push(value)
      }
    })
    return specs.join(' ')
  }

  // 减少数量
  decreaseCount() {
    if (this.canOperate && this.count > 1) {
      this.count--
    }
  }

  // 增加数量
  increaseCount() {
    if (this.canOperate && this.currentProduct) {
      if (this.count < this.currentProduct.number) {
        this.count++
      } else {
        // 可以添加提示：库存不足
        AlertDialog.show({
          message: `库存不足，当前库存：${this.currentProduct.number}`
        })
      }
    }
  }

  // 加入购物车
  async addToCart() {
    if (!this.canOperate || !this.currentProduct) {
      AlertDialog.show({
        message: '请先选择完整的商品规格'
      })
      return
    }

    if (this.currentProduct.number <= 0) {
      AlertDialog.show({
        message: '商品已售罄'
      })
      return
    }

    // 执行加入购物车逻辑
    console.log('加入购物车：', {
      productId: this.productId,
      goodsId: this.goodsId,
      price: this.currentProduct.price,
      number: this.count,
      specifications: this.currentProduct.specifications
    })

    const ResData = await PostAddCart(this.goodsId, this.count, this.productId)
    if (ResData.errno == 0) {
      this.getUIContext().getPromptAction().showToast({ message: ResData.errmsg })
      // 通知购物车组件刷新数据（通过全局存储键）
      AppStorage.setOrCreate('cartRefresh', Date.now())
    } else if (ResData.errno == 402) {
      this.getUIContext().getPromptAction().showToast({ message: ResData.errmsg })
    } else if (ResData.errno == 501) {
      this.getUIContext().getRouter().pushUrl({ url: "pages/LoginPage" })
    }
    this.controller.close()
  }

  // 立即购买
  async buyNow() {
    console.log('立即购买:进入函数')
    if (!this.canOperate || !this.currentProduct) {
      AlertDialog.show({
        message: '请先选择完整的商品规格'
      })
      return
    }

    if (this.currentProduct.number <= 0) {
      AlertDialog.show({
        message: '商品已售罄'
      })
      return
    }
    const ResData = await PostFastAdd(this.goodsId, this.count, this.productId)
    if (ResData.errno == 0) {
      this.dataId = ResData.data;
      this.getUIContext().getRouter().pushUrl({ url: "pages/CheckoutPage", params: { dataId: this.dataId } })
    } else if (ResData.errno == 402) {
      this.getUIContext().getPromptAction().showToast({ message: ResData.errmsg })
    } else if (ResData.errno == 501) {
      this.getUIContext().getRouter().pushUrl({ url: "pages/LoginPage" })
    }
    this.controller.close()
  }

  build() {
    Column() {
      Scroll() {
        Column() {
          Row() {
            Column() {
              Image(this.getDisplayImage()).width(96).height(96)
            }.margin({ left: 20 })

            Column() {
              Text() {
                Span("￥").fontColor(Color.Red).fontSize(16)
                Span(this.getDisplayPrice().toString()).fontColor(Color.Red).fontSize(22).margin({ left: 2 })
              }

              Text(this.getDisplaySpecs())
                .fontSize(16)
                .fontColor(this.canOperate ? "#323233" : "#969799")
                .margin({ top: 10 })
            }
          }
          .width("100%")
          .padding(20)
          .border({ width: { bottom: 2 }, color: { bottom: "#f2f2f2" } })
          .align(Alignment.Start)

          // 遍历所有规格
          ForEach(this.specification, (spec: SpecificationModel) => {
            Column() {
              Row() {
                Text(spec.name).fontSize(14).fontColor("#323233")
              }.width("100%")

              Row() {
                ForEach(spec.valueList, (item: SpecificationValue) => {
                  Text(item.value)
                    .padding(8)
                    .fontSize(14)
                    .fontColor(this.isSelected(spec.name, item.value) ? "#ffffff" : "#323233")
                    .backgroundColor(this.isSelected(spec.name, item.value) ? "#ee0a24" : "#f7f8fa")
                    .border({
                      width: 1,
                      color: this.isSelected(spec.name, item.value) ? "#ee0a24" : "#ebedf0"
                    })
                    .borderRadius(4)
                    .margin({ left: 20, top: 10 })
                    .onClick(() => {
                      this.selectSpecification(spec.name, item.value)
                    })
                })
              }.width("100%")
            }
            .width("100%")
            .padding(20)
            .border({ width: { bottom: 2 }, color: { bottom: "#f2f2f2" } })
            .align(Alignment.Start)
          })

          Row() {
            Column() {
              Text("购买数量").fontSize(14).fontColor("#323233")
            }

            Row() {
              // 减号按钮
              Button('-')
                .fontSize(14)
                .backgroundColor(this.canOperate && this.count > 1 ? "#ffefefef" : "#f5f5f5")
                .fontColor(this.canOperate && this.count > 1 ? "#323233" : "#c8c9cc")
                .padding(8)
                .borderRadius(2)
                .enabled(this.canOperate && this.count > 1)
                .onClick(() => {
                  this.decreaseCount()
                })

              // 数值显示
              Text(this.count.toString())
                .fontSize(14)
                .padding(8)
                .width(50)
                .backgroundColor("#fff6f6f6")
                .margin({ left: 10, right: 10 })
                .textAlign(TextAlign.Center)

              // 加号按钮
              Button('+')
                .fontSize(14)
                .borderRadius(2)
                .backgroundColor(this.canOperate && this.currentProduct && this.count < this.currentProduct.number ?
                  "#ffefefef" : "#f5f5f5")
                .fontColor(this.canOperate && this.currentProduct && this.count < this.currentProduct.number ?
                  "#323233" : "#c8c9cc")
                .padding(8)
                .enabled(this.canOperate && this.currentProduct !== null && this.count < this.currentProduct.number)
                .onClick(() => {
                  this.increaseCount()
                })
            }
          }.width("90%").padding({ top: 10, bottom: 20 }).justifyContent(FlexAlign.SpaceBetween)
        }
      }.layoutWeight(1)

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
              .enabled(this.canOperate && this.currentProduct !== null && this.currentProduct.number > 0)
              .opacity(this.canOperate && this.currentProduct !== null && this.currentProduct.number > 0 ? 1 : 0.5)
              .onClick(() => {
                this.addToCart()
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
              .enabled(this.canOperate && this.currentProduct !== null && this.currentProduct.number > 0)
              .opacity(this.canOperate && this.currentProduct !== null && this.currentProduct.number > 0 ? 1 : 0.5)
              .onClick(() => {
                this.buyNow()
              })
          }
        }
      }
      .width("100%")
      .height(60)
      .border({ width: { top: 1 }, color: { top: "#f2f2f2" } })
      .margin({ bottom: 4 })
      .backgroundColor(Color.White)
      .alignItems(VerticalAlign.Bottom)
      .justifyContent(FlexAlign.SpaceBetween)
    }.height("100%").width("100%")
  }
}
