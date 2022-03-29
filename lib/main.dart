import 'package:fiber_oms_flutter/view/pages/home_page.dart';
import 'package:fiber_oms_flutter/view/pages/order/order_list_page.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(
    MaterialApp(
      //home: HomePage(),
      home: OrderListPage(),
      debugShowCheckedModeBanner: false,
    )
  );
}