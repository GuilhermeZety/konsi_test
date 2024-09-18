class DatabaseCreatorQuery {
  final String query;
  DatabaseCreatorQuery({
    required this.query,
  });
}

class DatabaseCreator {
  DatabaseCreatorQuery newTable(String tableName) {
    return DatabaseCreatorQuery(query: 'CREATE TABLE IF NOT EXISTS $tableName ( ');
  }
}

extension CreatorExtras on DatabaseCreatorQuery {
  DatabaseCreatorQuery addColumn({
    required String name,
    required String type,
    bool isNullable = false,
    bool isPrimaryKey = false,
    bool isUnique = false,
    bool isAutoIncrement = false,
    Object? defaultValue,
  }) {
    String query = '$name $type';

    if (defaultValue != null) {
      query += ' DEFAULT $defaultValue';
    }
    if (!isNullable) {
      query += ' NOT NULL';
    }
    if (isPrimaryKey) {
      query += ' PRIMARY KEY';
    }
    if (isUnique) {
      query += ' UNIQUE';
    }
    if (isAutoIncrement) {
      query += ' AUTOINCREMENT';
    }
    query += ',';
    return DatabaseCreatorQuery(query: this.query + query);
  }

  DatabaseCreatorQuery addForeignKey({
    required String column,
    required String foreignTable,
    required String foreignColumn,
  }) {
    String query = 'FOREIGN KEY ($column) REFERENCES $foreignTable($foreignColumn),';
    return DatabaseCreatorQuery(query: this.query + query);
  }
}

extension CreateCreator on DatabaseCreatorQuery {
  String create() {
    return '${query.substring(0, query.length - 1)});';
  }
}
