import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../bookings/data/service_repository.dart';
import '../../../bookings/domain/service_model.dart';

class ServiceSearchScreen extends ConsumerStatefulWidget {
  const ServiceSearchScreen({super.key});

  @override
  ConsumerState<ServiceSearchScreen> createState() => _ServiceSearchScreenState();
}

class _ServiceSearchScreenState extends ConsumerState<ServiceSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<ServiceModel> _searchResults = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Fetch all active services initially
    _performSearch('');
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _performSearch(String query) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final repo = ref.read(serviceRepositoryProvider);
      final results = await repo.searchServices(query);
      if (mounted) {
        setState(() {
          _searchResults = results;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error searching services: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'What do you need help with?',
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: const Icon(LucideIcons.x),
              onPressed: () {
                _searchController.clear();
                _performSearch('');
              },
            ),
          ),
          onChanged: (value) {
            // Debounce in a real app, but for MVP let's just search
            _performSearch(value);
          },
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _searchResults.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(LucideIcons.searchX, size: 64, color: theme.colorScheme.onSurfaceVariant.withOpacity(0.5)),
                      const SizedBox(height: 16),
                      Text(
                        'No services found',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _searchResults.length,
                  itemBuilder: (context, index) {
                    final service = _searchResults[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          color: theme.colorScheme.outlineVariant.withOpacity(0.5),
                        ),
                      ),
                      child: ListTile(
                        leading: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primaryContainer.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            _getIconForSlug(service.slug),
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        title: Text(service.name),
                        subtitle: Text(
                          service.description ?? 'Professional ${service.name} service',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: const Icon(LucideIcons.chevronRight),
                        onTap: () {
                          context.push('/book-service', extra: service);
                        },
                      ),
                    );
                  },
                ),
    );
  }

  IconData _getIconForSlug(String slug) {
    switch (slug) {
      case 'plumber': return LucideIcons.wrench;
      case 'electrician': return LucideIcons.zap;
      case 'ac_repair': return LucideIcons.snowflake;
      case 'cleaner': return LucideIcons.sparkles;
      case 'carpenter': return LucideIcons.hammer;
      case 'painter': return LucideIcons.paintbrush;
      default: return LucideIcons.tool;
    }
  }
}
