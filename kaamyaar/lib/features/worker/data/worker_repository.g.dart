// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'worker_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(workerRepository)
final workerRepositoryProvider = WorkerRepositoryProvider._();

final class WorkerRepositoryProvider
    extends
        $FunctionalProvider<
          WorkerRepository,
          WorkerRepository,
          WorkerRepository
        >
    with $Provider<WorkerRepository> {
  WorkerRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'workerRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$workerRepositoryHash();

  @$internal
  @override
  $ProviderElement<WorkerRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  WorkerRepository create(Ref ref) {
    return workerRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WorkerRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WorkerRepository>(value),
    );
  }
}

String _$workerRepositoryHash() => r'64eb9fb056174b2b5b132e61efca3bc772713737';
