import 'package:konsi_test/app/core/common/utils/database_creator.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseTables {
  static Future<void> createTables(Transaction transaction) async {
    /// registros TABLE
    await transaction.execute(
      DatabaseCreator()
          .newTable('records')
          //Columns
          .addColumn(name: 'id', type: 'INTEGER', isPrimaryKey: true, isAutoIncrement: true)
          .addColumn(name: 'favorited', type: 'INT(1)', defaultValue: 0)
          .addColumn(name: 'address_id', type: 'INTEGER')
          //ForeignKeys
          .addForeignKey(column: 'address_id', foreignTable: 'address', foreignColumn: 'id')
          //Return query
          .create(),
    );

    /// address TABLE
    await transaction.execute(
      DatabaseCreator()
          .newTable('address')
          //Columns
          .addColumn(name: 'id', type: 'INTEGER', isPrimaryKey: true, isAutoIncrement: true)
          .addColumn(name: 'cep', type: 'TEXT')
          .addColumn(name: 'address', type: 'TEXT')
          .addColumn(name: 'number', type: 'TEXT', isNullable: true)
          .addColumn(name: 'complement', type: 'TEXT', isNullable: true)
          .addColumn(name: 'latitude', type: 'DOUBLE')
          .addColumn(name: 'longitude', type: 'DOUBLE')
          //Return query
          .create(),
    );
  }
}
