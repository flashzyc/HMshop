// ShopCart.ets - 购物车组件
import { CartListModel } from "../model/CartListModel";
import { CartTotalModel } from "../model/CartTotalModel";
import { GetShopCartList, PostShopCartList, PostDeleteShop, PostUpdate } from "../api/ShopCartApi"

@Component
export struct ShopCart {
  @State cartList: Array<CartListModel> = [];
  @State cartTotal: Partial<CartTotalModel> = {};
  @State isAllChecked: boolean = false;
  @State isEditing: boolean = false;
  @State isRefreshing: boolean = false;
  @State updateFlag: number = 0;
  @State totalAmount: number = 0; // 本地计算的总价
  @State checkedCount: number = 0; // 本地计算的选中数量
  @Prop refreshKey: number = 0; // 外部触发刷新

  private updatingItems: Set<number> = new Set();
  private lastRefreshKey: number = -1;

  async aboutToAppear() {
    this.lastRefreshKey = this.refreshKey;
    await this.loadCartData();
  }

  aboutToRender() {
    if (this.refreshKey !== this.lastRefreshKey) {
      this.lastRefreshKey = this.refreshKey;
      this.loadCartData();
    }
  }
  private forceUpdate() {
    this.updateFlag++;
  }

  // 本地计算总价和数量
  private calculateTotal() {
    const checkedItems = this.cartList.filter(item => item.checked);
    this.checkedCount = checkedItems.reduce((sum, item) => sum + item.number, 0);
    this.totalAmount = checkedItems.reduce((sum, item) => sum + (item.price * item.number), 0);
    console.log(`计算总价: 选中${this.checkedCount}件，合计￥${this.totalAmount.toFixed(2)}`);
  }

  // 加载购物车数据
  async loadCartData() {
    const ResData = await GetShopCartList();
    if (ResData.errno != 0) {
      this.getUIContext().getRouter().pushUrl({ url: "pages/LoginPage" })
      this.getUIContext().getPromptAction().showToast({ message: ResData.errmsg })
    } else {
      this.cartList = ResData.data.cartList;
      this.cartTotal = ResData.data.cartTotal;
      this.updateAllCheckedState();
      this.calculateTotal(); //  计算总价
      this.forceUpdate();
    }
  }

  async onRefresh() {
    this.isRefreshing = true;
    await this.loadCartData();
    this.isRefreshing = false;
  }

  updateAllCheckedState() {
    this.isAllChecked = this.cartList.length > 0 && this.cartList.every(item => item.checked);
  }

  // 重构：切换单个商品选中状态
  async toggleItemCheck(item: CartListModel) {
    if (this.updatingItems.has(item.id)) {
      console.log(`商品 ${item.goodsName} 正在更新中，跳过本次操作`);
      return;
    }

    this.updatingItems.add(item.id);

    const targetStatus = item.checked ? 0 : 1;
    console.log(`切换商品: ${item.goodsName}, 目标状态=${targetStatus}`);

    try {
      const ResData = await PostShopCartList([item.productId], targetStatus);

      if (ResData.errno === 0) {
        // 更新数据
        this.cartList = ResData.data.cartList;
        this.cartTotal = ResData.data.cartTotal;
        this.updateAllCheckedState();
        this.calculateTotal(); // 重新计算总价
        this.forceUpdate();
        console.log(`切换成功: ${item.goodsName}`);
      } else {
        this.getUIContext().getPromptAction().showToast({ message: ResData.errmsg })
      }
    } catch (error) {
      console.error("切换选中状态失败", error);
    } finally {
      this.updatingItems.delete(item.id);
    }
  }

