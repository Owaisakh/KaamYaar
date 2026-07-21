// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'active_job_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ActiveJobController)
final activeJobControllerProvider = ActiveJobControllerProvider._();

final class ActiveJobControllerProvider
    extends $NotifierProvider<ActiveJobController, bool> {
  ActiveJobControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activeJobControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$activeJobControllerHash();

  @$internal
  @override
  ActiveJobController create() => ActiveJobController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$activeJobControllerHash() =>
    r'04d659af9084eb6f0b9ce82dc843b3132146316d';

abstract class _$ActiveJobController extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
