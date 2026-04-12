// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use

part of 'app_router.dart';

// ════════════════════════════════════════════════════════════════
// Riverpod tarafından otomatik üretilen kod
// dart run build_runner build --delete-conflicting-outputs
// ════════════════════════════════════════════════════════════════

String _$appRouterHash() => r'lutke_app_router_v1';

/// GoRouter provider — @riverpod annotation ile üretilmiş
/// Kaynak: lib/core/router/app_router.dart → appRouter()
final appRouterProvider = Provider<GoRouter>((ref) {
  return appRouter(AppRouterRef._(ref));
});

class AppRouterRef {
  final Ref _ref;
  AppRouterRef._(this._ref);

  T watch<T>(ProviderListenable<T> provider) => _ref.watch(provider);
  T read<T>(ProviderListenable<T> provider) => _ref.read(provider);
  void listen<T>(ProviderListenable<T> provider, void Function(T?, T) listener) =>
      _ref.listen(provider, listener);
  void onDispose(void Function() cb) => _ref.onDispose(cb);
}