  // 重构：切换全选（去掉防抖检查）
  async toggleAllCheck() {
    const targetStatus = this.isAllChecked ? 0 : 1;
    const allProductIds = this.cartList.map(item => item.productId);

    console.log(`切换全选: 目标状态=${targetStatus}, 商品数=${allProductIds.length}`);

    // 标记所有商品为更新中
    this.cartList.forEach(item => this.updatingItems.add(item.id));

    try {
      const ResData = await PostShopCartList(allProductIds, targetStatus);

      if (ResData.errno === 0) {
        this.cartList = ResData.data.cartList;
        this.cartTotal = ResData.data.cartTotal;
        this.updateAllCheckedState();
        this.calculateTotal(); // 重新计算总价
        this.forceUpdate();
        console.log(`全选切换成功 isAllChecked=${this.isAllChecked}`);
      } else {
        this.getUIContext().getPromptAction().showToast({ message: ResData.errmsg })
      }
    } catch (error) {
      console.error("切换全选失败", error);
    } finally {
      this.updatingItems.clear();
    }
  }

  async deleteItem(item: CartListModel) {
    AlertDialog.show({
      title: '提示',
      message: '确定要删除该商品吗？',
      primaryButton: {
        value: '取消',
        action: () => {}
      },
      secondaryButton: {
        value: '确定',
        action: async () => {
          const ResData = await PostDeleteShop([item.productId]);
          if (ResData.errno === 0) {
            this.cartList = ResData.data.cartList;
            this.cartTotal = ResData.data.cartTotal;
            this.updateAllCheckedState();
            this.calculateTotal(); //  重新计算总价
            this.forceUpdate();
            this.getUIContext().getPromptAction().showToast({ message: "删除成功" })
          } else {
            this.getUIContext().getPromptAction().showToast({ message: ResData.errmsg })
          }
        }
      }
    })
  }

  async deleteCheckedItems() {
    const checkedItems = this.cartList.filter(item => item.checked);
    if (checkedItems.length === 0) {
      this.getUIContext().getPromptAction().showToast({ message: "请选择要删除的商品" })
      return;
    }

    AlertDialog.show({
      title: '提示',
      message: `确定要删除已选的${checkedItems.length}件商品吗？`,
      primaryButton: {
        value: '取消',
        action: () => {}
      },
      secondaryButton: {
        value: '确定',
        action: async () => {
          const productIds = checkedItems.map(item => item.productId);
          const ResData = await PostDeleteShop(productIds);
          if (ResData.errno === 0) {
            this.cartList = ResData.data.cartList;
            this.cartTotal = ResData.data.cartTotal;
            this.updateAllCheckedState();
            this.calculateTotal(); // 重新计算总价
            this.forceUpdate();
            this.getUIContext().getPromptAction().showToast({ message: "删除成功" })
          } else {
            this.getUIContext().getPromptAction().showToast({ message: ResData.errmsg })
          }
        }
      }
    })
  }

  async updateItemNumber(item: CartListModel, newNumber: number) {
    if (newNumber < 1) {
      return;
    }

    if (this.updatingItems.has(item.id)) {
      console.log(`商品 ${item.goodsName} 正在更新中，跳过本次操作`);
      return;
    }

    this.updatingItems.add(item.id);

    try {
      console.log(`开始更新商品数量: ${item.goodsName}, 新数量=${newNumber}`);

      const ResData = await PostUpdate(newNumber, item.goodsId, item.id, item.productId);

      if (ResData.errno === 0) {
        console.log(`更新成功: ${item.goodsName}, 数量=${newNumber}`);

        const itemIndex = this.cartList.findIndex(i => i.id === item.id);
        if (itemIndex !== -1) {
          this.cartList[itemIndex].number = newNumber;

          const tempList = [...this.cartList];
          this.cartList = [];
          this.cartList = tempList;
          this.calculateTotal(); //  重新计算总价
          this.forceUpdate();
        }

        this.getUIContext().getPromptAction().showToast({ message: "更新成功" })
      } else {
        console.error(`更新失败: ${ResData.errmsg}`);
        this.getUIContext().getPromptAction().showToast({ message: ResData.errmsg })
      }
    } catch (error) {
      console.error("更新数量异常:", error);
      this.getUIContext().getPromptAction().showToast({ message: "更新失败，请重试" })
    } finally {
      this.updatingItems.delete(item.id);
    }
  }

