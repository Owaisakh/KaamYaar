// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(serviceRepository)
final serviceRepositoryProvider = ServiceRepositoryProvider._();

final class ServiceRepositoryProvider
    extends
        $FunctionalProvider<
          ServiceRepository,
          ServiceRepository,
          ServiceRepository
        >
    with $Provider<ServiceRepository> {
  ServiceRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'serviceRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$serviceRepositoryHash();

  @$internal
  @override
  $ProviderElement<ServiceRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ServiceRepository create(Ref ref) {
    return serviceRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ServiceRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ServiceRepository>(value),
    );
  }
}

String _$serviceRepositoryHash() => r'1c1851b56cdd27f6c713260440bb3c3c32ec978d';

@ProviderFor(activeServices)
final activeServicesProvider = ActiveServicesProvider._();

final class ActiveServicesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ServiceModel>>,
          List<ServiceModel>,
          FutureOr<List<ServiceModel>>
        >
    with
        $FutureModifier<List<ServiceModel>>,
        $FutureProvider<List<ServiceModel>> {
  ActiveServicesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activeServicesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$activeServicesHash();

  @$internal
  @override
  $FutureProviderElement<List<ServiceModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ServiceModel>> create(Ref ref) {
    return activeServices(ref);
  }
}

String _$activeServicesHash() => r'6cfdb3f1b78016c9fc92db12a149d249787c379e';
