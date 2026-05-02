import 'package:flutter/material.dart';
import 'package:evently/theme/app_colors.dart';
import '../auth/login_screen.dart';
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
  Set<String> _favoriteEvents = {};

  final List<String> _categories = [
    'All',
    'Birthday',
    'Meeting',
    'Sport',
    'Book Club',
    'Exhibition',
  ];

  final List<Map<String, String>> _events = [
    {
      'date': '21 Jan',
      'title': 'Birthday',
      'description': 'This is a Birthday Party',
      'category': 'Birthday',
      'image': 'assets/images/Birthday.png',
    },
    {
      'date': '22 Jan',
      'title': 'Meeting',
      'description': 'Meeting for Updating The Development Method',
      'category': 'Meeting',
      'image': 'assets/images/Meeting.png',
    },
    {
      'date': '23 Jan',
      'title': 'Exhibition',
      'description': 'Art Exhibition',
      'category': 'Exhibition',
      'image': 'assets/images/Exhibition.png',
    },
    {
      'date': '24 Jan',
      'title': 'Sport',
      'description': 'Football Match',
      'category': 'Sport',
      'image': 'assets/images/Sport.png',
    },
    {
      'date': '25 Jan',
      'title': 'Book Club',
      'description': 'Book ClubMeeting',
      'category': 'Book Club',
      'image': 'assets/images/BookClub.png',
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() {
    // Using dummy user data
    setState(() {
      _userName = _userName ?? 'John Safwat';
      _userEmail = _userEmail ?? 'john.safwat@example.com';
    });
  }

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
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

  Widget _buildEventCard(Map<String, String> event) {
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
          image: event['image']!.isNotEmpty
              ? DecorationImage(
                  image: event['image']!.startsWith('assets/')
                      ? AssetImage(event['image']!)
                      : NetworkImage(event['image']!) as ImageProvider,
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
                      event['date']!,
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
                              event['description']!,
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
                            onTap: () {
                              setState(() {
                                if (_favoriteEvents.contains(event['title'])) {
                                  _favoriteEvents.remove(event['title']);
                                } else {
                                  _favoriteEvents.add(event['title']!);
                                }
                              });
                            },
                            child: Icon(
                              _favoriteEvents.contains(event['title'])
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
      // Favorites Page
      final favoriteEvents = _events
          .where((event) => _favoriteEvents.contains(event['title']))
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
                  child: _buildEventCard(event),
                );
              }),
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

            // Event Cards List
            Builder(
              builder: (context) {
                final filteredEvents = _selectedCategory == 'All'
                    ? _events
                    : _events
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
                      child: _buildEventCard(event),
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
                events: _events,
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
