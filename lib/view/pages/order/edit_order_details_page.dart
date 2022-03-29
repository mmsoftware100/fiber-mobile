import 'dart:convert';
import 'dart:io';

import 'package:fiber_oms_flutter/model/one_order_model.dart';
import 'package:fiber_oms_flutter/model/package_model.dart';
import 'package:fiber_oms_flutter/model/package_type_model.dart';
import 'package:fiber_oms_flutter/model/payment_model.dart';
import 'package:fiber_oms_flutter/model/plan_model.dart';
import 'package:fiber_oms_flutter/model/state_model.dart';
import 'package:fiber_oms_flutter/model/town_model.dart';
import 'package:fiber_oms_flutter/utils/dialogue.dart';
import 'package:fiber_oms_flutter/utils/rest_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditOrderDetailsPage extends StatefulWidget {
  String id;
  EditOrderDetailsPage(this.id);

  @override
  _EditOrderDetailsPageState createState() => _EditOrderDetailsPageState();
}

class _EditOrderDetailsPageState extends State<EditOrderDetailsPage> {

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  File? _imageNRCfrontphoto,_imageNRCBackphoto,_imageContractphoto,_imageTranscationphoto;
  final picker = ImagePicker();
  late OneOrderModel oneOrderModel ;
  bool dataReturnStatus = false;

  String customeraddress_id = "";

  TextEditingController _txtNameController = TextEditingController();
  TextEditingController _txtNRCController = TextEditingController();
  TextEditingController _txtEmailController = TextEditingController();
  TextEditingController _txtContactController = TextEditingController();
  TextEditingController _txtAlternateContactController = TextEditingController();

  TextEditingController _txtWardController = TextEditingController();
  TextEditingController _txtStreetController = TextEditingController();
  TextEditingController _txtHomeController = TextEditingController();
  TextEditingController _txtFloorController = TextEditingController();
  TextEditingController _txtRoomController = TextEditingController();
  TextEditingController _txtLatController = TextEditingController();
  TextEditingController _txtLngController = TextEditingController();

  TextEditingController _txtRemarkController = TextEditingController();




  List<StateModel> stateListModel = [];
  String _selectedStateDivisionID = '';
  List<String> _stateIDArrayList = [];

  List<TownModel> townListModel = [];
  String _selectedTownCode = '';
  List<String> _townCodeArrayList = [];

  List<PackageTypeModel> packageTypeListModel = [];
  String _selectedPackageTypeCode = '';
  List<String> _packageTypeCodeArrayList = [];

  List<PackageModel> packageListModel = [];
  String _selectedPackageCode = '';
  List<String> _packageCodeArrayList = [];

  List<PaymentModel> paymentListModel = [];
  String _selectedPaymentCode = '';
  List<String> _paymentCodeArrayList = [];

  List<PlanModel> planListModel = [];
  String _selectedPlanCode = '';
  List<String> _planCodeArrayList = [];

  Future<List<StateModel>> getState() async{
    try{
      await APIServices.Get_States().then((value) {
        print(value);

        //Navigator.of(context,rootNavigator: true).pop();//close the dialoge

        Map<String, dynamic> dataResponse = jsonDecode(value);

        print("getState data is "+dataResponse.toString());

        List<dynamic> dataList =  dataResponse['data'];

        print("getState of aung is "+dataList.toString());

        print("Hi data "+dataList.length.toString());
        setState(() {
          for(int i=0; i<dataList.length; i++){
            try{
              stateListModel.add(StateModel.fromJson(dataList[i]));
              print("hello "+i.toString());
              print(stateListModel);
            }
            catch(exp){
              print("intername exp");
            }
          }

          if(stateListModel.length > 0){
            setState(() {
              stateListModel.forEach((value){
                print("value.stateCode is "+value.id);
                _stateIDArrayList.add(value.id);
              });
              _selectedStateDivisionID = _stateIDArrayList[0];
            });
          }
        });

        print("stateListModel is "+stateListModel.toString());

        return stateListModel;
      });
      return stateListModel ;
    }
    catch (Exc) {
      print(Exc);
      rethrow;
    }
  }