  async handleEditToggle() {
    const wasEditing = this.isEditing;
    this.isEditing = !this.isEditing;

    if (wasEditing && !this.isEditing) {
      console.log("退出编辑模式，重新加载购物车数据");
      await this.loadCartData();
    }
  }

  @Builder
  CartListItem(item: CartListModel, index: number) {
    Row() {
      // 去掉 CheckboxGroup 的 group，独立控制
      Checkbox({ name: `item_${item.id}` })
        .select(item.checked)
        .selectedColor("#ee0a24")
        .onChange(async (value: boolean) => {
          // 单次判断，避免重复操作
          if (value !== item.checked) {
            console.log(`Checkbox 点击: ${item.goodsName}, 新状态=${value}, 旧状态=${item.checked}`);
            await this.toggleItemCheck(item);
          }
        })
        .margin({ left: 10, right: 10 })

      Image(item.picUrl)
        .width(80)
        .height(80)
        .borderRadius(4)
        .margin({ right: 10 })

      Column() {
        Text(item.goodsName)
          .fontSize(14)
          .fontColor("#333")
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .margin({ bottom: 5 })

        Text(item.specifications.join(' '))
          .fontSize(12)
          .fontColor("#999")
          .margin({ bottom: 5 })

        Row() {
          Text(`￥${item.price.toFixed(2)}`)
            .fontSize(16)
            .fontColor("#ff0000")
            .fontWeight(FontWeight.Bold)

          Blank()

          if (this.isEditing) {
            Row({ space: 5 }) {
              Button() {
                Text("-")
                  .fontSize(18)
                  .fontColor(item.number <= 1 || this.updatingItems.has(item.id) ? "#ccc" : "#333")
              }
              .width(32)
              .height(32)
              .backgroundColor(item.number <= 1 || this.updatingItems.has(item.id) ? "#f0f0f0" : "#f5f5f5")
              .type(ButtonType.Normal)
              .borderRadius(4)
              .enabled(item.number > 1 && !this.updatingItems.has(item.id))
              .opacity(this.updatingItems.has(item.id) ? 0.5 : 1)
              .onClick(async () => {
                if (item.number > 1 && !this.updatingItems.has(item.id)) {
                  await this.updateItemNumber(item, item.number - 1);
                }
              })

              Text(`${item.number}`)
                .fontSize(14)
                .fontColor(this.updatingItems.has(item.id) ? "#999" : "#333")
                .width(40)
                .textAlign(TextAlign.Center)
                .padding({ left: 5, right: 5 })
                .key(`number_${item.id}_${item.number}_${this.updateFlag}`)

              Button() {
                Text("+")
                  .fontSize(18)
                  .fontColor(this.updatingItems.has(item.id) ? "#ccc" : "#333")
              }
              .width(32)
              .height(32)
              .backgroundColor(this.updatingItems.has(item.id) ? "#f0f0f0" : "#f5f5f5")
              .type(ButtonType.Normal)
              .borderRadius(4)
              .enabled(!this.updatingItems.has(item.id))
              .opacity(this.updatingItems.has(item.id) ? 0.5 : 1)
              .onClick(async () => {
                if (!this.updatingItems.has(item.id)) {
                  await this.updateItemNumber(item, item.number + 1);
                }
              })
            }
          } else {
            Text(`x${item.number}`)
              .fontSize(14)
              .fontColor("#666")
              .key(`number_display_${item.id}_${item.number}_${this.updateFlag}`)
          }
        }
        .width("100%")
        .margin({ bottom: 5 })

        if (!this.isEditing) {
          Text(item.addTime)
            .fontSize(11)
            .fontColor("#ccc")
        }
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.SpaceBetween)

      if (this.isEditing) {
        Button("删除")
          .fontSize(14)
          .fontColor("#ff0000")
          .backgroundColor(Color.Transparent)
          .onClick(() => {
            this.deleteItem(item);
          })
          .margin({ right: 10 })
      }
    }
    .width("100%")
    .padding(10)
    .backgroundColor(Color.White)
    .borderRadius(8)
    .margin({ bottom: 10 })
  }

