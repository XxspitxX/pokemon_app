import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ApiSource {
  final Dio dio;

  ApiSource(this.dio);

  Future<T> getApi<T>(
    String endpoint,
    T Function(dynamic value) mapperFunction, {
    Options? options,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  }) async {
    
    final response = handleResponse(
      () => dio.get(
        endpoint,
        options: options,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      ),
      mapperFunction,
    );

    return response;
  }

  Future<T> handleResponse<T>(Future<Response<dynamic>> Function() handler,
      T Function(dynamic value) mapperFunction) async {
    try {
      final response = await handler();

      return mapperFunction(response.data);
    } on DioException catch (e) {
      throw Exception(e);
    }
  }
}