  Future<List<TownModel>> getTown() async{
    try{
      await APIServices.Get_Towns().then((value) {
        print("response.body"+value.toString());
        print(value);

        Map<String, dynamic> dataResponse = jsonDecode(value);

        print("getTown data is "+dataResponse.toString());

        List<dynamic> dataList =  dataResponse['data'];

        print("getTown of aung is "+dataList.toString());

        print("Hi data "+dataList.length.toString());
        setState(() {
          for(int i=0; i<dataList.length; i++){
            try{
              townListModel.add(TownModel.fromJson(dataList[i]));
              print("hello "+i.toString());
              print(townListModel);
            }
            catch(exp){
              print("intername exp");
            }
          }

          if(townListModel.length > 0){
            setState(() {
              townListModel.forEach((value){
                print("value.townCode is "+value.id);
                _townCodeArrayList.add(value.id);

              });
              _selectedTownCode = _townCodeArrayList[0];
            });
          }
        });

        print("townListModel is "+townListModel.toString());

        return townListModel;
      });
      return townListModel ;
    }
    catch (Exc) {
      print(Exc);
      rethrow;
    }
  }

  Future<List<PackageTypeModel>> getPackageTypes() async{
    try{
      await APIServices.Get_PackageTypes().then((value) {
        print("response.body"+value.toString());
        print(value);

        Map<String, dynamic> dataResponse = jsonDecode(value);

        print("Get_PackageTypes data is "+dataResponse.toString());

        List<dynamic> dataList =  dataResponse['data'];

        print("Get_PackageTypes of aung is "+dataList.toString());

        print("Hi data "+dataList.length.toString());
        setState(() {
          for(int i=0; i<dataList.length; i++){
            try{
              packageTypeListModel.add(PackageTypeModel.fromJson(dataList[i]));
              print("hello "+i.toString());
              print(packageTypeListModel);
            }
            catch(exp){
              print("intername exp");
            }
          }

          if(packageTypeListModel.length > 0){
            setState(() {
              packageTypeListModel.forEach((value){
                print("value.packageTypeCode is "+value.id);
                _packageTypeCodeArrayList.add(value.id);

              });
              _selectedPackageTypeCode = _packageTypeCodeArrayList[0];
            });
          }
        });

        print("packageTypeListModel is "+packageTypeListModel.toString());

        return packageTypeListModel;
      });
      return packageTypeListModel ;
    }
    catch (Exc) {
      print(Exc);
      rethrow;
    }
  }

  Future<List<PackageModel>> getPackages() async{
    try{
      await APIServices.Get_Packages().then((value) {
        print("response.body"+value.toString());
        print(value);

        Map<String, dynamic> dataResponse = jsonDecode(value);

        print("getPackages data is "+dataResponse.toString());

        List<dynamic> dataList =  dataResponse['data'];

        print("getPackages of aung is "+dataList.toString());

        print("Hi data "+dataList.length.toString());
        setState(() {
          for(int i=0; i<dataList.length; i++){
            try{
              packageListModel.add(PackageModel.fromJson(dataList[i]));
              print("hello "+i.toString());
              print(packageListModel);
            }
            catch(exp){
              print("intername exp");
            }
          }

          if(packageListModel.length > 0){
            setState(() {
              packageListModel.forEach((value){
                print("value.packageCode is "+value.id);
                _packageCodeArrayList.add(value.id);

              });
              _selectedPackageCode = _packageCodeArrayList[0];
            });
          }
        });

        print("packageListModel is "+packageListModel.toString());

        return packageListModel;
      });
      return packageListModel ;
    }
    catch (Exc) {
      print(Exc);
      rethrow;
    }
  }

  Future<List<PaymentModel>> getPayments() async{
    try{
      await APIServices.Get_Payments().then((value) {
        print("response.body"+value.toString());
        print(value);

        Map<String, dynamic> dataResponse = jsonDecode(value);

        print("getPayments data is "+dataResponse.toString());

        List<dynamic> dataList =  dataResponse['data'];

        print("getPayments of aung is "+dataList.toString());

        print("Hi data "+dataList.length.toString());
        setState(() {
          for(int i=0; i<dataList.length; i++){
            try{
              paymentListModel.add(PaymentModel.fromJson(dataList[i]));
              print("hello "+i.toString());
              print(paymentListModel);
            }
            catch(exp){
              print("intername exp");
            }
          }

          if(paymentListModel.length > 0){
            setState(() {
              paymentListModel.forEach((value){
                print("value.paymentCode is "+value.id);
                _paymentCodeArrayList.add(value.id);

              });
              _selectedPaymentCode = _paymentCodeArrayList[0];
            });
          }
        });

        print("paymentListModel is "+paymentListModel.toString());

        return paymentListModel;
      });
      return paymentListModel ;
    }
    catch (Exc) {
      print(Exc);
      rethrow;
    }
  }