  build() {
    Column() {
      Stack({ alignContent: Alignment.Bottom }) {
        Column() {
          Row() {
            Image($r("app.media.bianji")).width(15).height(15)
            Text(this.isEditing ? "完成" : "编辑")
              .fontSize(16)
              .padding(4)
              .onClick(async () => {
                await this.handleEditToggle();
              })
          }
          .width("100%")
          .height(50)
          .backgroundColor(Color.White)
          .justifyContent(FlexAlign.End)
          .padding({ right: 15 })

          Refresh({ refreshing: $$this.isRefreshing }) {
            Column() {
          if (this.cartList.length > 0) {
            List({ space: 0 }) {
              ForEach(this.cartList, (item: CartListModel, index: number) => {
                ListItem() {
                  this.CartListItem(item, index)
                }
              }, (item: CartListModel) => `${item.id}_${item.number}_${item.checked}_${this.updateFlag}`)
            }
            .width("100%")
            .layoutWeight(1)
            .padding({
              left: 10,
              right: 10,
              top: 10,
              bottom: 70
            })
            .scrollBar(BarState.Off)
          } else {
            Column() {
              Image($r("app.media.gowu"))
                .width(100)
                .height(100)
                .margin({ bottom: 20 })
              Text("购物车暂无数据")
                .fontColor("#999")
                .fontSize(14)
            }
            .width("100%")
            .height("100%")
            .justifyContent(FlexAlign.Center)
          }
            }
            .width("100%")
            .height("100%")
          }
          .onRefreshing(() => {
            this.onRefresh();
          })
          .layoutWeight(1)
        }
        .width("100%")
        .height("100%")

        Row() {
          Row() {
            // 去掉 CheckboxGroup，改用普通 Checkbox
            Checkbox({ name: 'selectAll' })
              .select(this.isAllChecked)
              .selectedColor("#ee0a24")
              .onChange(async (value: boolean) => {
                console.log(`全选 Checkbox 点击: 新状态=${value}, 旧状态=${this.isAllChecked}`);
                if (value !== this.isAllChecked) {
                  await this.toggleAllCheck();
                }
              })
              .margin({ right: 5 })

            Text("全选")
              .fontSize(14)
              .fontColor("#333")
              .onClick(async () => {
                console.log("点击全选文字");
                await this.toggleAllCheck();
              })
          }
          .margin({ left: 10 })

          Blank()

          if (this.isEditing) {
            Button("删除")
              .fontSize(16)
              .height(50)
              .width(100)
              .fontColor(Color.White)
              .type(ButtonType.Normal)
              .backgroundColor("#ff0000")
              .onClick(() => {
                this.deleteCheckedItems();
              })
          } else {
            Row() {
              Column() {
                Text("合计:")
                  .fontSize(14)
                  .fontColor("#666")
                //  使用本地计算的总价
                Text(`￥${this.totalAmount.toFixed(2)}`)
                  .fontSize(18)
                  .fontColor("#ff0000")
                  .fontWeight(FontWeight.Bold)
                  .key(`total_${this.updateFlag}`)
              }
              .alignItems(HorizontalAlign.End)
              .margin({ right: 15 })

              // 使用本地计算的数量
              Button(`结算(${this.checkedCount})`)
                .fontSize(16)
                .height(50)
                .width(100)
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
                .onClick(() => {
                  if (this.checkedCount > 0) {
                    this.getUIContext().getRouter().pushUrl({ url: "pages/CheckoutPage" })
                  } else {
                    this.getUIContext().getPromptAction().showToast({ message: "请选择要结算的商品" })
                  }
                })
            }
          }
        }
        .width("100%")
        .height(60)
        .backgroundColor(Color.White)
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .shadow({ radius: 10, color: "#eeeeee", offsetY: -2 })
      }
      .width("100%")
      .layoutWeight(1)
    }
    .height('100%')
    .width('100%')
    .backgroundColor("#f2f2f2")
  }
}
