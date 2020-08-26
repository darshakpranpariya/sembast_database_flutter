//address_dao => means database access object, means CRUD operations

import 'package:sembast/sembast.dart';
import 'package:sembast_database/database/app_database.dart';
import 'package:sembast_database/models/address_class.dart';

class AddressDao {
  static const String STORE_NAME = 'Address';
  // A Store with int keys and Map<String, dynamic> values.
  // This Store acts like a persistent map, values of which are AddressClass objects converted to Map
  final _addressStore = intMapStoreFactory.store(STORE_NAME);

  // Private getter to shorten the amount of code needed to get the
  // singleton instance of an opened database.
  Future<Database> get _db async => await AppDatabase.instance.database;

  Future insert(AddressClass adr) async {
    await _addressStore.add(await _db, adr.toMap());
  }

  Future update(AddressClass adr,int id) async {
    // For filtering by key (ID), RegEx, greater than, and many other criteria,
    // we use a Finder.
    print(id);
    final finder = Finder(filter: Filter.byKey(id));
    await _addressStore.update(
      await _db,
      adr.toMap(),
      finder: finder,
    );
  }

  Future delete(AddressClass fruit) async {
    final finder = Finder(filter: Filter.byKey(fruit.id));
    await _addressStore.delete(
      await _db,
      finder: finder,
    );
  }

  Future<List<AddressClass>> getAllSortedByName() async {
    // Finder object can also sort data.
    final finder = Finder(sortOrders: [
      SortOrder('firstName'),
    ]);

    final recordSnapshots = await _addressStore.find(
      await _db,
      finder: finder,
    );

    // Making a List<AddressClass> out of List<RecordSnapshot>
    return recordSnapshots.map((snapshot) {
      final adr = AddressClass.fromMap(snapshot.value);
      // An ID is a key of a record from the database.
      adr.id = snapshot.key;
      return adr;
    }).toList();
  }
}