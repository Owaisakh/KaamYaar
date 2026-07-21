import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/admin_verifications_provider.dart';

class AdminVerificationsScreen extends ConsumerWidget {
  const AdminVerificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final verificationsAsync = ref.watch(pendingVerificationsProvider);

    return verificationsAsync.when(
      data: (verifications) {
        if (verifications.isEmpty) {
          return const Center(child: Text('No pending verifications.'));
        }
        return ListView.builder(
          itemCount: verifications.length,
          itemBuilder: (context, index) {
            final doc = verifications[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListTile(
                title: Text('Worker: ${doc.workerName ?? 'Unknown'}'),
                subtitle: Text('Doc Type: ${doc.documentType.toUpperCase()}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.check_circle, color: Colors.green),
                      tooltip: 'Approve',
                      onPressed: () {
                        ref
                            .read(pendingVerificationsProvider.notifier)
                            .updateStatus(doc.id, 'approved');
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.cancel, color: Colors.red),
                      tooltip: 'Reject',
                      onPressed: () {
                        ref
                            .read(pendingVerificationsProvider.notifier)
                            .updateStatus(doc.id, 'rejected');
                      },
                    ),
                  ],
                ),
                onTap: () {
                  // Show image preview
                  showDialog(
                    context: context,
                    builder: (context) => Dialog(
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Image.network(
                            doc.fileUrl,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) =>
                                const Padding(
                              padding: EdgeInsets.all(32.0),
                              child: Icon(Icons.broken_image, size: 64),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close, color: Colors.black54),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error: $err')),
    );
  }
}
