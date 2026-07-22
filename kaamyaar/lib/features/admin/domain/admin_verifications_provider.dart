import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/supabase/supabase_config.dart';
import 'worker_document_admin_model.dart';

part 'admin_verifications_provider.g.dart';

@riverpod
class PendingVerifications extends _$PendingVerifications {
  @override
  Future<List<WorkerDocumentAdminModel>> build() async {
    final supabase = SupabaseConfig.client;
    
    final response = await supabase
        .from('worker_documents')
        .select('*, workers(users(full_name))')
        .eq('status', 'pending');
        
    return (response as List).map((json) {
      String? name;
      if (json['workers'] != null && json['workers']['users'] != null) {
        name = json['workers']['users']['full_name'];
      }
      return WorkerDocumentAdminModel.fromJson({
        ...json,
        'workerName': name,
      });
    }).toList();
  }

  Future<void> updateStatus(String documentId, String newStatus) async {
    final supabase = SupabaseConfig.client;
    
    await supabase
        .from('worker_documents')
        .update({'status': newStatus})
        .eq('id', documentId);
        
    // Also, if approved, we might need to check if all documents for the worker are approved
    // and then update the worker's `verification_status` to 'approved'.
    // For simplicity in this demo, let's just refresh the pending list.
    ref.invalidateSelf();
  }
}
