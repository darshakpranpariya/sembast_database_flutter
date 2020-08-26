class AddressClass{

  // Id will be gotten from the database.
  // It's automatically generated & unique for every stored Fruit.
  int id;

  String firstName;
  String lastName;
  String address;
  String pinCode;
  String mobileNumber;

  AddressClass(this.firstName,this.lastName,this.address,this.pinCode,this.mobileNumber);

  Map<String,dynamic> toMap(){
    var map = <String,dynamic>{
      'firstName':firstName,
      'lastName':lastName,
      'address':address,
      'pinCode':pinCode,
      'mobileNumber':mobileNumber
    };
    return map;
  }

  AddressClass.fromMap(Map<String,dynamic> map){
    this.firstName = map['firstName'];
    this.lastName = map['lastName'];
    this.address = map['address'];
    this.pinCode = map['pinCode'];
    this.mobileNumber = map['mobileNumber'];
  }
}