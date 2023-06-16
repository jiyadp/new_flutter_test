import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:eminencetel/core/network/logging_interceptor.dart';
import 'package:eminencetel/core/network/network_info.dart';
import 'package:eminencetel/features/data/data_sources/local/app_local_data_source.dart';
import 'package:eminencetel/features/data/data_sources/local/dynamic_form_local_data_source.dart';
import 'package:eminencetel/features/data/data_sources/local/dynamic_photos_tab_local_data_source.dart';
import 'package:eminencetel/features/data/data_sources/local/local_fiber_hope_data_source.dart';
import 'package:eminencetel/features/data/data_sources/local/schedules_local_data_source.dart';
import 'package:eminencetel/features/data/data_sources/remote/certificates_remote_data_source.dart';
import 'package:eminencetel/features/data/data_sources/remote/checklist_remote_data_source.dart';
import 'package:eminencetel/features/data/data_sources/remote/dynamic_form_remote_data_source.dart';
import 'package:eminencetel/features/data/data_sources/remote/dynamic_photos_tab_remote_data_source.dart';
import 'package:eminencetel/features/data/data_sources/remote/login_remote_data_source.dart';
import 'package:eminencetel/features/data/data_sources/remote/photos_remote_data_source.dart';
import 'package:eminencetel/features/data/data_sources/remote/save_form_remote_data_source.dart';
import 'package:eminencetel/features/data/data_sources/remote/save_photography_remote_data_source.dart';
import 'package:eminencetel/features/data/data_sources/remote/save_remote_data_source.dart';
import 'package:eminencetel/features/data/data_sources/remote/schedules_remote_data_source.dart';
import 'package:eminencetel/features/data/data_sources/remote/tasks_remote_data_source.dart';
import 'package:eminencetel/features/data/repositories/app_repository_impl.dart';
import 'package:eminencetel/features/data/repositories/checklist_repository_impl.dart';
import 'package:eminencetel/features/data/repositories/dynamic_form_repository_impl.dart';
import 'package:eminencetel/features/data/repositories/dynamic_photos_tab_repository_impl.dart';
import 'package:eminencetel/features/data/repositories/local_fiber_hope_repository_impl.dart';
import 'package:eminencetel/features/data/repositories/login_repository_impl.dart';
import 'package:eminencetel/features/data/repositories/photos_repository_impl.dart';
import 'package:eminencetel/features/data/repositories/save_form_repository_impl.dart';
import 'package:eminencetel/features/data/repositories/save_photography_repository_impl.dart';
import 'package:eminencetel/features/data/repositories/save_repository_impl.dart';
import 'package:eminencetel/features/data/repositories/schedules_repository_impl.dart';
import 'package:eminencetel/features/data/repositories/tasks_repository_impl.dart';
import 'package:eminencetel/features/data/repositories/update_task_status_repository_impl.dart';
import 'package:eminencetel/features/domain/repositories/app_repository.dart';
import 'package:eminencetel/features/domain/repositories/certificate_repository.dart';
import 'package:eminencetel/features/domain/repositories/checklist_repository.dart';
import 'package:eminencetel/features/domain/repositories/dynamic_photos_tab_repository.dart';
import 'package:eminencetel/features/domain/repositories/local_fiber_hope_repository.dart';
import 'package:eminencetel/features/domain/repositories/login_repository.dart';
import 'package:eminencetel/features/domain/repositories/photos_repository.dart';
import 'package:eminencetel/features/domain/repositories/save_form_repository.dart';
import 'package:eminencetel/features/domain/repositories/save_photography_repository.dart';
import 'package:eminencetel/features/domain/repositories/save_repository.dart';
import 'package:eminencetel/features/domain/repositories/schedule_details_repository.dart';
import 'package:eminencetel/features/domain/repositories/schedules_repository.dart';
import 'package:eminencetel/features/domain/repositories/tasks_repository.dart';
import 'package:eminencetel/features/domain/repositories/update_task_status_repository.dart';
import 'package:eminencetel/features/domain/usecase/all_tasks_usecase.dart';
import 'package:eminencetel/features/domain/usecase/buzzer_usecase.dart';
import 'package:eminencetel/features/domain/usecase/certificates_usecase.dart';
import 'package:eminencetel/features/domain/usecase/checklist_usecase.dart';
import 'package:eminencetel/features/domain/usecase/dynamic_form_usecase.dart';
import 'package:eminencetel/features/domain/usecase/dynamic_photos_tab_usecase.dart';
import 'package:eminencetel/features/domain/usecase/finished_task_usecase.dart';
import 'package:eminencetel/features/domain/usecase/inprogress_task_usecase.dart';
import 'package:eminencetel/features/domain/usecase/local_fiber_hope_set_usecase.dart';
import 'package:eminencetel/features/domain/usecase/login_usecase.dart';
import 'package:eminencetel/features/domain/usecase/photos_upload_usecase.dart';
import 'package:eminencetel/features/domain/usecase/photos_upload_usecase_from_from.dart';
import 'package:eminencetel/features/domain/usecase/photos_usecase.dart';
import 'package:eminencetel/features/domain/usecase/save_form_usecase.dart';
import 'package:eminencetel/features/domain/usecase/save_photography_usecase.dart';
import 'package:eminencetel/features/domain/usecase/scheduled_tasks_usecase.dart';
import 'package:eminencetel/features/domain/usecase/schedules_usecase.dart';
import 'package:eminencetel/features/domain/usecase/tasks_usecase.dart';
import 'package:eminencetel/features/domain/usecase/todays_tasks_usecase.dart';
import 'package:eminencetel/features/domain/usecase/unfinished_task_usecase.dart';
import 'package:eminencetel/features/domain/usecase/user_usecase.dart';
import 'package:eminencetel/features/presentation/bloc/certificates_cubit.dart';
import 'package:eminencetel/features/presentation/bloc/checklist_cubit.dart';
import 'package:eminencetel/features/presentation/bloc/dynamic_form_cubit.dart';
import 'package:eminencetel/features/presentation/bloc/dynamic_photos_tab_cubit.dart';
import 'package:eminencetel/features/presentation/bloc/login_cubit.dart';
import 'package:eminencetel/features/presentation/bloc/photos_cubit.dart';
import 'package:eminencetel/features/presentation/bloc/photos_upload_cubit.dart';
import 'package:eminencetel/features/presentation/bloc/save_form_cubit.dart';
import 'package:eminencetel/features/presentation/bloc/save_photography_cubit.dart';
import 'package:eminencetel/features/presentation/bloc/schedules_cubit.dart';
import 'package:eminencetel/features/presentation/bloc/splash_cubit.dart';
import 'package:eminencetel/features/presentation/bloc/tasks_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/data/data_sources/local/schedule_details_local_data_source.dart';
import 'features/data/data_sources/local/tasks_local_data_source.dart';
import 'features/data/data_sources/local/user_local_data_source.dart';
import 'features/data/data_sources/remote/schedule_details_remote_data_source.dart';
import 'features/data/data_sources/remote/update_status_remote_data_source.dart';
import 'features/data/repositories/certificate_repository_impl.dart';
import 'features/data/repositories/schedule_details_repository_impl.dart';
import 'features/domain/repositories/dynamic_form_repository.dart';
import 'features/domain/usecase/local_fiber_hope_get_usecase.dart';
import 'features/domain/usecase/schedule_details_usecase.dart';
import 'features/domain/usecase/update_task_status_usecase.dart';
import 'features/presentation/bloc/schedule_details_cubit.dart';
import 'features/presentation/bloc/update_task_status_cubit.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  initBlocs();
  initUseCases();
  initRepositories();
  initDataSources();
  initCores();
  await initExternals();
  getIt.registerLazySingleton<http.Client>(
      () => InterceptedClient.build(interceptors: [LoggingInterceptor()]));
}

