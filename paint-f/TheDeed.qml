// todo быстрый рендеринг может сделать за счет укрупнения сетки.. 
Deed {
  id: deed

  params: [t1,field,fastrender]

  Text {
    id: t1
  }

  TextEditParam {
    text: "Область расчета: 1 строка: xmin xmax xшаг, 2 строка: ymin ymax yшаг"
    id: field
    guid: "field"
    value: "0 100 1\n0 100 1"
    onValueChanged: trycompute();
  }
  CheckBoxParam {
    guid: "fastrender"
    text: "\"Быстрый рендеринг\""
    id: fastrender
    checked: true
    width: 200
  }
  property bool fastRenderEnabled: fastrender.checked && !qmlEngine.rootObject.animationActive

  Array2dRobot {
    id: arr
  }

  property var func: deed.input.func

  onFuncChanged: trycompute();

  property var computetimer
  function trycompute() {
    if (!inited) return;
    if (computetimer) clearTimeout( computetimer );    
    computetimer = setTimeout( function() { computetimer=null; compute(); }, fastRenderEnabled ? 500 : 0 );
  }

  function compute(y0,totalcount,res) {
    if (computetimer) return; // это значит будет новый заказ на пересчет

    if (timerid) clearTimeout( timerid ); timerid=null;

    var f = func;
    if (!f) return;
    if (typeof(res) == "undefined") res = [];

    var xx = field.value.split(/\s+/).map( Number );    
    if (xx.length < 6) { deed.details = "Область расчета содержит менее 6 чисел, расчет невозможен"; return; }

    if (typeof(totalcount)=="undefined") totalcount = 0;
    if (typeof(y0)=="undefined") y0=xx[3];

    var startTime = new Date();
    var reslen0 = res.length;
    var frend = fastRenderEnabled;

    for (var y=y0; y<xx[4]; y+=xx[5]) {

    for (var x=xx[0]; x<xx[1]; x+=xx[2]) 
    {
      var z = f(x,y);
      if (!(z === undefined || z === null)) {
        res.push( [x,y,z] );
      }

      totalcount = totalcount+1;      
      if (totalcount > 2*1000*1000) {
        console.error("слишком много значений функции, стоп!");
        return;
      }
    }

      if (frend) {
      var endTime = new Date();
      var diff = endTime - startTime;
      if (diff / 1000 > 0.5) // больше 1 секунды
      {
        timerid = setTimeout( function() { compute( y+xx[5], totalcount, res ); }, 150 );        
        break;
      }
      } // frend

    } // y

    deed.details = "рассчитано "+totalcount+" точек";
    if (reslen0 != res.length)
      arr.arr = res;
  }
  property var timerid

  property bool inited: false
  Component.onCompleted: { inited=true; trycompute(); }

  PerformDeed {
    name: "array2d-to-points"
    input: arr
    parentToObject: true
  }
}