  Future<List<PlanModel>> getPlans() async{
    try{
      await APIServices.Get_Plans().then((value) {
        print("response.body"+value.toString());
        print(value);

        Map<String, dynamic> dataResponse = jsonDecode(value);

        print("getPlans data is "+dataResponse.toString());

        List<dynamic> dataList =  dataResponse['data'];

        print("getPlans of aung is "+dataList.toString());

        print("Hi data "+dataList.length.toString());
        setState(() {
          for(int i=0; i<dataList.length; i++){
            try{
              planListModel.add(PlanModel.fromJson(dataList[i]));
              print("hello "+i.toString());
              print(planListModel);
            }
            catch(exp){
              print("intername exp");
            }
          }

          if(planListModel.length > 0){
            setState(() {
              planListModel.forEach((value){
                print("value.planCode is "+value.id);
                _planCodeArrayList.add(value.id);

              });
              _selectedPlanCode = _planCodeArrayList[0];
            });
          }
        });

        print("planListModel is "+planListModel.toString());

        return planListModel;
      });
      return planListModel ;
    }
    catch (Exc) {
      print(Exc);
      rethrow;
    }
  }



  void _onSelectedStateDivisionCode(String value){

    setState((){
      _selectedStateDivisionID = value;

    });
  }

  void _onSelectedTownCode(String value){

    setState((){
      _selectedTownCode = value;

    });
  }

  void _onSelectedPackageTypeCode(String value){

    setState((){
      _selectedPackageTypeCode = value;

    });
  }

  void _onSelectedPackageCode(String value){

    setState((){
      _selectedPackageCode = value;

    });
  }

  void _onSelectedPaymentCode(String value){

    setState((){
      _selectedPaymentCode = value;

    });
  }

  void _onSelectedPlanCode(String value){

    setState((){
      _selectedPlanCode = value;

    });
  }

