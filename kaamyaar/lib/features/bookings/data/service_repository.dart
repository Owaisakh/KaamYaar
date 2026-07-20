import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../domain/service_model.dart';

part 'service_repository.g.dart';

class ServiceRepository {
  final SupabaseClient _client;

  ServiceRepository(this._client);

  Future<List<ServiceModel>> getActiveServices() async {
    final response = await _client
        .from('services')
        .select()
        .eq('is_active', true)
        .order('sort_order', ascending: true);

    return (response as List<dynamic>)
        .map((e) => ServiceModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<ServiceModel>> searchServices(String query) async {
    final response = await _client
        .from('services')
        .select()
        .eq('is_active', true)
        .ilike('name', '%$query%')
        .order('sort_order', ascending: true);

    return (response as List<dynamic>)
        .map((e) => ServiceModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}

@riverpod
ServiceRepository serviceRepository(ServiceRepositoryRef ref) {
  return ServiceRepository(Supabase.instance.client);
}

@riverpod
Future<List<ServiceModel>> activeServices(ActiveServicesRef ref) {
  return ref.watch(serviceRepositoryProvider).getActiveServices();
}
