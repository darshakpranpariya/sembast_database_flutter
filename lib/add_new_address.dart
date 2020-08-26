import 'package:flutter/material.dart';
import 'package:sembast_database/homepage.dart';
import 'package:sembast_database/models/address_class.dart';
import 'package:sembast_database/database/address_dao.dart';

// Screen from which we can insert and update data...
class AddNewAddress extends StatefulWidget {
  bool isUpdating;
  String firstname;
  String lastname;
  String address;
  String pincode;
  String mobilenumber;
  int id;

  AddNewAddress({
    Key key,
    this.isUpdating,
    this.firstname,
    this.lastname,
    this.address,
    this.pincode,
    this.mobilenumber,
    this.id,
  }) : super(key: key);

  @override
  _AddNewAddressState createState() => _AddNewAddressState();
}

class _AddNewAddressState extends State<AddNewAddress> {
  Future<List<AddressClass>> addresses;
  TextEditingController controllerFirstname = TextEditingController();
  TextEditingController controllerLastname = TextEditingController();
  TextEditingController controllerAddress = TextEditingController();
  TextEditingController controllerPincode = TextEditingController();
  TextEditingController controllerMobileNumber = TextEditingController();

  String firstname;
  String lastname;
  String address;
  String pincode;
  String mobilenumber;

  final formKey = new GlobalKey<FormState>();
  var dbHelper;
  // bool isUpdating;

  @override
  void initState() {
    super.initState();
    dbHelper = AddressDao();
    controllerFirstname.text = widget.firstname;
    controllerLastname.text = widget.lastname;
    controllerAddress.text = widget.address;
    controllerPincode.text = widget.pincode;
    controllerMobileNumber.text = widget.mobilenumber;
    // isUpdating = false;
    // refreshList();
  }

  validate() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      if (widget.isUpdating) {
        AddressClass e =
            AddressClass(firstname, lastname, address, pincode, mobilenumber);
        dbHelper.update(e, widget.id);
        setState(() {
          widget.isUpdating = false;
        });
      } else {
        AddressClass e =
            AddressClass(firstname, lastname, address, pincode, mobilenumber);
        dbHelper.insert(e);
      }
      clearName();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
  }

  clearName() {
    controllerFirstname.text = '';
    controllerLastname.text = '';
    controllerAddress.text = '';
    controllerPincode.text = '';
    controllerMobileNumber.text = '';
  }

  form() {
    return Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: ListView(
          children: <Widget>[
            TextFormField(
              controller: controllerFirstname,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  labelText: 'Firstname*', prefixIcon: Icon(Icons.person)),
              validator: (val) => val.length == 0 ? 'Enter FirstName' : null,
              onSaved: (val) => firstname = val,
            ),
            TextFormField(
              controller: controllerLastname,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  labelText: 'Lastname*',
                  prefixIcon: Icon(Icons.person_outline)),
              validator: (val) => val.length == 0 ? 'Enter LastName' : null,
              onSaved: (val) => lastname = val,
            ),
            TextFormField(
              controller: controllerAddress,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  labelText: 'Address*', prefixIcon: Icon(Icons.location_on)),
              validator: (val) => val.length == 0 ? 'Enter Address' : null,
              onSaved: (val) => address = val,
            ),
            TextFormField(
              controller: controllerPincode,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  labelText: 'PIN Code*',
                  prefixIcon: Icon(Icons.mobile_screen_share)),
              validator: (val) => val.length == 0 ? 'Enter Pincode' : null,
              onSaved: (val) => pincode = val,
            ),
            Row(
              children: [
                
                Expanded(
                  child: TextFormField(
                    controller: controllerMobileNumber,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText: 'Mobile Number*',
                        prefixIcon: Icon(Icons.phone_android)),
                    validator: (val) =>
                        val.length < 10 ? 'Enter Correct Mobile Number' : null,
                    onSaved: (val) => mobilenumber = val,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton(
                  color: Colors.black,
                  onPressed: validate,
                  child: Text(
                    widget.isUpdating ? 'UPDATE' : 'ADD',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                FlatButton(
                  color: Colors.blue,
                  onPressed: () {
                    setState(() {
                      widget.isUpdating = false;
                    });
                    clearName();
                  },
                  child: Text(
                    'CANCEL',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Stack(
        children: [
          Container(),
          Positioned(
            top: 40.0,
            left: 15.0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  color: Colors.white,
                )
              ],
            ),
          ),
          Positioned(
            top: 100.0,
            left: 30.0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    "Add New Address",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 140.0),
            child: Container(
              height: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20.0),
                  topLeft: Radius.circular(20.0),
                ),
                color: Colors.white,
              ),
              child: form(),
            ),
          ),
        ],
      ),
    );
  }
}
