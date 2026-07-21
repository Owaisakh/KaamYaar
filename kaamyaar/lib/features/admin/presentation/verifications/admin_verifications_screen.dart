import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/admin_verifications_provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AdminVerificationsScreen extends ConsumerWidget {
  const AdminVerificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final verificationsAsync = ref.watch(pendingVerificationsProvider);

    return verificationsAsync.when(
      data: (verifications) {
        if (verifications.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.verified_user_outlined, size: 64, color: Colors.grey[400]),
                const SizedBox(height: 16),
                Text('No pending verifications.',
                    style: TextStyle(fontSize: 18, color: Colors.grey[600])),
              ],
            ),
          );
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
                          CachedNetworkImage(
                            imageUrl: doc.fileUrl,
                            fit: BoxFit.contain,
                            placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) => const Padding(
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
      loading: () => ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) => Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: const SizedBox(height: 72),
          ),
        ),
      ),
      error: (err, stack) => Center(child: Text('Error: $err')),
    );
  }
}
