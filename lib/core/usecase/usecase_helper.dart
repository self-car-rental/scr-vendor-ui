// Project imports:
import 'package:scr_vendor_ui/core/network/api_result.dart';

abstract class UseCase<Type, Params> {
  Future<ApiResult<Type>> call(Params params);
}
