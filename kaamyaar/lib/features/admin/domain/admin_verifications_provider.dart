import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/supabase/supabase_provider.dart';
import 'worker_document_admin_model.dart';

part 'admin_verifications_provider.g.dart';

@riverpod
class PendingVerifications extends _$PendingVerifications {
  @override
  Future<List<WorkerDocumentAdminModel>> build() async {
    final supabase = ref.watch(supabaseClientProvider);
    
    final response = await supabase
        .from('worker_documents')
        .select('*, workers(users(full_name))')
        .eq('status', 'pending');
        
    return (response as List).map((json) => WorkerDocumentAdminModel.fromJson(json)).toList();
  }

  Future<void> updateStatus(String documentId, String newStatus) async {
    final supabase = ref.watch(supabaseClientProvider);
    
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
