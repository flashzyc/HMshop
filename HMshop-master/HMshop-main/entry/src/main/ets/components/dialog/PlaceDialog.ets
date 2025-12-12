import { ProvinceData, CityData, AreaData, SelectedAddress } from '../../model/AddressData'
import { PlaceData } from "../../model/PlaceData"

@Component
@CustomDialog
export struct PlaceDialog {
  controller: CustomDialogController

  // 静态数据
  private readonly provinceData: ProvinceData[] = PlaceData

  // 选中索引
  @State provinceIndex: number = 0
  @State cityIndex: number = 0
  @State countyIndex: number = 0

  // 动态数据列表
  @State cityList: CityData[] = []
  @State countyList: AreaData[] = []

  // 回调函数
  onConfirm?: (result: SelectedAddress) => void

  // 初始值
  initialProvince?: string
  initialCity?: string
  initialCounty?: string

  aboutToAppear(): void {
    this.initializeSelection()
  }

  /**
   * 初始化选中项 - 修复初始数据不显示问题
   */
  private initializeSelection(): void {
    // 1. 设置省份
    if (this.initialProvince) {
      const provIndex = this.provinceData.findIndex(p => p.province === this.initialProvince)
      if (provIndex !== -1) {
        this.provinceIndex = provIndex
      }
    }

    // 2. 加载城市数据
    this.updateCityList(this.provinceIndex)

    // 3. 使用 setTimeout 确保城市数据已更新
    setTimeout(() => {
      if (this.initialCity && this.cityList.length > 0) {
        const cityIdx = this.cityList.findIndex(c => c.city === this.initialCity)
        if (cityIdx !== -1) {
          this.cityIndex = cityIdx
        }
      }

      // 4. 加载区县数据
      this.updateCountyList(this.cityIndex)

      // 5. 设置区县
      setTimeout(() => {
        if (this.initialCounty && this.countyList.length > 0) {
          const countyIdx = this.countyList.findIndex(a => a.area === this.initialCounty)
          if (countyIdx !== -1) {
            this.countyIndex = countyIdx
          }
        }
      }, 0)
    }, 0)
  }

  /**
   * 更新城市列表
   */
  private updateCityList(provinceIndex: number): void {
    const province = this.provinceData[provinceIndex]
    this.cityList = province?.citys || []

    // 如果当前城市索引超出范围，重置为0
    if (this.cityIndex >= this.cityList.length) {
      this.cityIndex = 0
    }
  }

  /**
   * 更新区县列表
   */
  private updateCountyList(cityIndex: number): void {
    const city = this.cityList[cityIndex]
    this.countyList = city?.areas || []

    // 如果当前区县索引超出范围，重置为0
    if (this.countyIndex >= this.countyList.length) {
      this.countyIndex = 0
    }
  }

  /**
   * 省份改变 - 移除防抖，直接更新
   */
  onProvinceChange(value: string | string[], index: number | number[]): void {
    const selectedIndex = Array.isArray(index) ? index[0] : index
    this.provinceIndex = selectedIndex

    // 重置并更新城市数据
    this.cityIndex = 0
    this.countyIndex = 0
    this.updateCityList(selectedIndex)
    this.updateCountyList(0)
  }

  /**
   * 城市改变
   */
  onCityChange(value: string | string[], index: number | number[]): void {
    if (this.cityList.length === 0) return

    const selectedIndex = Array.isArray(index) ? index[0] : index
    this.cityIndex = selectedIndex

    // 重置并更新区县数据
    this.countyIndex = 0
    this.updateCountyList(selectedIndex)
  }

  /**
   * 区县改变
   */
  onCountyChange(value: string | string[], index: number | number[]): void {
    if (this.countyList.length === 0) return

    const selectedIndex = Array.isArray(index) ? index[0] : index
    this.countyIndex = selectedIndex
  }

  /**
   * 获取选中结果
   */
  private getSelectedResult(): SelectedAddress {
    return {
      province: this.provinceData[this.provinceIndex]?.province || '',
      city: this.cityList[this.cityIndex]?.city || '',
      county: this.countyList[this.countyIndex]?.area || ''
    }
  }

  /**
   * 验证选择是否完整
   */
  private isValidSelection(): boolean {
    return this.provinceData.length > 0 &&
      this.cityList.length > 0 &&
      this.countyList.length > 0
  }

  /**
   * 确认选择
   */
  private confirmSelection(): void {
    if (!this.isValidSelection()) return

    const result = this.getSelectedResult()
    this.onConfirm?.(result)
    this.controller.close()
  }

  build() {
    Column() {
      // 标题栏
      this.buildHeader()

      // 选择器区域 - 动态显示列数
      Row() {
        // 省份选择器（始终显示）
        this.buildProvincePicker()

        // 城市选择器（有数据时显示）
        if (this.cityList.length > 0) {
          this.buildCityPicker()
        }

        // 区县选择器（有数据时显示）
        if (this.countyList.length > 0) {
          this.buildCountyPicker()
        }
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('50%')
    .backgroundColor(Color.White)
  }

  /**
   * 构建标题栏
   */
  @Builder
  buildHeader() {
    Row() {
      Text('取消')
        .fontSize(16)
        .fontColor('#999999')
        .onClick(() => this.controller.close())

      Text('选择地区')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .layoutWeight(1)
        .textAlign(TextAlign.Center)

      Text('确定')
        .fontSize(16)
        .fontColor(this.isValidSelection() ? '#1989fa' : '#cccccc')
        .enabled(this.isValidSelection())
        .onClick(() => this.confirmSelection())
    }
    .width('100%')
    .height(50)
    .padding({ left: 16, right: 16 })
    .justifyContent(FlexAlign.SpaceBetween)
    .borderWidth({ bottom: 1 })
    .borderColor('#f0f0f0')
  }

  /**
   * 构建省份选择器
   */
  @Builder
  buildProvincePicker() {
    Column() {
      TextPicker({
        range: this.provinceData.map(item => item.province),
        selected: this.provinceIndex
      })
        .onChange((value: string | string[], index: number | number[]) => {
          this.onProvinceChange(value, index)
        })
    }
    .width(this.getColumnWidth())
  }

  /**
   * 构建城市选择器
   */
  @Builder
  buildCityPicker() {
    Column() {
      TextPicker({
        range: this.cityList.map(item => item.city),
        selected: this.cityIndex
      })
        .onChange((value: string | string[], index: number | number[]) => {
          this.onCityChange(value, index)
        })
    }
    .width(this.getColumnWidth())
  }

  /**
   * 构建区县选择器
   */
  @Builder
  buildCountyPicker() {
    Column() {
      TextPicker({
        range: this.countyList.map(item => item.area),
        selected: this.countyIndex
      })
        .onChange((value: string | string[], index: number | number[]) => {
          this.onCountyChange(value, index)
        })
    }
    .width(this.getColumnWidth())
  }

  /**
   * 动态计算列宽
   */
  private getColumnWidth(): string {
    const columnCount = 1 +
      (this.cityList.length > 0 ? 1 : 0) +
      (this.countyList.length > 0 ? 1 : 0)

    return `${100 / columnCount}%`
  }
}