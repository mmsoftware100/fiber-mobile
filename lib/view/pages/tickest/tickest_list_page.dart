import 'package:fiber_oms_flutter/view/pages/tickest/new_tickest_insert_page.dart';
import 'package:flutter/material.dart';

class TickestListPage extends StatefulWidget {
  const TickestListPage({Key? key}) : super(key: key);

  @override
  _TickestListPageState createState() => _TickestListPageState();
}

class _TickestListPageState extends State<TickestListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tickest List"),
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
            //       child: Text("New Tickest",style: TextStyle(color: Colors.white),),
            //       onPressed: (){
            //         Navigator.push(context, MaterialPageRoute(builder: (context)=>NewTickestInsertPage()));
            //       }),
            // ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>NewTickestInsertPage()));
        },
        icon: new Icon(Icons.add),
        label: const Text("New"),
      ),

    );
  }
}