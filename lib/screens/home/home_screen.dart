import 'package:flutter/material.dart';
import 'package:evently/theme/app_colors.dart';
import 'package:evently/services/firestore_service.dart';
import 'package:evently/main.dart';
import '../auth/login_screen.dart';
import '../event_details/event_details_screen.dart';
//import '../favorites/favorites_screen.dart';
import '../profile/profile_screen.dart';
import '../add_event/add_event_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _userName = 'John Safwat';
  String? _userEmail = 'john.safwat@example.com';
  String _selectedCategory = 'All';
  bool _isDarkMode = false;
  String _selectedLanguage = 'EN';
  int _selectedNavIndex = 0;
  final Set<String> _favoriteEvents = {};
  final FirestoreService _firestoreService = FirestoreService();

  final List<String> _categories = [
    'All',
    'Birthday',
    'Meeting',
    'Sport',
    'Book Club',
    'Exhibition',
  ];

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    try {
      final userProfile = await _firestoreService.getUserProfile();

      if (userProfile != null && mounted) {
        final name = userProfile['name'] as String? ?? 'User';
        final email = userProfile['email'] as String? ?? 'user@example.com';

        setState(() {
          _userName = name;
          _userEmail = email;
        });

        print('✅ User loaded: $name');
      } else if (mounted) {
        setState(() {
          _userName = 'User';
          _userEmail = 'user@example.com';
        });
        print('⚠️ No user profile found');
      }
    } catch (e) {
      print('❌ Error loading user: $e');
      if (mounted) {
        setState(() {
          _userName = 'User';
          _userEmail = 'user@example.com';
        });
      }
    }
  }

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
    final themeMode = _isDarkMode ? ThemeMode.dark : ThemeMode.light;
    MyApp.of(context)?.setThemeMode(themeMode);
  }

  void _toggleLanguage() {
    setState(() {
      _selectedLanguage = _selectedLanguage == 'EN' ? 'AR' : 'EN';
    });
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'All':
        return Icons.category;
      case 'Birthday':
        return Icons.cake;
      case 'Meeting':
        return Icons.people;
      case 'Sport':
        return Icons.directions_bike;
      case 'Book Club':
        return Icons.book;
      case 'Exhibition':
        return Icons.celebration;
      default:
        return Icons.event;
    }
  }

  Widget _buildEventCard(Map<String, dynamic> event) {
    return RepaintBoundary(
      child: Container(
        height: 193,
        width: 343,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFFF0F0F0),
            width: 1,
            strokeAlign: BorderSide.strokeAlignOutside,
          ),
          image: (event['imagePath'] ?? '').toString().isNotEmpty
              ? DecorationImage(
                  image:
                      (event['imagePath'] ?? '').toString().startsWith(
                        'assets/',
                      )
                      ? AssetImage((event['imagePath'] ?? '').toString())
                      : NetworkImage((event['imagePath'] ?? '').toString())
                            as ImageProvider,
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            //color: AppColors.primary.withOpacity(0.85),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 70,
                  height: 40,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4F7FF),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: const Color(0xFFF0F0F0),
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      (event['date'] ?? 'N/A').toString(),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF0E3A99),
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 327,
                      height: 58,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF4F7FF),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: const Color(0xFFF0F0F0),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              (event['description'] ?? '').toString(),
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF1C1C1C),
                                fontFamily: 'Poppins',
                                height: 1.0, // line-height: 100%
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () async {
                              final eventId = (event['id'] ?? event['title'])
                                  .toString();

                              try {
                                if (_favoriteEvents.contains(eventId)) {
                                  // Remove from favorites
                                  await _firestoreService.removeFavorite(
                                    eventId,
                                  );
                                  if (mounted) {
                                    setState(() {
                                      _favoriteEvents.remove(eventId);
                                    });
                                  }
                                } else {
                                  // Add to favorites
                                  await _firestoreService.addFavorite(eventId);
                                  if (mounted) {
                                    setState(() {
                                      _favoriteEvents.add(eventId);
                                    });
                                  }
                                }
                              } catch (e) {
                                if (mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Error: $e')),
                                  );
                                }
                              }
                            },
                            child: Icon(
                              _favoriteEvents.contains(
                                    (event['id'] ?? event['title']).toString(),
                                  )
                                  ? Icons.favorite
                                  : Icons.favorite_outline,
                              color: const Color(0xFF0E3A99),
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleLogout() async {
    try {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Logged out successfully')),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Logout failed: $e')));
      }
    }
  }

  Widget _buildPageBody() {
    if (_selectedNavIndex == 1) {
      // Favorites Page - From Firestore
      return StreamBuilder<List<Map<String, dynamic>>>(
        stream: _firestoreService.getUserEvents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final events = snapshot.data ?? [];
          final favoriteEvents = events
              .where((e) => _favoriteEvents.contains(e['id']))
              .toList();

          return favoriteEvents.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.favorite_outline,
                        size: 64,
                        color: Colors.grey[300],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No favorite events yet',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                )
              : ListView(
                  padding: const EdgeInsets.all(20),
                  children: List.generate(favoriteEvents.length, (index) {
                    final event = favoriteEvents[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => EventDetailsScreen(
                                event: event,
                                onEventDeleted: () {
                                  // StreamBuilder will automatically refresh
                                  setState(() {});
                                },
                              ),
                            ),
                          );
                        },
                        child: _buildEventCard(event),
                      ),
                    );
                  }),
                );
        },
      );
    }

    if (_selectedNavIndex == 2) {
      // Profile Page
      return ProfileScreen(
        userName: _userName,
        userEmail: _userEmail,
        isDarkMode: _isDarkMode,
        selectedLanguage: _selectedLanguage,
        onToggleTheme: _toggleTheme,
        onToggleLanguage: _toggleLanguage,
        onLogout: _handleLogout,
      );
    }

    // Home Page (default)
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),

            // Event Category Tabs
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final category = _categories[index];
                  final isSelected = _selectedCategory == category;

                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedCategory = category;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.primary : Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          border: isSelected
                              ? null
                              : Border.all(color: const Color(0xFFF0F0F0)),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                _getCategoryIcon(category),
                                size: 16,
                                weight: 22,
                                color: isSelected
                                    ? Colors.white
                                    : const Color(0xFF0E3A99),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                category,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.black,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),

            // Events Section
            Text(
              'Upcoming Events',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 16),

            // Event Cards List - From Firestore
            StreamBuilder<List<Map<String, dynamic>>>(
              stream: _firestoreService.getUserEvents(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.primary,
                      ),
                    ),
                  );
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                final events = snapshot.data ?? [];

                if (events.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.event_note,
                          size: 64,
                          color: Colors.grey[300],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No events yet. Create one!',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                  );
                }

                final filteredEvents = _selectedCategory == 'All'
                    ? events
                    : events
                          .where(
                            (event) => event['category'] == _selectedCategory,
                          )
                          .toList();

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: filteredEvents.length,
                  itemBuilder: (context, index) {
                    final event = filteredEvents[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => EventDetailsScreen(
                                event: event,
                                onEventDeleted: () {
                                  // StreamBuilder will automatically refresh
                                  setState(() {});
                                },
                              ),
                            ),
                          );
                        },
                        child: _buildEventCard(event),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome Back ✨',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      fontFamily: 'Poppins',
                    ),
                  ),
                  Text(
                    _userName ?? 'User',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: _toggleTheme,
                  child: Container(
                    width: 34,
                    height: 32,
                    padding: const EdgeInsets.only(
                      top: 4,
                      right: 8,
                      bottom: 4,
                      left: 8,
                    ),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      _isDarkMode ? Icons.dark_mode : Icons.light_mode,
                      size: 18,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: _toggleLanguage,
                  child: Container(
                    width: 34,
                    height: 32,
                    padding: const EdgeInsets.only(
                      top: 4,
                      right: 8,
                      bottom: 4,
                      left: 8,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0E3A99),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        _selectedLanguage,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: _buildPageBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedNavIndex,
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.grey[400],
        onTap: (index) {
          setState(() {
            _selectedNavIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddEventScreen(
                categories: _categories,
                events: [],
                onEventAdded: () {
                  setState(() {});
                },
              ),
            ),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
