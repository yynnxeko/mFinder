import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/facebook_remote_datasource.dart';
import '../../data/repositories/facebook_repository_impl.dart';
import '../../domain/repositories/facebook_repository.dart';
import '../../domain/usecases/get_facebook_uid.dart';
import '../../domain/usecases/facebook_uid_params.dart';
import '../../../../core/providers/core_providers.dart';

/// Facebook-specific providers
final facebookRemoteDataSourceProvider = Provider<FacebookRemoteDataSource>((ref) {
  return FacebookRemoteDataSourceImpl(
    apiClient: ref.watch(apiClientProvider),
  );
});

final facebookRepositoryProvider = Provider<FacebookRepository>((ref) {
  return FacebookRepositoryImpl(
    remoteDataSource: ref.watch(facebookRemoteDataSourceProvider),
    networkInfo: ref.watch(networkInfoProvider),
  );
});

final getFacebookUidUseCaseProvider = Provider<GetFacebookUidUseCase>((ref) {
  return GetFacebookUidUseCase(ref.watch(facebookRepositoryProvider));
});

/// State class for Facebook
class FacebookState {
  final bool isLoading;
  final String? uid;
  final String? error;

  const FacebookState({
    this.isLoading = false,
    this.uid,
    this.error,
  });

  FacebookState copyWith({
    bool? isLoading,
    String? uid,
    String? error,
  }) {
    return FacebookState(
      isLoading: isLoading ?? this.isLoading,
      uid: uid ?? this.uid,
      error: error ?? this.error,
    );
  }
}

/// Facebook Notifier
class FacebookNotifier extends Notifier<FacebookState> {
  @override
  FacebookState build() {
    return const FacebookState();
  }

  Future<void> fetchUid(String profileUrl) async {
    if (profileUrl.trim().isEmpty) {
      state = state.copyWith(error: 'Please enter a valid URL', isLoading: false);
      return;
    }

    state = state.copyWith(isLoading: true, error: null, uid: null);

    try {
      final useCase = ref.read(getFacebookUidUseCaseProvider);
      final params = FacebookUidParams(profileUrl: profileUrl);
      final result = await useCase.call(params);

      result.fold(
        (failure) => state = state.copyWith(
          isLoading: false,
          error: failure.message,
          uid: null,
        ),
        (entity) => state = state.copyWith(
          isLoading: false,
          error: null,
          uid: entity.uid,
        ),
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Unexpected error: $e',
        uid: null,
      );
    }
  }

  void reset() {
    state = const FacebookState();
  }
}

/// Provider
final facebookNotifierProvider =
    NotifierProvider<FacebookNotifier, FacebookState>(FacebookNotifier.new);