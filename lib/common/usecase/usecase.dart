// Project imports:
import 'package:scr_vendor/common/network/api_result.dart';

abstract class UseCase<Type, Params> {
  Future<ApiResult<Type>> call(Params params);
}
