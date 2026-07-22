import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../bookings/domain/booking_model.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/kaamyaar_card.dart';
import '../../../../core/widgets/kaamyaar_button.dart';
import '../../../../core/widgets/kaamyaar_badge.dart';
import 'active_job_controller.dart';
import '../../../../core/supabase/auth_provider.dart';

class ActiveJobScreen extends ConsumerStatefulWidget {
  final BookingModel job;
  const ActiveJobScreen({super.key, required this.job});

  @override
  ConsumerState<ActiveJobScreen> createState() => _ActiveJobScreenState();
}

class _ActiveJobScreenState extends ConsumerState<ActiveJobScreen> {
  final _quoteController = TextEditingController();

  final List<Map<String, String>> _jobSteps = const [
    {'status': 'accepted', 'label': 'Accepted'},
    {'status': 'on_the_way', 'label': 'On The Way'},
    {'status': 'arrived', 'label': 'Arrived'},
    {'status': 'inspect_problem', 'label': 'Inspect'},
    {'status': 'in_progress', 'label': 'In Progress'},
    {'status': 'completed', 'label': 'Completed'},
  ];

  int _getCurrentStepIndex(String status) {
    switch (status) {
      case 'accepted':
      case 'assigned': return 0;
      case 'on_the_way': return 1;
      case 'arrived': return 2;
      case 'inspect_problem':
      case 'quote_final_price':
      case 'customer_approves': return 3;
      case 'in_progress': return 4;
      case 'completed': return 5;
      default: return 0;
    }
  }

  @override
  void dispose() {
    _quoteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final status = widget.job.status;
    final workerId = ref.watch(authProvider).value?.id ?? '';
    final currentStepIndex = _getCurrentStepIndex(status);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('Active Job Progress'),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 6-Stage Progress Stepper Bar
              KaamYaarCard(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(_jobSteps.length, (index) {
                        final isDone = index <= currentStepIndex;
                        return Column(
                          children: [
                            Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                color: isDone ? AppColors.workerPrimary : const Color(0xFFE2E8F0),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                isDone ? Icons.check_rounded : Icons.circle_outlined,
                                size: 16,
                                color: isDone ? Colors.white : const Color(0xFF94A3B8),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              _jobSteps[index]['label']!,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: isDone ? FontWeight.bold : FontWeight.normal,
                                color: isDone ? AppColors.workerSecondary : const Color(0xFF94A3B8),
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Customer & Job Info Card
              KaamYaarCard(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Customer Request', style: TextStyle(fontSize: 14, color: AppColors.textSecondaryLight, fontWeight: FontWeight.bold)),
                        KaamYaarBadge(label: status.replaceAll('_', ' ').toUpperCase(), type: KaamYaarBadgeType.info),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      widget.job.problemDescription,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.workerSecondary),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: const [
                        Icon(Icons.location_on_rounded, color: AppColors.workerPrimary, size: 18),
                        SizedBox(width: 6),
                        Text('House 123, DHA Phase 2, Lahore (1.2 km away)', style: TextStyle(color: AppColors.textSecondaryLight, fontSize: 13)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Quick Contact Action Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.call_rounded, color: AppColors.workerSecondary),
                      label: const Text('Call Customer', style: TextStyle(color: AppColors.workerSecondary, fontWeight: FontWeight.bold)),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.all(14),
                        side: const BorderSide(color: AppColors.borderLight),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => context.push('/chat', extra: widget.job.id),
                      icon: const Icon(Icons.chat_rounded, color: AppColors.workerPrimary),
                      label: const Text('Chat', style: TextStyle(color: AppColors.workerPrimary, fontWeight: FontWeight.bold)),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.all(14),
                        side: const BorderSide(color: AppColors.workerPrimary),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),

              // Dynamic Execution Button
              _buildActionButtons(status, workerId),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons(String status, String workerId) {
    final controller = ref.read(activeJobControllerProvider.notifier);

    switch (status) {
      case 'accepted':
      case 'assigned':
        return KaamYaarButton(
          label: 'Start Journey (On The Way)',
          type: KaamYaarButtonType.secondary,
          onPressed: () {
            controller.updateJobStatus(widget.job.id, 'on_the_way');
            controller.startLocationBroadcast(workerId, widget.job.id);
          },
        );
      case 'on_the_way':
        return KaamYaarButton(
          label: 'I Have Arrived at Location',
          type: KaamYaarButtonType.secondary,
          onPressed: () {
            controller.updateJobStatus(widget.job.id, 'arrived');
          },
        );
      case 'arrived':
        return KaamYaarButton(
          label: 'Start Problem Inspection',
          type: KaamYaarButtonType.secondary,
          onPressed: () {
            controller.updateJobStatus(widget.job.id, 'inspect_problem');
          },
        );
      case 'inspect_problem':
        return Column(
          children: [
            TextField(
              controller: _quoteController,
              decoration: const InputDecoration(
                labelText: 'Enter Final Price Quote (Rs.)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.payments_rounded, color: AppColors.workerPrimary),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 14),
            KaamYaarButton(
              label: 'Submit Quote to Customer',
              type: KaamYaarButtonType.secondary,
              onPressed: () {
                final val = _quoteController.text;
                if (val.isNotEmpty) {
                  controller.updateJobStatus(widget.job.id, 'quote_final_price');
                }
              },
            ),
          ],
        );
      case 'quote_final_price':
        return const KaamYaarCard(
          backgroundColor: Color(0xFFFEF3C7),
          child: Center(
            child: Text('Waiting for customer to approve quote...', style: TextStyle(color: Color(0xFFD97706), fontWeight: FontWeight.bold)),
          ),
        );
      case 'customer_approves':
        return KaamYaarButton(
          label: 'Start Work (In Progress)',
          type: KaamYaarButtonType.secondary,
          onPressed: () {
            controller.updateJobStatus(widget.job.id, 'in_progress');
          },
        );
      case 'in_progress':
        return KaamYaarButton(
          label: 'Complete Job & Collect Payment',
          type: KaamYaarButtonType.primary,
          onPressed: () {
            controller.updateJobStatus(widget.job.id, 'completed', booking: widget.job);
          },
        );
      case 'completed':
        return const KaamYaarCard(
          backgroundColor: Color(0xFFECFDF5),
          child: Center(
            child: Text('Job Completed Successfully! 🎉', style: TextStyle(color: AppColors.success, fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        );
      default:
        return const SizedBox.shrink();
    }
  }
}