void initBlocs() {
  getIt.registerFactory(() => SplashCubit(getIt()));
  getIt.registerFactory(() => LoginCubit(getIt(), getIt()));
  getIt.registerFactory(() => PhotosCubit(getIt()));
  getIt.registerFactory(() => PhotosUploadCubit(getIt(),getIt()));
  getIt.registerFactory(() => TasksCubit(getIt(), getIt(), getIt(), getIt(), getIt(), getIt(), getIt(), getIt()));
  getIt.registerFactory(() => ScheduleDetailsCubit(getIt(),getIt()));
  getIt.registerFactory(() => UpdateTaskStatusCubit(getIt(), getIt(), getIt()));
  getIt.registerFactory(() => CertificatesCubit(getIt(), getIt()));
  getIt.registerFactory(() => ChecklistCubit(getIt(),getIt()));
  getIt.registerFactory(() => DynamicFormCubit(getIt(), getIt(), getIt()));
  getIt.registerFactory(() => SaveFormCubit(getIt()));
  getIt.registerFactory(() => SavePhotographyCubit(getIt()));
  getIt.registerFactory(() => DynamicPhotosTabCubit(getIt(), getIt(), getIt()));
  getIt.registerFactory(() => SchedulesCubit(getIt(), getIt()));
}

void initUseCases() {
  getIt.registerLazySingleton(() => LoginUseCase(getIt()));
  getIt.registerLazySingleton(() => PhotosUseCase(getIt()));
  getIt.registerLazySingleton(() => PhotosUploadUseCase(getIt()));
  getIt.registerLazySingleton(() => PhotosUploadUseCaseFromForm(getIt()));
  getIt.registerLazySingleton(() => LocalFiberHopeGetUseCase(getIt()));
  getIt.registerLazySingleton(() => TasksUseCase(getIt()));
  getIt.registerLazySingleton(() => ScheduleDetailsUseCase(getIt()));
  getIt.registerLazySingleton(() => UpdateTaskStatusUseCase(getIt()));
  getIt.registerLazySingleton(() => UserUseCase(getIt()));
  getIt.registerLazySingleton(() => CertificatesUseCase(getIt()));
  getIt.registerLazySingleton(() => TodayTasksUseCase(getIt()));
  getIt.registerLazySingleton(() => UnFinishedTaskUseCase(getIt()));
  getIt.registerLazySingleton(() => FinishedTaskUseCase(getIt()));
  getIt.registerLazySingleton(() => InProgressTaskUseCase(getIt()));
  getIt.registerLazySingleton(() => ChecklistUseCase(getIt()));
  getIt.registerLazySingleton(() => DynamicFormUseCase(getIt()));
  getIt.registerLazySingleton(() => SaveFormUseCase(getIt()));
  getIt.registerLazySingleton(() => LocalFiberHopeSetUseCase(getIt()));
  getIt.registerLazySingleton(() => DynamicPhotosTabUseCase(getIt()));
  getIt.registerLazySingleton(() => SavePhotographyUseCase(getIt()));
  getIt.registerLazySingleton(() => SchedulesUseCase(getIt()));
  getIt.registerLazySingleton(() => ScheduledTasksUseCase(getIt()));
  getIt.registerLazySingleton(() => BuzzerUseCase(getIt()));
  getIt.registerLazySingleton(() => AllTaskUseCase(getIt()));
}

