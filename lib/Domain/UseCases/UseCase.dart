import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../Data/Core/AppError.dart';
import '../../index/index_main.dart';

abstract class UseCase<OutPut, InPut> {
  Future<Either<AppError, OutPut>> call(InPut input);
}

abstract class Use_Case<OutPut, InPut> {
  Future<OutPut> call(InPut input);
}

T initUseCase<T>(T Function() createInstance) {
  return Get.isRegistered<T>() ? Get.find<T>() : Get.put(createInstance());
}
