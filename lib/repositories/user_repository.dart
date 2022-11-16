import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_scroll_mixin/models/user_model.dart';

class UserRepository {
  final Dio _dio;
  UserRepository({
    required Dio dio,
  }) : _dio = dio;

  Future<List<UserModel>> getUsers({
    int? page,
    int? limit,
  }) async {
    try {
      debugPrint('buscar pagina $page');
      final result = await _dio
          .get('/users', queryParameters: {'page': '$page', 'limit': '$limit'});

      await Future.delayed(const Duration(milliseconds: 900));
      debugPrint(result.realUri.toString());
      return result.data
          .map<UserModel>((users) => UserModel.fromMap(users))
          .toList();
    } on DioError catch (e, s) {
      log('Erro ao carregar usuários',
          time: DateTime.now(), error: e, stackTrace: s);
      throw Exception();
    }
  }
}
