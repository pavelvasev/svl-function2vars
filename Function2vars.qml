Robot {
    icon: "f(x,y)"

    params: [ro,h1,ap,bp,te1,status]

    //////////////////////////////////////////////////////////////////
    property alias ate1: te1

    Column {
        id: te1
        property var guid: "func_code"
        property var value: "function (x,y) {\nreturn x-y;\n}"

        onValueChanged: txt.text = value;

        TextEdit {
            id: txt
            width: 450
            height: 100
            text: te1.value

            onTextChanged: {
                if (te1.value == text) return;
                btEnter.enabled = true;
            }
        }

        Button {
            id: btEnter
            text: "ВВОД"
            enabled: false
            anchors.margins: 5
            onClicked: {
              te1.value = txt.text;
              enabled = false;
            }
        }

    }

    //////////////////////////////////////////////////////////////////
    Row {
        id: ro
        spacing: 5
        Param {
            id: ap
            text: "Параметр a"
            guid: "aparam"
            tag: null
        }

        Param {
            id: bp
            text: "Параметр b"
            guid: "bparam"
            tag: null
        }
    }
    Text {
        text: "Параметры можно использовать в коде функции как переменные с именами a и b"
        id: h1
    }

    property var aparam: ap.value
    property var bparam: bp.value
    onAparamChanged: updatefunc()
    onBparamChanged: updatefunc()

    //////////////////////////////////////////////////////////////////

    property var func

    property var func_eval_code: "var a = aparam; var b = bparam; ("+te1.value+")"
    onFunc_eval_codeChanged: updatefunc();

    function updatefunc() {
        try {
            func = eval( func_eval_code );
            status.text = "компиляция прошла успешно";
        } catch (err) {
            status.text = "ошибка компиляции, см консоль";
            console.error(err);
        }
    }

    Text {
        id: status
    }
    property alias astatus: status

    //////////////////////////////////////////////////////////////////

    function recompute() {
      updatefunc();
    }


    Component.onCompleted: updatefunc();
}
