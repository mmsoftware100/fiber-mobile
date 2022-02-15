import 'package:fiber_oms_flutter/view/pages/installation/new_installation_add_page.dart';
import 'package:flutter/material.dart';

class InstallationListPage extends StatefulWidget {
  const InstallationListPage({Key? key}) : super(key: key);

  @override
  _InstallationListPageState createState() => _InstallationListPageState();
}

class _InstallationListPageState extends State<InstallationListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Installation List"),
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
            //       child: Text("New Installation",style: TextStyle(color: Colors.white),),
            //       onPressed: (){
            //         Navigator.push(context, MaterialPageRoute(builder: (context)=>NewInstallationAddPage()));
            //       }),
            // ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>NewInstallationAddPage()));

        },
        icon: new Icon(Icons.add),
        label: const Text("New"),
      ),

    );
  }
}
