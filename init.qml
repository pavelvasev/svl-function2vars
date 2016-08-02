import "."

Item {

  Column {
    property var tag: "right"

    PerformDeedButton {
      name: "add-f"
      record: true
      text: "Добавить функцию f(x,y)"
      id: bt
    }

    spacing: 2
    TracingDeeds { input: bt }
  }

}