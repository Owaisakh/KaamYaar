// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_verifications_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PendingVerifications)
final pendingVerificationsProvider = PendingVerificationsProvider._();

final class PendingVerificationsProvider
    extends
        $AsyncNotifierProvider<
          PendingVerifications,
          List<WorkerDocumentAdminModel>
        > {
  PendingVerificationsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pendingVerificationsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pendingVerificationsHash();

  @$internal
  @override
  PendingVerifications create() => PendingVerifications();
}

String _$pendingVerificationsHash() =>
    r'b214674cada6d36e966e2be85996f0957c6ff84a';

abstract class _$PendingVerifications
    extends $AsyncNotifier<List<WorkerDocumentAdminModel>> {
  FutureOr<List<WorkerDocumentAdminModel>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<WorkerDocumentAdminModel>>,
              List<WorkerDocumentAdminModel>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<WorkerDocumentAdminModel>>,
                List<WorkerDocumentAdminModel>
              >,
              AsyncValue<List<WorkerDocumentAdminModel>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
