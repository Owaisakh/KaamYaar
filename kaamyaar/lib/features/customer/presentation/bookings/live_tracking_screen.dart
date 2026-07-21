import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../bookings/domain/booking_model.dart';
import '../../../bookings/data/booking_repository.dart';
import '../../../../core/theme/app_colors.dart';

class LiveTrackingScreen extends ConsumerWidget {
  final String bookingId;
  const LiveTrackingScreen({super.key, required this.bookingId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookingStream = ref.watch(bookingRepositoryProvider).watchBooking(bookingId);
    final locationStream = ref.watch(bookingRepositoryProvider).watchWorkerLocation(bookingId);

    return Scaffold(
      appBar: AppBar(title: const Text('Live Tracking')),
      body: StreamBuilder<BookingModel>(
        stream: bookingStream,
        builder: (context, bookingSnapshot) {
          if (!bookingSnapshot.hasData) return const Center(child: CircularProgressIndicator());
          final booking = bookingSnapshot.data!;

          return StreamBuilder<Map<String, dynamic>>(
            stream: locationStream,
            builder: (context, locationSnapshot) {
              final locData = locationSnapshot.data ?? {};
              final hasLocation = locData.containsKey('latitude') && locData.containsKey('longitude');
              
              LatLng? workerPos;
              if (hasLocation) {
                workerPos = LatLng(
                  (locData['latitude'] as num).toDouble(),
                  (locData['longitude'] as num).toDouble()
                );
              }

              return Column(
                children: [
                  Expanded(
                    child: workerPos == null
                        ? const Center(child: Text('Waiting for worker location...'))
                        : GoogleMap(
                            initialCameraPosition: CameraPosition(
                              target: workerPos,
                              zoom: 15,
                            ),
                            markers: {
                              Marker(
                                markerId: const MarkerId('worker'),
                                position: workerPos,
                                icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
                                infoWindow: const InfoWindow(title: 'Worker Location'),
                              )
                            },
                          ),
                  ),
                  _buildStatusPanel(context, ref, booking),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildStatusPanel(BuildContext context, WidgetRef ref, BookingModel booking) {
    final status = booking.status;
    
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, -4),
            blurRadius: 10,
          )
        ],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Status: ${status.toUpperCase()}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 8),
          _getStatusDescription(status),
          const SizedBox(height: 16),
          if (status == 'quote_final_price')
            ElevatedButton(
              onPressed: () {
                // Customer approves the quote
                ref.read(bookingRepositoryProvider).updateBookingStatus(booking.id, 'customer_approves');
              },
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
              child: const Text('Approve Quote', style: TextStyle(color: Colors.white)),
            ),
        ],
      ),
    );
  }

  Widget _getStatusDescription(String status) {
    switch (status) {
      case 'on_the_way': return const Text('Worker is on their way to your location.');
      case 'arrived': return const Text('Worker has arrived and is preparing to inspect.');
      case 'inspect_problem': return const Text('Worker is inspecting the problem to give a final quote.');
      case 'quote_final_price': return const Text('Worker has provided a final quote. Please approve to start work.');
      case 'in_progress': return const Text('Worker is currently fixing the problem.');
      case 'completed': return const Text('Job is completed successfully!', style: TextStyle(color: AppColors.success, fontWeight: FontWeight.bold));
      default: return Text('Current status: $status');
    }
  }
}
