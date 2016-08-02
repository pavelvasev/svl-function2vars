Deed {
  id: deed
  icon: "f(u,v)"  

  Input2 {
    id: in2
    function feel( obj ) { return (wp.get_type( obj ) == "Function2vars") && obj !== res; }
  }

  Function2vars {
    id: res

    func_eval_code: "var u = ufunc; var v = vfunc; var a = aparam; var b = bparam; ("+ate1.value+")"

    // qmlaspect тут пригодилось бы prev_value, тогда:
    // func_eval_code: "var u = ufunc; var v = vfunc;" + prev_value
    // аналогично бы и с функциями..
    // но формально вроде бы можно докопаться будет, типо this.val или еще что

    property var ufunc: deed.input ? deed.input.func : function() { return 0; };
    property var vfunc: in2.result ? in2.result.func : function() { return 0; };
    onUfuncChanged: updatefunc()
    onVfuncChanged: updatefunc()

    ate1.value: "function (x,y) {\n  var u_ = u(x,y);\n  var v_ = v(x,y);\n  return u_ > v_ ? (u_ + v_)/2 : null;\n}"
  }

  Text {
    id: t1
    text: "Значения функций доступны в теле кода новой функции под именами u(x,y) и v(x,y)"
  }

  params: [in2.param, t1, res.ate1]

  PerformDeed {
    name: "paint-f"
    input: res
    parentToObject: true
  }
}