// ignore_for_file: camel_case_types, no_logic_in_create_state, must_be_immutable

import 'package:flutter/material.dart';

class chartBuilder extends StatefulWidget {
  chartBuilder({required this.list, Key? key}) : super(key: key);
  List<dynamic> list = [];

  @override
  _chartBuilderState createState() => _chartBuilderState(list);
}

class _chartBuilderState extends State<chartBuilder> {
  _chartBuilderState(this.list);
  List<dynamic> list = [];
  @override
  Widget build(BuildContext context) {
    return const Text("Hi");
  }
}
