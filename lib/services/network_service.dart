import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_logging_interceptor/dio_logging_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

abstract class NetworkServices{
  Future getRequest(String url,);
  Future postRequest(String url, Map<String, dynamic> body,);
}

class DioNetworkService implements NetworkServices{
  final dio = Dio(
    BaseOptions(
      setRequestContentTypeWhenNoPayload: false,
      receiveDataWhenStatusError: false,
      followRedirects: false,
    ),
  )..interceptors.addAll(
    [
      DioLoggingInterceptor(
        level: Level.basic,
        compact: false,
      ),
      DioCacheInterceptor(
        options: CacheOptions(
          store: MemCacheStore(maxSize: 10485760, maxEntrySize: 1048576,),
          hitCacheOnErrorExcept: [], // for offline behaviour
        ),
      ),
      PrettyDioLogger(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
        compact: true,
      ),
    ],
  );

  DioNetworkService();

  @override
  Future getRequest(String url,) async{
    final response = await dio.get(url,);
    return response.data;
  }

  @override
  Future postRequest(String url, Map<String, dynamic> body,) async{
    final response = await dio.post(url, data: jsonEncode(body,),);
    return response.data;
  }

}