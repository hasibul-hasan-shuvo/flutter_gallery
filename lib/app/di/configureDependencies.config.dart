// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../data/data_source/local/gallery_local_data_source.dart' as _i1068;
import '../data/data_source/local/gallery_local_data_source_impl.dart'
    as _i1071;
import '../data/repository/gallery_repository_impl.dart' as _i867;
import '../domain/repository/gallery_repository.dart' as _i191;
import '../presentation/modules/splash/view_model/splash_viewmodel.dart'
    as _i173;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.lazySingleton<_i1068.GalleryLocalDataSource>(
      () => _i1071.GalleryLocalDataSourceImpl());
  gh.lazySingleton<_i191.GalleryRepository>(
      () => _i867.GalleryRepositoryImpl(gh<_i1068.GalleryLocalDataSource>()));
  gh.factory<_i173.SplashViewModel>(() =>
      _i173.SplashViewModel(galleryRepository: gh<_i191.GalleryRepository>()));
  return getIt;
}
