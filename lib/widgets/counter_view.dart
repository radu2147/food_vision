import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_vision/screens/fitness_app_theme.dart';

class CounterView extends StatefulWidget {
  final int initNumber;
  final int minNumber;
  CounterView({required this.initNumber,  required this.minNumber});
  @override
  _CounterViewState createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView> {
  late int _currentCount;
  late int _minNumber;

  @override
  void initState() {
    _currentCount = widget.initNumber;
    _minNumber = widget.minNumber;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      width: MediaQuery.of(context).size.width / 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: FitnessAppTheme.background,

      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _createIncrementDicrementButton(Icons.remove, () => _dicrement()),
          Text(_currentCount.toString(), style: FitnessAppTheme.body1,),
          _createIncrementDicrementButton(Icons.add, () => _increment()),
        ],
      ),
    );
  }

  void _increment() {
    setState(() {
      _currentCount++;
    });
  }

  void _dicrement() {
    setState(() {
      if (_currentCount > _minNumber) {
        _currentCount--;
      }
    });
  }

  Widget _createIncrementDicrementButton(IconData icon, Function() onPressed) {
    return RawMaterialButton(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      constraints: const BoxConstraints(minWidth: 32.0, minHeight: 32.0),
      onPressed: onPressed,
      elevation: 2.0,
      fillColor: FitnessAppTheme.nearlyDarkBlue,
      child: Icon(
        icon,
        color: FitnessAppTheme.nearlyWhite,
        size: 12.0,
      ),
      shape: const CircleBorder(),
    );
  }
}