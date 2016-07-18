Robot {
  icon: "f(x,y)"
  
  TextEditParam {
    id: te1
    value: "function (x,y) {\nreturn x-y;\n}"
    width: 300
    onValueChanged: if (inited) updatefunc();
    guid: "func_code"
  }

  property var func

  function updatefunc() {
    try {
      func = eval( "("+te1.value+")" )
      status.text = "компиляция прошла успешно";
    } catch (err) {
      status.text = "ошибка компиляции, см консоль";
      console.error(err);
    }
  }

  Text {
    id: status
  }
  
  params: [te1,status]
  
  property bool inited: false
  Component.onCompleted: {
    updatefunc();
    inited = true;
  }
}