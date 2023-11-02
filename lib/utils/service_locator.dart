import 'package:get_it/get_it.dart';
import 'package:testtask/utils/api_util.dart';
import 'package:testtask/utils/hive_util.dart';

export 'package:testtask/utils/hive_util.dart';
export 'package:testtask/utils/api_util.dart';

GetIt getIt = GetIt.instance;

void registerSingleton() {
  getIt.registerLazySingleton<HiveUtil>(() => HiveUtil());

  getIt.registerLazySingleton<ApiUtil>(() => ApiUtil());
}

Future<void> initializeServices() async {
  await getIt<HiveUtil>().initHive();
}
