import 'dart:io';
import 'package:ghar_subidha/core/constants/string_constants.dart';
import 'package:ghar_subidha/core/database/database_constants.dart';
import 'package:ghar_subidha/core/helper/resultt/result.dart';
import 'package:ghar_subidha/feature/auth/data/model/register_model/register_model.dart';
import 'package:ghar_subidha/feature/auth/domain/usecase/auth_usecase.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DbHelper {
  static Database? _database;
  static const ispSourceDb = "ghar_subidha.db";
  int dbVersion = 1;
  DbHelper();
  DbHelper._privateConstructor();

  static final DbHelper instance = DbHelper._privateConstructor();

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, ispSourceDb);
    return await openDatabase(
      path,
      version: dbVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await _createUserTable(db);
    await _createFacilityTable(db);
    await _createBookingTable(db);
  }

  Future<void> _createUserTable(Database db) async {
    await db.execute('''
                    CREATE TABLE ${UserTable.userTableName}(  
                    ${UserTable.id} INT PRIMARY KEY,
                    ${UserTable.fullname} TEXT,
                    ${UserTable.email} TEXT UNIQUE,
                    ${UserTable.address} TEXT,
                    ${UserTable.password} TEXT
                    ) ''');
  }

  Future<void> _createFacilityTable(Database db) async {
    await db.execute('''
                    CREATE TABLE ${Facilities.facilityTableName}(  
                    ${Facilities.id} INT PRIMARY KEY,
                    ${Facilities.title} TEXT,
                    ${Facilities.image} TEXT,
                    ${Facilities.cost} TEXT,
                    ${Facilities.availableLocation} TEXT
                    ) ''');
  }

  Future<void> _createBookingTable(Database db) async {
    await db.execute('''
                    CREATE TABLE ${Booking.bookingTableName}(  
                    ${Booking.id} INT PRIMARY KEY,
                    ${Booking.facId} INT FOREIGN KEY,
                    ${Booking.userId} INT FOREIGN KEY,
                    ${Booking.time} DATETIME 
                    ) ''');
  }

  Future<Result> registerUser(UserRegister userData) async {
    try {
      Database? db = await instance.database;
      var batch = db?.batch();
      var userAlreadyExist =
          "SELECT * FROM ${UserTable.userTableName} WHERE ${UserTable.email}= ${userData.email}";
      if (userAlreadyExist != "") {
        batch?.insert(UserTable.userTableName, userData.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace);
        return Result.success("User register successfully");
      } else {
        return Result.error("Email already exist");
      }
    } catch (e) {
      return Result.error(DataError(DbError.DB_ERROR, DbError.DB_ERROR_CODE));
    }
  }

  Future<Result> loginUser(SignInParam param) async {
    try {
      Database? db = await instance.database;
      var query =
          "SELECT * FROM ${UserTable.userTableName} WHERE ${UserTable.email}= ${param.email} AND ${UserTable.password}= ${param.password}";
      var user = await db?.rawQuery(query);
      if (user!.isNotEmpty) {
        return Result.success(user);
      } else {
        return Result.error("Email and Password doesnot match");
      }
    } catch (e) {
      return Result.error(DataError(DbError.DB_ERROR, DbError.DB_ERROR_CODE));
    }
  }

  Future<Result> bookService(Map<String, dynamic> bookService) async {
    try {
      Database? db = await instance.database;
      var batch = db?.batch();
      batch?.insert(Booking.bookingTableName, bookService);
      return Result.success("Booked successfully !!!");
    } catch (e) {
      return Result.error(e.toString());
    }
  }
}
