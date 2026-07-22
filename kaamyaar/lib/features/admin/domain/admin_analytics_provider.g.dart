// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_analytics_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AdminAnalytics)
final adminAnalyticsProvider = AdminAnalyticsProvider._();

final class AdminAnalyticsProvider
    extends $AsyncNotifierProvider<AdminAnalytics, AdminAnalyticsState> {
  AdminAnalyticsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminAnalyticsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminAnalyticsHash();

  @$internal
  @override
  AdminAnalytics create() => AdminAnalytics();
}

String _$adminAnalyticsHash() => r'ed560a9c93e3be7c329cda4f4de803a997827f2d';

abstract class _$AdminAnalytics extends $AsyncNotifier<AdminAnalyticsState> {
  FutureOr<AdminAnalyticsState> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<AdminAnalyticsState>, AdminAnalyticsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<AdminAnalyticsState>, AdminAnalyticsState>,
              AsyncValue<AdminAnalyticsState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
