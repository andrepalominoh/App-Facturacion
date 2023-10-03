import 'package:async/async.dart';

import 'package:lya_encuestas/assets/constants.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBManager {
  // Singleton pattern
  static final DBManager _dbManager = DBManager._internal();
  DBManager._internal();
  static DBManager get instance => _dbManager;

  // Members
  static Database? _database;
  final _initDBMemoizer = AsyncMemoizer<Database>();

  Future<Database> get database async =>
      _database ??= await _initDBMemoizer.runOnce(() async {
        return await _initDB();
      });

  Future<Database> _initDB() async {
    String databasePath = await getDatabasesPath();
    String databaseFilePath = join(databasePath, Constants.DB_NAME);
    return await openDatabase(databaseFilePath, onCreate: (db, version) {
      db.execute('CREATE TABLE ' +
          Constants.DB_TABLE_SYNCHRONIZATIONS +
          '(id INTEGER, request_date TEXT);');
      db.execute('CREATE TABLE ' +
          Constants.DB_TABLE_USERS +
          '(id INTEGER, first_name TEXT, last_name TEXT, email TEXT, token TEXT);');
      db.execute('CREATE TABLE ' +
          Constants.DB_TABLE_CATEGORIES +
          '(id INTEGER, code TEXT, name TEXT);');
      db.execute('CREATE TABLE ' +
          Constants.DB_TABLE_CHANNELS +
          '(id INTEGER, code TEXT, name TEXT);');
      db.execute('CREATE TABLE ' +
          Constants.DB_TABLE_PERIODS +
          '(id INTEGER, code TEXT, month TEXT, year TEXT);');
      db.execute('CREATE TABLE ' +
          Constants.DB_TABLE_DISTRICTS +
          '(id INTEGER, ubigeo TEXT, name TEXT);');
      db.execute('CREATE TABLE ' +
          Constants.DB_TABLE_SELLPOINTS +
          '(id INTEGER, reference_sell_point_id INTEGER, district_id INTEGER, channel_id INTEGER, name TEXT, address TEXT, contact_name TEXT, contact_phone TEXT, annotations TEXT);');
      db.execute('CREATE TABLE ' +
          Constants.DB_TABLE_SKUS +
          '(id INTEGER, reference_sku_id INTEGER, category_id INTEGER, name TEXT, is_prioritized INTEGER, annotations TEXT);');
      db.execute('CREATE TABLE ' +
          Constants.DB_TABLE_ANSWERS +
          '(id INTEGER, period_id INTEGER, sell_point_id INTEGER, sku_id INTEGER, survey_id INTEGER, price TEXT, closed_inventory TEXT, open_inventory TEXT, purchase TEXT, estimated_sale TEXT, sync_pollster_first_name TEXT, sync_pollster_last_name TEXT, sync_pollster_email TEXT, sync_request_date TEXT);');
      db.execute('CREATE TABLE ' +
          Constants.DB_TABLE_LAST_ANSWERS +
          '(id INTEGER, work_order_id INTEGER,work_order_code TEXT,frecuency_type_code TEXT,frecuency_type_name TEXT,survey_id INTEGER,survey_type_code TEXT,survey_type_name TEXT,period_code TEXT,period_name TEXT,category_id INTEGER,survey_config_type_id INTEGER,survey_config_type_code TEXT,survey_config_type_name TEXT,sell_point_id INTEGER,sku_id INTEGER,answers TEXT);');
      db.execute('CREATE TABLE '+
          Constants.DB_TABLE_SELLPOINT_CATEGORY_CONFIGURATIONS +
          '(sell_point_id INTEGER,category_id INTEGER,category_name TEXT, period_id INTEGER,status_id INTEGER,status_code TEXT,status_name TEXT,annotations TEXT);');
      db.execute('CREATE TABLE '+ Constants.DB_TABLE_CHANNEL_CATEGORY + 
        '(channel_id INTEGER,category_id INTEGER);');
      /**************************************************************************************************************************************/
      /**************************************************************************************************************************************/
      /**************************************************************************************************************************************/
      db.execute('CREATE TABLE ' +
          Constants.DB_TABLE_BACK_IDENTIFIER +
          Constants.DB_TABLE_SELLPOINTS +
          '(id INTEGER, sync_id INTEGER, backuped_at TEXT,reference_sell_point_id INTEGER, district_id INTEGER, channel_id INTEGER, name TEXT, address TEXT, contact_name TEXT, contact_phone TEXT, annotations TEXT);');
      db.execute('CREATE TABLE ' +
          Constants.DB_TABLE_BACK_IDENTIFIER +
          Constants.DB_TABLE_SKUS +
          '(id INTEGER, sync_id INTEGER, backuped_at TEXT, reference_sku_id INTEGER, category_id INTEGER, name TEXT, is_prioritized INTEGER, annotations TEXT);');
      db.execute('CREATE TABLE ' +
          Constants.DB_TABLE_BACK_IDENTIFIER +
          Constants.DB_TABLE_ANSWERS +
          '(id INTEGER, sync_id INTEGER, backuped_at TEXT,  period_id INTEGER, sell_point_id INTEGER, sku_id INTEGER, survey_id INTEGER, price TEXT, closed_inventory TEXT, open_inventory TEXT, purchase TEXT, estimated_sale TEXT, sync_pollster_first_name TEXT, sync_pollster_last_name TEXT, sync_pollster_email TEXT, sync_request_date TEXT);');
    }, version: Constants.DB_VERSION);
  }
}
