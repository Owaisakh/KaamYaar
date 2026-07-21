import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../bookings/domain/booking_model.dart';
import '../../../../core/theme/app_colors.dart';
import 'active_job_controller.dart';
import '../../../auth/data/auth_repository.dart';

class ActiveJobScreen extends ConsumerStatefulWidget {
  final BookingModel job;
  const ActiveJobScreen({super.key, required this.job});

  @override
  ConsumerState<ActiveJobScreen> createState() => _ActiveJobScreenState();
}

class _ActiveJobScreenState extends ConsumerState<ActiveJobScreen> {
  final _quoteController = TextEditingController();

  @override
  void dispose() {
    _quoteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final status = widget.job.status;
    final workerId = ref.watch(authRepositoryProvider).currentUser?.id ?? '';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Execution'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Status: ${status.toUpperCase()}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 16),
            Text('Problem: ${widget.job.problemDescription}'),
            const Spacer(),
            _buildActionButtons(status, workerId),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(String status, String workerId) {
    final controller = ref.read(activeJobControllerProvider.notifier);

    switch (status) {
      case 'accepted':
      case 'assigned':
        return ElevatedButton(
          onPressed: () {
            controller.updateJobStatus(widget.job.id, 'on_the_way');
            controller.startLocationBroadcast(workerId, widget.job.id);
          },
          child: const Text('Start Journey (On the way)'),
        );
      case 'on_the_way':
        return ElevatedButton(
          onPressed: () {
            controller.updateJobStatus(widget.job.id, 'arrived');
          },
          child: const Text('Mark Arrived'),
        );
      case 'arrived':
        return ElevatedButton(
          onPressed: () {
            controller.updateJobStatus(widget.job.id, 'inspect_problem');
          },
          child: const Text('Inspect Problem'),
        );
      case 'inspect_problem':
        return Column(
          children: [
            TextField(
              controller: _quoteController,
              decoration: const InputDecoration(
                labelText: 'Final Quote Amount',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final val = _quoteController.text;
                  if (val.isNotEmpty) {
                    // Update quote and status
                    // Assume repository has method to update final_price, for simplicity we just update status here
                    // In a real app we'd update final_price as well
                    controller.updateJobStatus(widget.job.id, 'quote_final_price');
                  }
                },
                child: const Text('Submit Quote'),
              ),
            ),
          ],
        );
      case 'quote_final_price':
        return const Center(child: Text('Waiting for customer approval...'));
      case 'customer_approves':
        return ElevatedButton(
          onPressed: () {
            controller.updateJobStatus(widget.job.id, 'in_progress');
          },
          child: const Text('Start Work (In Progress)'),
        );
      case 'in_progress':
        return ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.success),
          onPressed: () {
            controller.updateJobStatus(widget.job.id, 'completed', booking: widget.job);
          },
          child: const Text('Complete Job', style: TextStyle(color: Colors.white)),
        );
      case 'completed':
        return const Center(child: Text('Job Completed 🎉', style: TextStyle(color: AppColors.success, fontSize: 18, fontWeight: FontWeight.bold)));
      default:
        return const SizedBox.shrink();
    }
  }
}
