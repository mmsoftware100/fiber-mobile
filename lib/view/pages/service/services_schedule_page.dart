import 'package:fiber_oms_flutter/view/pages/service/new_service_schedule_add_page.dart';
import 'package:flutter/material.dart';

class ServicesSchedulePage extends StatefulWidget {
  const ServicesSchedulePage({Key? key}) : super(key: key);

  @override
  _ServicesSchedulePageState createState() => _ServicesSchedulePageState();
}

class _ServicesSchedulePageState extends State<ServicesSchedulePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Services Schedule"),
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
            //       child: Text("New Service Schedule",style: TextStyle(color: Colors.white),),
            //       onPressed: (){
            //         Navigator.push(context, MaterialPageRoute(builder: (context)=>NewSericeScheduleAddPage()));
            //       }),
            // ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>NewSericeScheduleAddPage()));

        },
        icon: new Icon(Icons.add),
        label: const Text("New"),
      ),

    );
  }
}
