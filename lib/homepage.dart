import 'package:flutter/material.dart';
import 'package:sembast_database/add_new_address.dart';
import 'package:sembast_database/database/address_dao.dart';
import 'package:sembast_database/models/address_class.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Future<List<AddressClass>> addresses;
  AddressDao dbHelper;
  bool isUpdating;
  int curUserId;

  @override
  void initState() {
    super.initState();
    dbHelper = AddressDao();
    refreshList();
  }

  refreshList() {
    setState(() {
      addresses = dbHelper.getAllSortedByName();
    });
  }

  ListView dataTable(List<AddressClass> address) {
    return ListView.builder(
        itemCount: address.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            "Name : " + address[index].firstName,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text("Mobile :" + address[index].mobileNumber),
                          Text("Address : " + address[index].address),
                        ],
                      ),
                    ],
                  ),
                ),
                ButtonBar(
                  children: <Widget>[
                    FlatButton(
                      child: const Text('Edit'),
                      onPressed: () {
                        var route = MaterialPageRoute(
                          builder: (BuildContext context) => AddNewAddress(
                            isUpdating: true,
                            firstname: address[index].firstName,
                            lastname: address[index].lastName,
                            address: address[index].address,
                            pincode: address[index].pinCode,
                            mobilenumber: address[index].mobileNumber,
                            id:address[index].id,
                          ),
                        );
                        Navigator.pushReplacement(context, route);
                      },
                    ),
                    FlatButton(
                      child: const Text('Remove'),
                      onPressed: () {
                        dbHelper.delete(address[index]);
                        refreshList();
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }

  list() {
    return FutureBuilder<List<AddressClass>>(
      future: addresses,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return dataTable(snapshot.data);
        }

        if (null == snapshot.data || snapshot.data.length == 0) {
          return Center(child: Text("No Data Found"));
        }

        return CircularProgressIndicator();
      },
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
                  onPressed: () {},
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
                    "Address",
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
              padding: EdgeInsets.only(top:5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20.0),
                  topLeft: Radius.circular(20.0),
                ),
                color: Colors.white,
              ),
              child: list(),
            ),
          ),
          Positioned(
            bottom: 10.0,
            left: 70.0,
            child: Button(
              name: "add new address",
              onTap: () {
                var route = MaterialPageRoute(
                  builder: (BuildContext context) => AddNewAddress(
                    isUpdating: false,
                    firstname: '',
                    lastname: '',
                    address: '',
                    pincode: '',
                    mobilenumber: '',
                  ),
                );
                Navigator.of(context).push(route);
              },
            ),
          )
        ],
      ),
    );
  }
}

class Button extends StatelessWidget {
  String name;
  Function onTap;

  Button({
    this.name,
    this.onTap,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50.0,
        width: 250.0,
        color: Colors.black,
        child: Center(
          child: Text(
            name.toUpperCase(),
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
        ),
      ),
    );
  }
}