void initRepositories() {
  getIt.registerLazySingleton<LoginRepository>(
      () => LoginRepositoryImpl(getIt(), getIt(), getIt()));
  getIt.registerLazySingleton<PhotosRepository>(
      () => PhotosRepositoryImpl(getIt()));
  getIt.registerLazySingleton<SaveRepository>(
      () => SaveRepositoryImpl(getIt(), getIt()));
  getIt.registerLazySingleton<TasksRepository>(
      () => TasksRepositoryImpl(getIt(), getIt()));
  getIt.registerLazySingleton<ScheduleDetailsRepository>(
      () => ScheduleDetailsRepositoryImpl(getIt(), getIt()));
  getIt.registerLazySingleton<UpdateTaskStatusRepository>(
      () => UpdateTaskStatusRepositoryImpl(getIt()));
  getIt.registerLazySingleton<CertificateRepository>(
      () => CertificateRepositoryImpl(getIt()));
  getIt.registerLazySingleton<ChecklistRepository>(
      () => ChecklistRepositoryImpl(getIt()));
  getIt.registerLazySingleton<DynamicFormRepository>(
      () => DynamicFormRepositoryImpl(getIt()));
  getIt.registerLazySingleton<SaveFormRepository>(
      () => SaveFormRepositoryImpl(getIt()));
  getIt.registerLazySingleton<DynamicPhotosTabRepository>(
      () => DynamicPhotosTabRepositoryImpl(getIt()));

  getIt.registerLazySingleton<SavePhotographyRepository>(
      () => SavePhotographyRepositoryImpl(getIt()));

  getIt.registerLazySingleton<SchedulesRepository>(
          () => SchedulesRepositoryImpl(getIt(),getIt()));

  // Local Data Repository
  getIt.registerLazySingleton<LocalFiberHopeRepository>(
      () => LocalFiberHopeRepositoryImpl(getIt()));
  getIt.registerLazySingleton<AppRepository>(
          () => AppRepositoryImpl(getIt()));

}

