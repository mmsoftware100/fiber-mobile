import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class NewOrderInsertPage extends StatefulWidget {
  const NewOrderInsertPage({Key? key}) : super(key: key);

  @override
  _NewOrderInsertPageState createState() => _NewOrderInsertPageState();
}

class _NewOrderInsertPageState extends State<NewOrderInsertPage>{


File? _image;
final picker = ImagePicker();

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

void _chooseImageDialog() {
  // flutter defined function
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        actions: <Widget>[
          CupertinoDialogAction(
            child:
            new FlatButton(
              child: new Text("Take Camera"),
              onPressed: () {
                Navigator.of(context).pop();
                getImageFromCamera();
              },
            ),
          ),
          CupertinoDialogAction(
            child:
            new FlatButton(
              child: new Text("Choose from gallery"),
              onPressed: () {
                Navigator.of(context).pop();
                getImageFromGallery();
              },
            ),
          )
        ],
      );
    },
  );
}

Future getImageFromCamera() async {
  final pickedFile = await picker.getImage(source: ImageSource.camera,imageQuality: 25,);

  setState(() {
    if (pickedFile != null) {
      _image = File(pickedFile.path);
    } else {
      print('No image selected.');
    }
  });
}

Future getImageFromGallery() async {
  final pickedFile = await picker.getImage(source: ImageSource.gallery,imageQuality: 25,);

  setState(() {
    //_image = image;
    if (pickedFile != null) {
      _image = File(pickedFile.path);
    } else {
      print('No image selected.');
    }
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Order"),
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
                      child: Text("Customer Detail"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                        decoration: InputDecoration(
                          labelText: "Name",
                          border: OutlineInputBorder(),
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                        decoration: InputDecoration(
                          labelText: "NRC",
                          border: OutlineInputBorder(),
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                        decoration: InputDecoration(
                          labelText: "Email",
                          border: OutlineInputBorder(),
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: "Contact",
                          border: OutlineInputBorder(),
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: "Alternate Contact",
                          border: OutlineInputBorder(),
                        )
                    ),
                  ),
                  Center(
                    child: _image == null
                        ? Text('No image selected.')
                        : Image.file(_image!),
                  ),
                  Padding(
                    padding: EdgeInsets.all(30),
                    child: Center(
                      child: InkWell(
                        child: Container(
                            height: 20,
                            child: Text("Choose Image")),
                        onTap: (){
                          _chooseImageDialog();
                        },
                      ),
                    ),

                  ),
                  Center(
                    child: _image == null
                        ? Text('No image selected.')
                        : Image.file(_image!),
                  ),
                  Padding(
                    padding: EdgeInsets.all(30),
                    child: Center(
                      child: InkWell(
                        child: Container(
                            height: 20,
                            child: Text("Choose Image")),
                        onTap: (){
                          _chooseImageDialog();
                        },
                      ),
                    ),

                  ),

                ],
              ),
            ),
          ),
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
                      child: Text("Address"),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("State/Division"),
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
                    child: Text("Township/Town"),
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
                          labelText: "Ward",
                          border: OutlineInputBorder(),
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      //controller: _txtSenderNameController,
                        decoration: InputDecoration(
                          labelText: "Street",
                          border: OutlineInputBorder(),
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      //controller: _txtSenderNameController,
                        decoration: InputDecoration(
                          labelText: "Home",
                          border: OutlineInputBorder(),
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      //controller: _txtSenderNameController,
                        decoration: InputDecoration(
                          labelText: "Floor",
                          border: OutlineInputBorder(),
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      //controller: _txtSenderNameController,
                        decoration: InputDecoration(
                          labelText: "Room",
                          border: OutlineInputBorder(),
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      //controller: _txtSenderNameController,
                        decoration: InputDecoration(
                          labelText: "Lat",
                          border: OutlineInputBorder(),
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      //controller: _txtSenderNameController,
                        decoration: InputDecoration(
                          labelText: "Lng",
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
                      child: Text("Order Detail"),
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
                    child: Text("Package"),
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
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Payment"),
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
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Plan"),
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
                  Center(
                    child: _image == null
                        ? Text('No Contact Photo selected.')
                        : Image.file(_image!),
                  ),
                  Padding(
                    padding: EdgeInsets.all(30),
                    child: Center(
                      child: InkWell(
                        child: Container(
                            height: 20,
                            child: Text("Choose Image")),
                        onTap: (){
                          _chooseImageDialog();
                        },
                      ),
                    ),

                  ),
                  Center(
                    child: _image == null
                        ? Text('No Transaction Photo selected.')
                        : Image.file(_image!),
                  ),
                  Padding(
                    padding: EdgeInsets.all(30),
                    child: Center(
                      child: InkWell(
                        child: Container(
                            height: 20,
                            child: Text("Choose Image")),
                        onTap: (){
                          _chooseImageDialog();
                        },
                      ),
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
