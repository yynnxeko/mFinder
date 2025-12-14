import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/tiktok_remote_datasource.dart';
import '../../data/repositories/tiktok_repository_impl.dart';
import '../../domain/repositories/tiktok_repository.dart';
import '../../domain/usecases/get_tiktok_uid.dart';
import '../../domain/usecases/tiktok_uid_params.dart';
import '../../../../core/providers/core_providers.dart';

final tiktokRemoteDataSourceProvider = Provider<TiktokRemoteDataSource>((ref) {
  return TiktokRemoteDataSourceImpl(apiClient: ref.watch(apiClientProvider));
});

final tiktokRepositoryProvider = Provider<TiktokRepository>((ref) {
  return TiktokRepositoryImpl(
    remoteDataSource: ref.watch(tiktokRemoteDataSourceProvider),
    networkInfo: ref.watch(networkInfoProvider),
  );
});

final getTiktokUidUseCaseProvider = Provider<GetTiktokUidUseCase>((ref) {
  return GetTiktokUidUseCase(ref.watch(tiktokRepositoryProvider));
});

class TiktokState {
  final bool isLoading;
  final String? uid;
  final String? error;

  const TiktokState({this.isLoading = false, this.uid, this.error});

  TiktokState copyWith({bool? isLoading, String? uid, String? error}) {
    return TiktokState(
      isLoading: isLoading ?? this.isLoading,
      uid: uid ?? this.uid,
      error: error ?? this.error,
    );
  }
}

class TiktokNotifier extends Notifier<TiktokState> {
  @override
  TiktokState build() => const TiktokState();

  Future<void> fetchUid(String profileUrl) async {
    if (profileUrl.trim().isEmpty) {
      state = state.copyWith(error: 'Please enter a valid URL', isLoading: false);
      return;
    }
    state = state.copyWith(isLoading: true, error: null, uid: null);
    try {
      final useCase = ref.read(getTiktokUidUseCaseProvider);
      final params = TiktokUidParams(profileUrl: profileUrl);
      final result = await useCase.call(params);
      result.fold(
        (failure) => state = state.copyWith(isLoading: false, error: failure.message, uid: null),
        (entity) => state = state.copyWith(isLoading: false, error: null, uid: entity.uid),
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'Unexpected error: $e', uid: null);
    }
  }

  void reset() => state = const TiktokState();
}

final tiktokNotifierProvider =
    NotifierProvider<TiktokNotifier, TiktokState>(TiktokNotifier.new);
