import 'package:fiber_oms_flutter/view/pages/installation/installation_list_page.dart';
import 'package:fiber_oms_flutter/view/pages/installation/installation_schedule_page.dart';
import 'package:fiber_oms_flutter/view/pages/order/order_list_page.dart';
import 'package:fiber_oms_flutter/view/pages/service/new_service_add_page.dart';
import 'package:fiber_oms_flutter/view/pages/service/service_list_page.dart';
import 'package:fiber_oms_flutter/view/pages/service/services_schedule_page.dart';
import 'package:fiber_oms_flutter/view/pages/tickest/tickest_check_list_page.dart';
import 'package:fiber_oms_flutter/view/pages/tickest/tickest_list_page.dart';
import 'package:fiber_oms_flutter/view/pages/virtual_survey/virtual_servay_list_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // Initial Selected Value
  String dropdownCityvalue = 'Yangon';
  // Initial Selected Value
  String dropdownGatevalue = 'Mandalarmin';

  // List of items in our dropdown menu
  var cities = [
    'Yangon',
    'Mandalay',
    'Bago',
    'Taung Gyi',
    'Naypyitaw',
  ];

  // List of items in our dropdown menu
  var gates = [
    'One',
    'Two',
    'Three',
    'Four',
    'Five',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Service"),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(child: Container(
              color: Colors.blue,
            )
            ),
            Card(
              child: ListTile(
                title: Text("Order List"),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderListPage()));
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text("Tickest List"),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>TickestListPage()));
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text("Tickest Check List"),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>TickestCheckListPage()));
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text("Virtual Servay List"),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>VirtualServayListPage()));
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text("Installation Schedule"),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>InstallationSchedulePage()));
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text("Installation List"),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>InstallationListPage()));
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text("Services Schedule"),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ServicesSchedulePage()));
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text("Services List"),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ServiceListPage()));
                },
              ),
            ),

          ],
        ),
      ),
      body: Center(
        child:Text("No Data")
        
      ),
      floatingActionButton: new FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>NewServiceAddpage()));

        },
        icon: new Icon(Icons.add),
        label: const Text("New"),
      ),
    );
  }
}
