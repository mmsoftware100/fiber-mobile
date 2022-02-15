import 'package:fiber_oms_flutter/view/pages/installation/new_installation_schedule_add_page.dart';
import 'package:flutter/material.dart';

class InstallationSchedulePage extends StatefulWidget {
  const InstallationSchedulePage({Key? key}) : super(key: key);

  @override
  _InstallationSchedulePageState createState() => _InstallationSchedulePageState();
}

class _InstallationSchedulePageState extends State<InstallationSchedulePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Installation Schedule"),
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
            //       child: Text("New Installation Schedule",style: TextStyle(color: Colors.white),),
            //       onPressed: (){
            //         Navigator.push(context, MaterialPageRoute(builder: (context)=>NewInstallationScheduleAddPage()));
            //       }),
            // ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>NewInstallationScheduleAddPage()));
        },
        icon: new Icon(Icons.add),
        label: const Text("New"),
      ),

    );
  }
}
