// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'worker_document_admin_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WorkerDocumentAdminModel _$WorkerDocumentAdminModelFromJson(
  Map<String, dynamic> json,
) => _WorkerDocumentAdminModel(
  id: json['id'] as String,
  workerId: json['worker_id'] as String,
  documentType: json['document_type'] as String,
  fileUrl: json['file_url'] as String,
  status: json['status'] as String,
  workerName: json['workerName'] as String?,
);

Map<String, dynamic> _$WorkerDocumentAdminModelToJson(
  _WorkerDocumentAdminModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'worker_id': instance.workerId,
  'document_type': instance.documentType,
  'file_url': instance.fileUrl,
  'status': instance.status,
  'workerName': instance.workerName,
};
