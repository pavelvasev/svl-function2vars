Deed {
  id: deed
  details: "Расчет идет на сетке 0..99x0..99"

  Array2dRobot {
    id: arr
  }

  property var func: deed.input.func

  onFuncChanged: compute();

  function compute() {
    var f = func;
    if (!f) return;
    var res = [];

    for (var x=0; x<100; x++) 
    for (var y=0; y<100; y++) {
      var z = f(x,y);
      res.push( [x,y,z] );
    }
    arr.arr = res;
  }

  Component.onCompleted: compute()

  PerformDeed {
    name: "array2d-to-points"
    input: arr
    parentToObject: true
  }
}