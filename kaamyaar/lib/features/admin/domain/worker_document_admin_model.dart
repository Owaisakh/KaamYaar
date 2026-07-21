import 'package:freezed_annotation/freezed_annotation.dart';

part 'worker_document_admin_model.freezed.dart';
part 'worker_document_admin_model.g.dart';

@freezed
abstract class WorkerDocumentAdminModel with _$WorkerDocumentAdminModel {
  const factory WorkerDocumentAdminModel({
    required String id,
    @JsonKey(name: 'worker_id') required String workerId,
    @JsonKey(name: 'document_type') required String documentType,
    @JsonKey(name: 'file_url') required String fileUrl,
    required String status,
    String? workerName,
  }) = _WorkerDocumentAdminModel;

  factory WorkerDocumentAdminModel.fromJson(Map<String, dynamic> json) {
    // Extract nested full_name from Supabase query if available
    String? name;
    if (json['workers'] != null && json['workers']['users'] != null) {
      name = json['workers']['users']['full_name'];
    }
    return _$WorkerDocumentAdminModelFromJson({
      ...json,
      'workerName': name,
    });
  }
}