void initDataSources() {
  // Remote Data Source
  getIt.registerLazySingleton<LoginRemoteDataSource>(
      () => LoginRemoteDataSourceImpl(client: getIt()));
  getIt.registerLazySingleton<PhotosRemoteDataSource>(
      () => PhotosRemoteDataSourceImpl(client: getIt()));
  getIt.registerLazySingleton<SaveRemoteDataSource>(
      () => SaveRemoteDataSourceImpl(client: getIt()));
  getIt.registerLazySingleton<TasksRemoteDataSource>(() =>
      TasksRemoteDataSourceImpl(client: getIt(), userLocalDataSource: getIt()));
  getIt.registerLazySingleton<ScheduleDetailsRemoteDataSource>(
      () => ScheduleDetailsRemoteDataSourceImpl(client: getIt()));
  getIt.registerLazySingleton<UpdateTaskStatusRemoteDataSource>(() =>
      UpdateTaskStatusRemoteDataSourceImpl(
          client: getIt(), localDataSource: getIt()));
  getIt.registerLazySingleton<CertificatesRemoteDataSource>(
      () => CertificatesRemoteDataSourceImpl(client: getIt()));

  getIt.registerLazySingleton<ChecklistRemoteDataSource>(() =>
      ChecklistRemoteDataSourceImpl(
          client: getIt(), userLocalDataSource: getIt()));
  getIt.registerLazySingleton<DynamicFormRemoteDataSource>(
      () => DynamicFormRemoteDataSourceImpl(client: getIt()));
  getIt.registerLazySingleton<SaveFormRemoteDataSource>(
      () => SaveFormRemoteDataSourceImpl(client: getIt()));

  getIt.registerLazySingleton<SavePhotographyRemoteDataSource>(
      () => SavePhotographyRemoteDataSourceImpl(client: getIt()));

  getIt.registerLazySingleton<DynamicPhotosTabRemoteDataSource>(() =>
      DynamicPhotosTabRemoteDataSourceImpl(
          client: getIt(), userLocalDataSource: getIt()));

  getIt.registerLazySingleton<SchedulesRemoteDataSource>(() =>
      SchedulesRemoteDataSourceImpl(
          client: getIt(), userLocalDataSource: getIt()));

  // Local Data Source
  getIt.registerLazySingleton<UserLocalDataSource>(
      () => UserLocalDataSourceImpl(getIt()));
  getIt.registerLazySingleton<LocalFiberHopeDataSource>(
      () => LocalFiberHopeDataSourceImpl(getIt()));
  getIt.registerLazySingleton<TasksLocalDataSource>(
      () => TasksLocalDataSourceImpl(getIt()));
  getIt.registerLazySingleton<ScheduleDetailsLocalDataSource>(
      () => ScheduleDetailsLocalDataSourceImpl(getIt()));
  getIt.registerLazySingleton<DynamicFormLocalDataSource>(
      () => DynamicFormLocalDataSourceImpl(getIt()));
  getIt.registerLazySingleton<DynamicPhotosTabLocalDataSource>(
      () => DynamicPhotosTabLocalDataSourceImpl(getIt()));
  getIt.registerLazySingleton<SchedulesLocalDataSource>(
          () => SchedulesLocalDataSourceImpl(getIt()));
  getIt.registerLazySingleton<AppLocalDataSource>(
          () => AppLocalDataSourceImpl(getIt()));
}

void initCores() {
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(getIt()));
}

Future<void> initExternals() async {
  final prefs = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => prefs);
  getIt.registerLazySingleton(() => Connectivity());
}
