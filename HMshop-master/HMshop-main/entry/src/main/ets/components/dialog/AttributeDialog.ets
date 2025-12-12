import { AttributeModel } from "../../model/AttributeModel";

@Component
@CustomDialog
export struct AttributeDialog {
  controller: CustomDialogController
  @Prop attributeList: AttributeModel[];

  build() {
    Column() { // 外层Column控制整体布局
      Row() {
        Text("商品属性").fontSize(18);
      }.width('100%').padding(20).justifyContent(FlexAlign.Center)

      Scroll() {
        Column() {
          ForEach(this.attributeList, (item: AttributeModel) => {
            Row() {
              Text(item.attribute)
                .fontSize(14)
                .width("30%")
                .padding({
                  left: 20,
                  right: 20,
                  top: 10,
                  bottom: 10
                });
              Text(item.value)
                .fontSize(14)
                .width("70%")
                .padding({
                  left: 20,
                  right: 20,
                  top: 10,
                  bottom: 10
                });
            }.border({width: {top: 1},color: {top:"#E5E5E5"}})
          })
        }
      }
    }
    .padding({bottom:60})
    .height('100%')
    .width('100%')
  }
}
