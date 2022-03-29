import 'package:flutter/material.dart';

class VirtualSurveyDetailPage extends StatefulWidget {
  const VirtualSurveyDetailPage({Key? key}) : super(key: key);

  @override
  _VirtualSurveyDetailPageState createState() => _VirtualSurveyDetailPageState();
}

class _VirtualSurveyDetailPageState extends State<VirtualSurveyDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text("Virtual Survey Detail"),
      ),
    );
  }
}
