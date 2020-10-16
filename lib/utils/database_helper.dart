import 'dart:io';
import 'package:flutter_project/model/contact.dart';
import 'package:flutter_project/model/item.dart';
import 'package:flutter_project/model/orders.dart';
import 'package:flutter_project/model/supplier.dart';
import 'package:flutter_project/model/user.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const _databaseName = 'Database.db';
  static const _databaseVersion = 1;

  //singleton class
  DatabaseHelper._();
  static final DatabaseHelper instance = DatabaseHelper._();

  Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory dataDirectory = await getApplicationDocumentsDirectory();
    String dbPath = join(dataDirectory.path, _databaseName);
    print(dbPath);
    return await openDatabase(dbPath,
        version: _databaseVersion, onCreate: _onCreateDB);
  }

  Future _onCreateDB(Database db, int version) async {
//    create tables
    await db.execute('''
      CREATE TABLE ${Contact.tblContact}(
        ${Contact.colId} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${Contact.colName} TEXT NOT NULL,
        ${Contact.colMobile} TEXT NOT NULL
      )
      ''');

    await db.execute('''
      CREATE TABLE ${Item.tblItem}(
        ${Item.colId} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${Item.colName} TEXT NOT NULL,
        ${Item.colBrand} TEXT NOT NULL,
        ${Item.colPrice} TEXT NOT NULL
        
      )
      ''');

    await db.execute('''
      CREATE TABLE ${User.tblUser}(
        ${User.colId} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${User.colRole} TEXT,
        ${User.colFirstname} TEXT ,
        ${User.colLastname} TEXT ,
        ${User.colPassword} TEXT ,
        ${User.colEmail} TEXT 
        
        
      )
      ''');

    await db.execute('''
      CREATE TABLE ${Orders.tblOrder}(
        ${Orders.colId} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${Orders.colSLocation} TEXT,
        ${Orders.colSManager} TEXT ,
        ${Orders.colItemName} TEXT ,
        ${Orders.colSupplier} TEXT ,
        ${Orders.colPrice} TEXT ,
        ${Orders.colDate} TEXT 
        
        
      )
      ''');

    await db.execute('''
      CREATE TABLE ${Supplier.tblSupplier}(
        ${Supplier.colId} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${Supplier.colCompanyName} TEXT   
      )
      ''');


  }

  //contact - insert
  Future<int> insertContact(Contact contact) async {
    Database db = await database;
    return await db.insert(Contact.tblContact, contact.toMap());

  }
//contact - update
  Future<int> updateContact(Contact contact) async {
    Database db = await database;
    return await db.update(Contact.tblContact, contact.toMap(),
        where: '${Contact.colId}=?', whereArgs: [contact.id]);
  }
//contact - delete
  Future<int> deleteContact(int id) async {
    Database db = await database;
    return await db.delete(Contact.tblContact,
        where: '${Contact.colId}=?', whereArgs: [id]);
  }
//contact - retrieve all
  Future<List<Contact>> fetchContacts() async {
    Database db = await database;
    List<Map> contacts = await db.query(Contact.tblContact);
    return contacts.length == 0
        ? []
        : contacts.map((x) => Contact.fromMap(x)).toList();
  }


   Future<int>insertItems(Item item) async{
     Database db = await database;
     return await db.insert(Item.tblItem, item.toMap());


   }

   Future<List<Item>>fetchItems() async{
    Database db = await database;
    List items = await db.query(Item.tblItem);
    return items.length ==0
        ? []
        :items.map((e) => Item.fromMap(e)).toList();

   }

  //item - update
  Future<int> updateItem(Item item) async {
    Database db = await database;
    return await db.update(Item.tblItem, item.toMap(),
        where: '${Item.colId}=?', whereArgs: [item.itemId]);
  }

  //contact - delete
  Future<int> deleteItem(int id) async {
    Database db = await database;
    return await db.delete(Item.tblItem,
        where: '${Item.colId}=?', whereArgs: [id]);
  }





  // User

// inserting user

  Future<int> insertUser(User user) async {
    print('thaoa');
    Database db = await database;
    return await db.insert(User.tblUser, user.toMap());

  }
//fetching user


  Future<List<User>>fetchUsers() async{
    Database db = await database;
    List users = await db.query(User.tblUser);
    return users.length ==0
        ? []
        :users.map((e) => User.fromMap(e)).toList();

  }

  //insert order
  Future<int> insertOrder(Orders order) async {

    Database db = await database;
    return await db.insert(User.tblUser, order.toMap());

  }

  //insert Supplier
  Future<int> insertSupplier(Supplier supplier) async {
    Database db = await database;
    return await db.insert(Supplier.tblSupplier, supplier.toMap());

  }

  //get Supplier

  Future<List<Supplier>> fetchSupplier() async {
    Database db = await database;
    List<Map> supplier = await db.query(Supplier.tblSupplier);
    return supplier.length == 0
        ? []
        : supplier.map((x) => Supplier.fromMap(x)).toList();
  }

  //toDropdown




}

