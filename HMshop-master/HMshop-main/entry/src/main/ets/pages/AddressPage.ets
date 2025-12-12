import { BackBar } from "../view/BackBar"
import { GetAddressList } from "../api/AddressApi"
import { AddressModel } from "../model/AddressModel";

@Entry
@Component
struct AddressPage {
  @State list: Array<AddressModel> = []

  async aboutToAppear() {
    const ResData = await GetAddressList();
    this.list = ResData.data.list;
  }
  async onPageShow(){
    const ResData = await GetAddressList();
    this.list = ResData.data.list;
  }

  build() {
    Column() {
      BackBar()

      List() {
        ForEach(this.list, (item: AddressModel) => {
          ListItem() {
            Row() {
              Checkbox().padding(10).onChange(() => {
                this.getUIContext().getRouter().replaceUrl({
                  url: "pages/CheckoutPage",
                  params: {
                    addressId: item.id
                  }
                })
              })
              Column() {
                Row() {
                  Text(item.name)
                  Text(item.tel).margin({ left: 4 })
                }.margin({ top: 4 }).justifyContent(FlexAlign.Start).align(Alignment.Start)

                Row() {
                  Text(item.province + item.city + item.county).fontSize(14).fontColor("#ffaca2a2")
                  Text(item.addressDetail).margin({ left: 4 }).fontSize(14).fontColor("#ffaca2a2")
                }.margin({ top: 4 }).justifyContent(FlexAlign.Start).align(Alignment.Start)
              }.width("70%").padding({ top: 10, bottom: 10 }).alignItems(HorizontalAlign.Start)
            }.width("100%")
          }.width("90%").margin({ top: 10, left: 18, right: 20 }).backgroundColor(Color.White).borderRadius(6)
        })
      }.layoutWeight(1).width("100%")

      Row() {
        Button("新增地址")
          .width("88%")
          .height(36)
          .margin({ top: 4, bottom: 4 })
          .fontColor(Color.White)
          .backgroundColor("#ee0a24")
          .onClick(() => {
            this.getUIContext().getRouter().pushUrl({
              url: "pages/NewAddressPage"
            })
          })
      }.width("100%").height(44).backgroundColor(Color.White).justifyContent(FlexAlign.Center)
    }
    .backgroundColor("#f2f2f2")
    .height('100%')
    .width('100%')
  }
}