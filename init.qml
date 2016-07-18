import "."

Item {

  PerformDeed {
    name: "load-ability"
    input: [Qt.resolvedUrl( "add-f/TheAbility.qml" ),Qt.resolvedUrl( "paint-f/TheAbility.qml" )]
  }

  PerformDeedButton {
    name: "add-f"
    record: true
    text: "Добавить функцию f(x,y)"
  }

}