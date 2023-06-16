import 'package:eminencetel/main.dart';
import 'package:http_interceptor/http_interceptor.dart';

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    logger.i("${data.url}\n${data.params}\n${data.body}");
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    logger.i("${data.url}\n${data.body}");
    return data;
  }
}
