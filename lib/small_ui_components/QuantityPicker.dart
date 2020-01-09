import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

typedef void CounterChangeCallback(num value);

class Counter extends StatefulWidget {
  final CounterChangeCallback onChanged;

  Counter({
    Key key,
    @required num initialValue,
    @required this.minValue,
    @required this.maxValue,
    @required this.onChanged,
    this.color,
    this.textStyle,
    this.step = 1,
    this.buttonSize = 25,
  })  : assert(initialValue != null),
        assert(minValue != null),
        assert(maxValue != null),
        assert(maxValue > minValue),
        assert(initialValue >= minValue && initialValue <= maxValue),
        assert(step > 0),
        selectedValue = initialValue,
        super(key: key);

  ///min value user can pick
  final num minValue;

  ///max value user can pick
  final num maxValue;

  /// decimal places required by the counter

  ///Currently selected integer value
  num selectedValue;

  /// if min=0, max=5, step=3, then items will be 0 and 3.
  final num step;

  /// indicates the color of fab used for increment and decrement
  Color color;

  /// text syle
  TextStyle textStyle;

  final double buttonSize;

  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  void _incrementCounter() {
    if (widget.selectedValue + widget.step <= widget.maxValue) {
      setState(() {
        widget.selectedValue += widget.step;
      });
      widget.onChanged((widget.selectedValue));
    }
  }

  void _decrementCounter() {
    if (widget.selectedValue - widget.step >= widget.minValue) {
      setState(() {
        widget.selectedValue -= widget.step;
      });
      widget.onChanged((widget.selectedValue));
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    widget.color = widget.color ?? themeData.accentColor;
    widget.textStyle = widget.textStyle ??
        new TextStyle(
          fontSize: 20.0,
        );

    return Center(
      child: new Container(
        height: 60,
        width: 130,
        decoration: BoxDecoration(
            border: Border.all(
                color: Colors.white10, width: 2, style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(14),
            shape: BoxShape.rectangle,
            boxShadow: [
              BoxShadow(
                  color: Colors.black12, offset: Offset(2, 8), blurRadius: 10.0)
            ],
            color: Colors.white),
        padding: new EdgeInsets.all(6.0),
        child: Row(
          children: <Widget>[
            new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Center(
                    child: InkWell(
                      child: Icon(
                        Icons.arrow_drop_up,
                        size: 28,
                      ),
                      onTap: _decrementCounter,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                  flex: 1,
                ),
                Expanded(
                  child: InkWell(
                    child: Icon(
                      Icons.arrow_drop_down,
                      size: 28,
                    ),
                    onTap: _incrementCounter,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  flex: 1,
                )
              ],
            ),
            new Container(
              width: 52,
              alignment: Alignment.center,
              padding: EdgeInsets.all(2.0),
              child:
                  new Text("${widget.selectedValue}", style: widget.textStyle),
            ),
            Align(
              child: Container(width:32 , child: Text("LTS")),
              alignment: Alignment.centerRight,
            )
          ],
        ),
      ),
    );
  }
}

//colorText("20",style: TextStyle(fontSize: 20),),
//SizedBox(width: 20,),
//Text("LTS",style: TextStyle(fontSize: 20),),