  void _chooseNRCfrontphotoDialog() {
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
                  getNRCfrontphotoFromCamera();
                },
              ),
            ),
            CupertinoDialogAction(
              child:
              new FlatButton(
                child: new Text("Choose from gallery"),
                onPressed: () {
                  Navigator.of(context).pop();
                  getNRCfrontphotoFromGallery();
                },
              ),
            )
          ],
        );
      },
    );
  }

  Future getNRCfrontphotoFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera,imageQuality: 25,);

    setState(() {
      if (pickedFile != null) {
        _imageNRCfrontphoto = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getNRCfrontphotoFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery,imageQuality: 25,);

    setState(() {
      //_image = image;
      if (pickedFile != null) {
        _imageNRCfrontphoto = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  void _chooseNRCBackphotoDialog() {
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
                  getNRCBackphotoFromCamera();
                },
              ),
            ),
            CupertinoDialogAction(
              child:
              new FlatButton(
                child: new Text("Choose from gallery"),
                onPressed: () {
                  Navigator.of(context).pop();
                  getNRCBackphotoFromGallery();
                },
              ),
            )
          ],
        );
      },
    );
  }

  Future getNRCBackphotoFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera,imageQuality: 25,);

    setState(() {
      if (pickedFile != null) {
        _imageNRCBackphoto = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getNRCBackphotoFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery,imageQuality: 25,);

    setState(() {
      //_image = image;
      if (pickedFile != null) {
        _imageNRCBackphoto = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  void _chooseContractphotoDialog() {
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
                  getContractphotoFromCamera();
                },
              ),
            ),
            CupertinoDialogAction(
              child:
              new FlatButton(
                child: new Text("Choose from gallery"),
                onPressed: () {
                  Navigator.of(context).pop();
                  getContractphotoFromGallery();
                },
              ),
            )
          ],
        );
      },
    );
  }

  Future getContractphotoFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera,imageQuality: 25,);

    setState(() {
      if (pickedFile != null) {
        _imageContractphoto = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getContractphotoFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery,imageQuality: 25,);

    setState(() {
      //_image = image;
      if (pickedFile != null) {
        _imageContractphoto = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  void _chooseTranscationphotoDialog() {
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
                  getTranscationphotoFromCamera();
                },
              ),
            ),
            CupertinoDialogAction(
              child:
              new FlatButton(
                child: new Text("Choose from gallery"),
                onPressed: () {
                  Navigator.of(context).pop();
                  getTranscationphotoFromGallery();
                },
              ),
            )
          ],
        );
      },
    );
  }

  Future getTranscationphotoFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera,imageQuality: 25,);

    setState(() {
      if (pickedFile != null) {
        _imageTranscationphoto = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getTranscationphotoFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery,imageQuality: 25,);

    setState(() {
      //_image = image;
      if (pickedFile != null) {
        _imageTranscationphoto = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  getOneOrder()async{
    //Dialogs.showLoadingDialog(context, _keyLoader);//invoking login
    print("id is "+widget.id);
    try{
      await APIServices.Get_One_Order(widget.id).then((value){


        //Navigator.of(context,rootNavigator: true).pop();//close the dialoge

        Map<String, dynamic> dataResponse = jsonDecode(value);

        print("getOneOrder data is "+dataResponse.toString());
        setState(() {
          dataReturnStatus = true;
          oneOrderModel = OneOrderModel.fromJson(json.decode(value)['data']);
          print("hello "+oneOrderModel.toString());

          _txtNameController.text = oneOrderModel.customer.name;
          _txtNRCController.text = oneOrderModel.customer.nrc;
          _txtEmailController.text = oneOrderModel.customer.email;
          _txtContactController.text = oneOrderModel.customer.phones[0].phone;
          _txtAlternateContactController.text = oneOrderModel.customer.phones[1].phone;

          _selectedStateDivisionID = oneOrderModel.customer.address.state.id;
          _selectedTownCode = oneOrderModel.customer.address.town.id;

          _txtWardController.text = oneOrderModel.customer.address.ward;
          _txtStreetController.text = oneOrderModel.customer.address.street;
          _txtHomeController.text = oneOrderModel.customer.address.home;
          _txtFloorController.text = oneOrderModel.customer.address.floor;
          _txtRoomController.text = oneOrderModel.customer.address.room;
          _txtLatController.text = oneOrderModel.customer.address.lat;
          _txtLngController.text = oneOrderModel.customer.address.lng;

          _selectedPackageTypeCode = oneOrderModel.package.packagetypeId;
          _selectedPackageCode = oneOrderModel.package.id;
          _selectedPaymentCode = oneOrderModel.payment.id;
          _selectedPlanCode = oneOrderModel.planId;

          _txtRemarkController.text = oneOrderModel.remark;

          customeraddress_id = oneOrderModel.customer.address.id;

          // _imageNRCfrontphoto = File(oneOrderModel.customer.photos.nrcFront.name.toString());
          // print("_imageNRCfrontphoto is "+_imageNRCfrontphoto.toString());
          // _imageNRCBackphoto = File(oneOrderModel.customer.photos.nrcBack.name.toString());
          //
          // _imageContractphoto = File(oneOrderModel.photos.contract.name.toString());
          // _imageTranscationphoto = File(oneOrderModel.photos.transcation.name.toString());
        });

      });
    }
    catch (Exc) {
      print(Exc);
      rethrow;
    }
  }

  UpdateOrder()async{

    Dialogs.showLoadingDialog(context, _keyLoader);//invoking login

    Map mydata ={

    'customer_id': oneOrderModel.customerId,
    'name': _txtNameController.text.toString(),
    'nrc': _txtNRCController.text.toString(),
    'email':_txtEmailController.text.toString(),
    'phones[0][id]': '',
    'phones[0][phone]': _txtContactController.text.toString(),
    'phones[1][id]': '',
    'phones[1][phone]': _txtAlternateContactController.text.toString(),
    'town': _selectedTownCode,
    'ward': _txtWardController.text.toString(),
    'street': _txtStreetController.text.toString(),
    'home': _txtHomeController.text.toString(),
    'floor': _txtFloorController.text.toString(),
    'room': _txtRoomController.text.toString(),
    'lat': _txtLatController.text.toString(),
    'lng': _txtLngController.text.toString(),
    'package': _selectedPackageCode,
    'payment': _selectedPaymentCode,
    'plan': _selectedPlanCode,
    'remark': _txtRemarkController.text.toString(),
    'code': '',
      'nrc_front_file':_imageNRCfrontphoto != null ? _imageNRCfrontphoto?.path : '',
      'nrc_front_image_id': '',
      'nrc_front_image': _imageNRCfrontphoto != null ? "true" : "false",
      'nrc_back_file':_imageNRCBackphoto != null ? _imageNRCBackphoto?.path : '',
      'nrc_back_image_id': '',
      'nrc_back_image': _imageNRCBackphoto != null ? "true" : "false",
      'contract_file':_imageContractphoto != null ? _imageContractphoto?.path : '',
      'contract_image_id': '',
      'contract_image': _imageContractphoto != null ? "true" : "false",
      'transcation_file':_imageTranscationphoto != null ? _imageTranscationphoto?.path : '',
      'transcation_image_id': '',
      'transcation_image': _imageTranscationphoto != null ? "true" : "false",
      // 'nrc_front_file':_imageNRCfrontphoto != null ? _imageNRCfrontphoto?.path : oneOrderModel.customer.photos.nrcFront,
      // 'nrc_front_image_id': '',
      // 'nrc_front_image': _imageNRCfrontphoto != null ? "true" : "false",
      // 'nrc_back_file':_imageNRCBackphoto != null ? _imageNRCBackphoto?.path : oneOrderModel.customer.photos.nrcBack,
      // 'nrc_back_image_id': '',
      // 'nrc_back_image': _imageNRCBackphoto != null ? "true" : "false",
      // 'contract_file':_imageContractphoto != null ? _imageContractphoto?.path : oneOrderModel.photos.contract,
      // 'contract_image_id': '',
      // 'contract_image': _imageContractphoto != null ? "true" : "false",
      // 'transcation_file':_imageTranscationphoto != null ? _imageTranscationphoto?.path : oneOrderModel.photos.transcation,
      // 'transcation_image_id': '',
      // 'transcation_image': _imageTranscationphoto != null ? "true" : "false",
    'customeraddress_id': customeraddress_id,
    '_method': 'put'
    };

    print(mydata);

    try{
      await APIServices.Edit_Order(mydata,_imageNRCfrontphoto,_imageNRCBackphoto,_imageContractphoto,_imageTranscationphoto,widget.id).then((response){
        Navigator.of(context,rootNavigator: true).pop();//close the dialoge
        Map<String, dynamic> dataResponse = jsonDecode(response);
        //List<dynamic> dataList =  dataResponse['data'];


        print("dataResponse is "+dataResponse.toString());

        if(dataResponse['status'].toString() == "true"){


          print("hello baby");
          Map<String, dynamic> dlist = json.decode(response);

          print(dlist);
          // NewParcelModel newParcelModel = NewParcelModel.fromJson(json.decode(response));
          _succefllyInserted();


        }
        else{
          _faildInsert();
        }

      });
    }
    catch (Exc) {
      print(Exc);
      rethrow;
    }
  }

  void _succefllyInserted() {
    // flutter defined function
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          content: Text("Success"),
          actions: <Widget>[
            CupertinoDialogAction(
              child:
              new FlatButton(
                child: new Text("OK"),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  void _faildInsert() {
    // flutter defined function
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          content: Text("Sorry"),
          title: Text("Faild"),
          actions: <Widget>[
            CupertinoDialogAction(
              child:
              new FlatButton(
                child: new Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    getOneOrder();

    super.initState();
    getState();
    getTown();
    getPackageTypes();
    getPackages();
    getPayments();
    getPlans();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text("Edit Order"),
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
                        controller: _txtNameController,
                        decoration: InputDecoration(
                          labelText: "Name",
                          border: OutlineInputBorder(),
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                        controller: _txtNRCController,
                        decoration: InputDecoration(
                          labelText: "NRC",
                          border: OutlineInputBorder(),
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                        controller: _txtEmailController,
                        decoration: InputDecoration(
                          labelText: "Email",
                          border: OutlineInputBorder(),
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                        controller: _txtContactController,
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
                        controller: _txtAlternateContactController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: "Alternate Contact",
                          border: OutlineInputBorder(),
                        )
                    ),
                  ),

                  Center(
                    child: _imageNRCfrontphoto == null
                        ? Text('No NRC front photo selected.')
                        : Image.file(_imageNRCfrontphoto!),
                  ),
                  Padding(
                    padding: EdgeInsets.all(30),
                    child: Center(
                      child: RaisedButton(
                        child: Container(
                            height: 20,
                            child: Text("Choose NRC front photo")),
                        onPressed: (){
                          _chooseNRCfrontphotoDialog();
                        },
                      ),
                    ),

                  ),
                  Center(
                    child: _imageNRCBackphoto == null
                        ? Text('No NRC Back photo selected.')
                        : Image.file(_imageNRCBackphoto!),
                  ),
                  Padding(
                    padding: EdgeInsets.all(30),
                    child: Center(
                      child: RaisedButton(
                        child: Container(
                            height: 20,
                            child: Text("Choose NRC Back photo")),
                        onPressed: (){
                          _chooseNRCBackphotoDialog();
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
                          child: DropdownButton<String>(
                            isExpanded: true,
                            items: stateListModel.map((value) {
                              return DropdownMenuItem<String>(
                                value: value.id.toString(),
                                child: Text(value.name),
                              );
                            }).toList(),
                            //onChanged: (value) => print("hello value "+value.),
                            onChanged: (value) => _onSelectedStateDivisionCode(value.toString()),
                            value: _selectedStateDivisionID,
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
                          child: DropdownButton<String>(
                            isExpanded: true,
                            items: townListModel.map((value) {
                              return DropdownMenuItem<String>(
                                value: value.id.toString(),
                                child: Text(value.name),
                              );
                            }).toList(),
                            //onChanged: (value) => print("hello value "+value.),
                            onChanged: (value) => _onSelectedTownCode(value.toString()),
                            value: _selectedTownCode,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                        controller: _txtWardController,
                        decoration: InputDecoration(
                          labelText: "Ward",
                          border: OutlineInputBorder(),
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                        controller: _txtStreetController,
                        decoration: InputDecoration(
                          labelText: "Street",
                          border: OutlineInputBorder(),
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                        controller: _txtHomeController,
                        decoration: InputDecoration(
                          labelText: "Home",
                          border: OutlineInputBorder(),
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                        controller: _txtFloorController,
                        decoration: InputDecoration(
                          labelText: "Floor",
                          border: OutlineInputBorder(),
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                        controller: _txtRoomController,
                        decoration: InputDecoration(
                          labelText: "Room",
                          border: OutlineInputBorder(),
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                        controller: _txtLatController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Lat",
                          border: OutlineInputBorder(),
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                        controller: _txtLngController,
                        keyboardType: TextInputType.number,
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
                          child: DropdownButton<String>(
                            isExpanded: true,
                            items: packageTypeListModel.map((value) {
                              return DropdownMenuItem<String>(
                                value: value.id.toString(),
                                child: Text(value.name),
                              );
                            }).toList(),
                            //onChanged: (value) => print("hello value "+value.),
                            onChanged: (value) => _onSelectedPackageTypeCode(value.toString()),
                            value: _selectedPackageTypeCode,
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
                          child: DropdownButton<String>(
                            isExpanded: true,
                            items: packageListModel.map((value) {
                              return DropdownMenuItem<String>(
                                value: value.id.toString(),
                                child: Text(value.name),
                              );
                            }).toList(),
                            //onChanged: (value) => print("hello value "+value.),
                            onChanged: (value) => _onSelectedPackageCode(value.toString()),
                            value: _selectedPackageCode,
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
                          child: DropdownButton<String>(
                            isExpanded: true,
                            items: paymentListModel.map((value) {
                              return DropdownMenuItem<String>(
                                value: value.id.toString(),
                                child: Text(value.name),
                              );
                            }).toList(),
                            //onChanged: (value) => print("hello value "+value.),
                            onChanged: (value) => _onSelectedPaymentCode(value.toString()),
                            value: _selectedPaymentCode,
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
                          child: DropdownButton<String>(
                            isExpanded: true,
                            items: planListModel.map((value) {
                              return DropdownMenuItem<String>(
                                value: value.id.toString(),
                                child: Text(value.name),
                              );
                            }).toList(),
                            //onChanged: (value) => print("hello value "+value.),
                            onChanged: (value) => _onSelectedPlanCode(value.toString()),
                            value: _selectedPlanCode,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                        controller: _txtRemarkController,
                        decoration: InputDecoration(
                          labelText: "Remark",
                          border: OutlineInputBorder(),
                        )
                    ),
                  ),
                  Center(
                    child: _imageContractphoto == null
                        ? Text('No Contract photo selected.')
                        : Image.file(_imageContractphoto!),
                  ),
                  Padding(
                    padding: EdgeInsets.all(30),
                    child: Center(
                      child: RaisedButton(
                        child: Container(
                            height: 20,
                            child: Text("Choose Contract photo")),
                        onPressed: (){
                          _chooseContractphotoDialog();
                        },
                      ),
                    ),

                  ),
                  Center(
                    child: _imageTranscationphoto == null
                        ? Text('No Transcation photo selected.')
                        : Image.file(_imageTranscationphoto!),
                  ),
                  Padding(
                    padding: EdgeInsets.all(30),
                    child: Center(
                      child: RaisedButton(
                        child: Container(
                            height: 20,
                            child: Text("Choose Transcation photo")),
                        onPressed: (){
                          _chooseTranscationphotoDialog();
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
                  UpdateOrder();
                }),
          ),

        ],
      ),
    );

  }
}
