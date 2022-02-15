import 'package:flutter/material.dart';

class NewTickestInsertPage extends StatefulWidget {
  const NewTickestInsertPage({Key? key}) : super(key: key);

  @override
  _NewTickestInsertPageState createState() => _NewTickestInsertPageState();
}

class _NewTickestInsertPageState extends State<NewTickestInsertPage> {

 // Initial Selected Value
  String dropdownCityvalue = 'Yangon';
// Initial Selected Value
  String dropdownGatevalue = 'One';

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
        title: Text("New Tickest"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  //color: Colors.blueAccent
                ),
                borderRadius: BorderRadius.all(
                    Radius.circular(5.0)), // Set rounded corner radius
              ),
              child: ListView(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text("Tickest Detial"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      //controller: _txtSenderNameController,
                        decoration: InputDecoration(
                          labelText: "Order Code",
                          border: OutlineInputBorder(),
                        )
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Package Type"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      // width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        border: Border.all(
                          //color: Colors.blueAccent
                        ),
                        borderRadius: BorderRadius.all(
                            Radius.circular(5.0)), // Set rounded corner radius
                      ),

                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            isExpanded: true,
                            elevation: 16,
                            // Initial Value
                            value: dropdownCityvalue,

                            // Down Arrow Icon
                            //icon: const Icon(Icons.keyboard_arrow_down),

                            // Array list of items
                            items: cities.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            // After selecting the desired option,it will
                            // change button value to selected value
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownCityvalue = newValue!;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Issue"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      // width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        border: Border.all(
                          //color: Colors.blueAccent
                        ),
                        borderRadius: BorderRadius.all(
                            Radius.circular(5.0)), // Set rounded corner radius
                      ),

                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            isExpanded: true,
                            elevation: 16,
                            // Initial Value
                            value: dropdownGatevalue,

                            // Down Arrow Icon
                            //icon: const Icon(Icons.keyboard_arrow_down),

                            // Array list of items
                            items: gates.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            // After selecting the desired option,it will
                            // change button value to selected value
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownGatevalue = newValue!;
                              });
                            },
                            hint: Align(
                              alignment: Alignment.centerRight,
                              child: Text("ကားဂိတ်ရွေးချယ်ပါ",style: TextStyle(color: Colors.grey),),
                            ),
                            style:
                            TextStyle(color: Colors.black, decorationColor: Colors.red),
                          ),
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      //controller: _txtSenderNameController,
                        decoration: InputDecoration(
                          labelText: "Remark",
                          border: OutlineInputBorder(),
                        )
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
                height: 58,
                minWidth: 340,
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(12)),
                color: Color(0xFFF7CA18),
                child: Text("Save"),
                onPressed: (){
                }),
          ),

        ],
      ),
    );
  }
}
