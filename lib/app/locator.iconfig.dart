// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:oureschoolweb/core/services/auth_services.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:oureschoolweb/core/services/thirdparty_services_module.dart';
import 'package:oureschoolweb/core/services/services.dart';
import 'package:oureschoolweb/core/services/shared_preference.dart';
import 'package:get_it/get_it.dart';

void $initGetIt(GetIt g, {String environment}) {
  final thirdPartyServicesModule = _$ThirdPartyServicesModule();
  g.registerLazySingleton<DialogService>(
      () => thirdPartyServicesModule.dialogService);
  g.registerLazySingleton<NavigationService>(
      () => thirdPartyServicesModule.navigationService);

  //Eager singletons must be registered in the right order
  g.registerSingleton<SharedPreferencesHelper>(SharedPreferencesHelper());
  g.registerSingleton<AuthServices>(AuthServices());
  g.registerSingleton<Services>(Services());
}

class _$ThirdPartyServicesModule extends ThirdPartyServicesModule {
  @override
  DialogService get dialogService => DialogService();
  @override
  NavigationService get navigationService => NavigationService();
}
