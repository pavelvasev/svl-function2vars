Robot {
    icon: "f(x,y)"

    params: [ro,h1,ap,bp,te1,status]

    property bool iLoveParams: true

    //////////////////////////////////////////////////////////////////
    property alias ate1: te1

    TextEditCode {
        id: te1
        guid: "func_code"
        value: "function (x,y) {\nreturn x-y;\n}"
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
