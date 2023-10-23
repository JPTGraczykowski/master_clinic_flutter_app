import 'package:dio/dio.dart';
import '../main.dart';

class RequestInterceptor extends Interceptor {
  RequestInterceptor();

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final noAuthEndpoints = <String>[
      'users/sign_in.json',
    ];

    if (noAuthEndpoints.contains(options.path.toString())) {
      print(options.path.toString());
      print('skipped');
      return handler.next(options);
    }

    String token = await storage.read(key: 'authorization_token') ?? '';

    options.headers.addAll(
      {
        'Authorization': token,
      },
    );
    return handler.next(options);
  }
}
