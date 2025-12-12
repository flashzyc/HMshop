import { BackBar } from '../view/BackBar'
import { PlaceDialog } from "../components/dialog/PlaceDialog"
import { SelectedAddress } from '../model/AddressData'
import { PostAddressDelete, PostSaveAddress } from '../api/AddressApi'

@Entry
@Component
struct NewAddressPage {
  @State name: string = ''
  @State tel: string = ''
  @State province: string = ''
  @State city: string = ''
  @State county: string = ''
  @State address: string = ''
  @State isDefault: boolean = false

  // 错误提示状态
  @State nameError: string = ''
  @State telError: string = ''
  @State placeError: string = ''
  @State addressError: string = ''

  placeDialogController: CustomDialogController = new CustomDialogController({
    builder: PlaceDialog({
      onConfirm: (result: SelectedAddress) => {
        this.province = result.province
        this.city = result.city
        this.county = result.county
        this.placeError = '' // 清除地区错误
      },
      initialProvince: this.province,
      initialCity: this.city,
      initialCounty: this.county
    }),
    alignment: DialogAlignment.Bottom,
    cornerRadius: {
      topLeft: 16,
      topRight: 16
    },
    width: "100%",
    height: "50%",
    backgroundColor: Color.White,
    customStyle: true
  })

  // 验证手机号格式
  validatePhone(phone: string): boolean {
    const phoneReg = /^1[3-9]\d{9}$/
    return phoneReg.test(phone)
  }

  // 验证表单
  validateForm(): boolean {
    let isValid = true

    // 验证姓名
    if (!this.name || this.name.trim() === '') {
      this.nameError = '请输入收货人姓名'
      isValid = false
    } else {
      this.nameError = ''
    }

    // 验证电话
    if (!this.tel || this.tel.trim() === '') {
      this.telError = '请输入收货人手机号'
      isValid = false
    } else if (!this.validatePhone(this.tel)) {
      this.telError = '请输入正确的手机号格式'
      isValid = false
    } else {
      this.telError = ''
    }

    // 验证地区
    if (!this.province || !this.city || !this.county) {
      this.placeError = '请选择省/市/区'
      isValid = false
    } else {
      this.placeError = ''
    }

    // 验证详细地址
    if (!this.address || this.address.trim() === '') {
      this.addressError = '请输入详细地址'
      isValid = false
    } else {
      this.addressError = ''
    }

    return isValid
  }

  deleteAddress() {
    AlertDialog.show({
      title: '提示',
      message: '确定要删除该地址吗？',
      primaryButton: {
        value: '取消',
        action: () => {}
      },
      secondaryButton: {
        value: '确定',
        action: async () => {
          const ResData = await PostAddressDelete();
          if (ResData.errno === 0) {
            this.getUIContext().getPromptAction().showToast({ message: "删除成功" })
            this.getUIContext().getRouter().back()
          } else {
            this.getUIContext().getPromptAction().showToast({ message: ResData.errmsg })
            this.getUIContext().getRouter().back()
          }
        }
      }
    })
  }

  async saveAddress() {
    // 验证表单
    if (!this.validateForm()) {
      return
    }

    // 这里添加保存地址的逻辑
    const ResData = await PostSaveAddress({
      name: this.name,
      tel: this.tel,
      country: "",
      province: this.province,
      city: this.city,
      county: this.county,
      areaCode: "110101",
      postalCode: "",
      addressDetail: this.address,
      isDefault: this.isDefault,
    });

    if (ResData.errno === 0) {
      this.getUIContext().getPromptAction().showToast({ message: "保存成功" })
      this.getUIContext().getRouter().back()
    } else {
      this.getUIContext().getPromptAction().showToast({ message: ResData.errmsg })
    }
  }

