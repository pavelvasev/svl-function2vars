import "."

Item {

  PerformDeed {
    name: "load-ability"
    input: [Qt.resolvedUrl( "add-f.ab.json" ),
            Qt.resolvedUrl( "paint-f/TheAbility.qml" ),
            Qt.resolvedUrl( "combine-f/TheAbility.qml" ),
            ]
  }

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