import 'package:fiber_oms_flutter/view/pages/service/new_service_add_page.dart';
import 'package:flutter/material.dart';

class ServiceListPage extends StatefulWidget {
  const ServiceListPage({Key? key}) : super(key: key);

  @override
  _ServiceListPageState createState() => _ServiceListPageState();
}

class _ServiceListPageState extends State<ServiceListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Service List"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("No Data"),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: MaterialButton(
            //       height: 58,
            //       minWidth: 340,
            //       shape: RoundedRectangleBorder(
            //           borderRadius: new BorderRadius.circular(12)),
            //       color: Colors.blue,
            //       child: Text("New Service",style: TextStyle(color: Colors.white),),
            //       onPressed: (){
            //         Navigator.push(context, MaterialPageRoute(builder: (context)=>NewServiceAddpage()));
            //       }),
            // ),
          ],
        ),
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
