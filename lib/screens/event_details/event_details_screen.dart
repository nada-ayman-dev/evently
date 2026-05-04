import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:evently/theme/app_colors.dart';
import 'package:evently/services/firestore_service.dart';
import 'edit_event_screen.dart';

class EventDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> event;
  final VoidCallback? onEventDeleted;

  const EventDetailsScreen({
    super.key,
    required this.event,
    this.onEventDeleted,
  });

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  bool _isLoading = false;

  String _getImagePath(String category, BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    switch (category) {
      case 'Birthday':
        return isDarkMode
            ? 'assets/images/Birthdaydark.png'
            : 'assets/images/Birthday.png';
      case 'Meeting':
        return isDarkMode
            ? 'assets/images/Meetingdark.png'
            : 'assets/images/Meeting.png';
      case 'Sport':
        return isDarkMode
            ? 'assets/images/Sportdark.png'
            : 'assets/images/Sport.png';
      case 'Book Club':
        return isDarkMode
            ? 'assets/images/BookClubdark.png'
            : 'assets/images/BookClub.png';
      case 'Exhibition':
        return isDarkMode
            ? 'assets/images/Exhibitiondark.png'
            : 'assets/images/Exhibition.png';
      default:
        return isDarkMode
            ? 'assets/images/BookClubdark.png'
            : 'assets/images/BookClub.png';
    }
  }

  void _deleteEvent() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Event'),
        content: const Text('Are you sure you want to delete this event?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);

              setState(() => _isLoading = true);
              try {
                await _firestoreService.deleteEvent(widget.event['id']);
                if (mounted) {
                  // Call the callback to refresh HomeScreen
                  widget.onEventDeleted?.call();
                  await Future.delayed(const Duration(milliseconds: 500));
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Event deleted successfully')),
                  );
                }
              } catch (e) {
                if (mounted) {
                  setState(() => _isLoading = false);
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('Error: $e')));
                }
              }
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final event = widget.event;
    final imagePath = event['imagePath'] ?? 'assets/images/default.png';
    final title = event['title'] ?? 'Untitled Event';
    final category = event['category'] ?? 'Birthday';
    final date = event['date'] ?? 'N/A';
    final time = event['time'] ?? 'N/A';
    final description = event['description'] ?? '';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: SvgPicture.asset(
              'assets/icons/arrowleft.svg',
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
        title: const Text(
          'Event details',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
            fontFamily: 'Poppins',
          ),
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EditEventScreen(
                    event: event,
                    onEventUpdated: widget.onEventDeleted,
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SvgPicture.asset(
                'assets/icons/edit.svg',
                width: 20,
                height: 20,
                colorFilter: ColorFilter.mode(
                  AppColors.primary,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: _deleteEvent,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SvgPicture.asset(
                'assets/icons/trash.svg',
                width: 20,
                height: 20,
                colorFilter: const ColorFilter.mode(
                  Colors.red,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Category Image
              Container(
                width: double.infinity,
                height: 193,
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? const Color(0xFF2A2A2A)
                      : const Color(0xFFF4F7FF),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? const Color(0xFF457AED)
                        : const Color(0xFFF0F0F0),
                    width: 1,
                  ),
                ),
                child: Center(
                  child: Image.asset(
                    _getImagePath(category, context),
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.image_not_supported,
                            size: 48,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Image for $category',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Category Badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              const SizedBox(height: 16),

              // Event Title
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: 16),

              // Date and Time Container
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFF0F0F0)),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/calender.svg',
                      width: 20,
                      height: 20,
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).brightness == Brightness.dark
                            ? AppColors.darkButton
                            : AppColors.primary,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      date,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const SizedBox(width: 20),
                    SvgPicture.asset(
                      'assets/icons/clock.svg',
                      width: 20,
                      height: 20,
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).brightness == Brightness.dark
                            ? AppColors.darkButton
                            : AppColors.primary,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      time,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Description Section
              Text(
                'Description',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF4F7FF),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFF0F0F0)),
                ),
                child: Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[700],
                    fontFamily: 'Poppins',
                    height: 1.6,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
