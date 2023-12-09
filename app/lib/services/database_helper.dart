import 'package:flutter/cupertino.dart';
import 'package:postgres/postgres.dart';
import 'dart:core';

class DatabaseHelper {
  late PostgreSQLConnection _connection;

  Future<void> connect() async {
    try {
      _connection = PostgreSQLConnection(
        '192.168.35.177',
        5432,
        'flutter',
        username: 'flutter_app',
        password: '1234',
      );

      await _connection.open();
      debugPrint('Connected to PostgreSQL');
    } catch (e) {
      debugPrint('Error connecting to PostgreSQL: $e');
      // Handle the error, throw or return accordingly
      rethrow;
    }
  }

  Future<List<List<dynamic>>> executeQuery(String query) async {
    try {
      final results = await _connection.query(query);
      return results;
    } catch (e) {
      debugPrint('Error executing query: $e');
      // Handle the error, throw or return accordingly
      rethrow;
    }
  }

  Future<int> executeInsert(String query, Map<String, dynamic> values) async {
    try {
      final result = await _connection.query(query, substitutionValues: values);
      return result.affectedRowCount;
    } catch (e) {
      debugPrint('Error executing insert query: $e');
      // Handle the error, throw or return accordingly
      rethrow;
    }
  }


  Future<void> closeConnection() async {
    try {
      await _connection.close();
      debugPrint('Connection closed');
    } catch (e) {
      debugPrint('Error closing connection: $e');
      // Handle the error, throw or return accordingly
      rethrow;
    }
  }
}