  build() {
    Column() {
      BackBar()
      Column() {
        // 姓名
        Column() {
          Row() {
            Text("姓名").fontSize(16).fontColor("#646566")
            TextInput({ placeholder: "收货人姓名" })
              .width("80%")
              .onChange((value) => {
                this.name = value
                if (this.nameError) {
                  this.nameError = '' // 输入时清除错误提示
                }
              })
              .backgroundColor("transparent")
              .margin({ left: 20 })
          }
          .width('100%')
          .height(60)
          .padding({ left: 20, right: 20, top: 10, bottom: 10 })
          .backgroundColor(Color.White)

          if (this.nameError) {
            Text(this.nameError)
              .fontSize(12)
              .fontColor("#ee0a24")
              .width('100%')
              .padding({ left: 20, top: 4, bottom: 4 })
              .backgroundColor(Color.White)
          }
        }

        // 电话
        Column() {
          Row() {
            Text("电话").fontSize(16).fontColor("#646566")
            TextInput({ placeholder: "收货人手机号" })
              .type(InputType.Number)
              .width("80%")
              .onChange((value) => {
                this.tel = value
                if (this.telError) {
                  this.telError = '' // 输入时清除错误提示
                }
              })
              .backgroundColor("transparent")
              .margin({ left: 20 })
          }
          .width('100%')
          .height(60)
          .padding({ left: 20, right: 20, top: 10, bottom: 10 })
          .backgroundColor(Color.White)

          if (this.telError) {
            Text(this.telError)
              .fontSize(12)
              .fontColor("#ee0a24")
              .width('100%')
              .padding({ left: 20, top: 4, bottom: 4 })
              .backgroundColor(Color.White)
          }
        }

        // 地区
        Column() {
          Row() {
            Text("地区").fontSize(16).fontColor("#646566")
            Text(this.province && this.city && this.county
              ? `${this.province} ${this.city} ${this.county}`
              : '选择省/市/区')
              .fontSize(16)
              .fontColor(this.province ? '#323233' : '#c8c9cc')
              .layoutWeight(1)
              .margin({ left: 38, right: 10 })
            Image($r("app.media.next"))
              .width(16)
              .height(16)
          }
          .width('100%')
          .height(60)
          .padding({ left: 20, right: 20, top: 10, bottom: 10 })
          .backgroundColor(Color.White)
          .onClick(() => {
            this.placeDialogController.open()
          })

          if (this.placeError) {
            Text(this.placeError)
              .fontSize(12)
              .fontColor("#ee0a24")
              .width('100%')
              .padding({ left: 20, top: 4, bottom: 4 })
              .backgroundColor(Color.White)
          }
        }

        // 详细地址
        Column() {
          Row() {
            Text("详细地址").fontSize(16).fontColor("#646566")
            TextInput({ placeholder: "街道门牌号、楼层房间等信息" })
              .width("80%")
              .onChange((value) => {
                this.address = value
                if (this.addressError) {
                  this.addressError = '' // 输入时清除错误提示
                }
              })
              .backgroundColor("transparent")
              .margin({ left: 20 })
          }
          .width('100%')
          .height(60)
          .padding({ left: 20, right: 20, top: 10, bottom: 10 })
          .backgroundColor(Color.White)

          if (this.addressError) {
            Text(this.addressError)
              .fontSize(12)
              .fontColor("#ee0a24")
              .width('100%')
              .padding({ left: 20, top: 4, bottom: 4 })
              .backgroundColor(Color.White)
          }
        }

        // 设为默认地址
        Row() {
          Text("设为默认地址").fontSize(16).fontColor("#646566")
          Toggle({ type: ToggleType.Switch, isOn: this.isDefault })
            .onChange((isOn) => {
              this.isDefault = isOn
            })
        }
        .width('100%')
        .height(60)
        .padding({ left: 20, right: 20, top: 10, bottom: 10 })
        .backgroundColor(Color.White)
        .justifyContent(FlexAlign.SpaceBetween)

        // 保存按钮
        Row() {
          Button("保存")
            .width("100%")
            .height(40)
            .backgroundColor("#ee0a24")
            .fontColor(Color.White)
            .onClick(() => {
              this.saveAddress()
            })
        }
        .width('100%')
        .height(60)
        .padding({ left: 20, right: 20, top: 10, bottom: 10 })
        .backgroundColor(Color.White)

        // 删除按钮
        Row() {
          Button("删除")
            .width("100%")
            .height(40)
            .backgroundColor("#fff")
            .fontColor(Color.Black)
            .border({ width: 1, color: "#ffe9e8e8" })
            .onClick(() => {
              this.deleteAddress()
            })
        }
        .width('100%')
        .height(60)
        .padding({ left: 20, right: 20, top: 10, bottom: 10 })
        .backgroundColor(Color.White)
      }
    }
    .backgroundColor("#f2f2f2")
    .height('100%')
    .width('100%')
  }
}