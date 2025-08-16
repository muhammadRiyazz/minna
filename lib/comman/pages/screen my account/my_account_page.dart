import 'package:minna/comman/application/login/login_bloc.dart';
import 'package:minna/comman/const/const.dart';
import 'package:minna/comman/pages/log%20in/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:minna/comman/pages/screen%20my%20account/about%20us.dart';
import 'package:minna/comman/pages/screen%20my%20account/contact%20us.dart';
import 'package:minna/comman/pages/screen%20my%20account/profile.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({super.key});

  @override
  State<MyAccountPage> createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  @override
  void initState() {
    super.initState();
    // Check login status when the page loads
    context.read<LoginBloc>().add(const LoginEvent.loginInfo());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'My Account',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: maincolor1,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!(state.isLoggedIn ?? false)) ...[
                    // Show login section only if not logged in
                    _buildLoginSection(context),
                  ] else ...[
                    // Show user profile if logged in
                    _buildUserProfileSection(state),
                  ],
                  // _buildSectionTitle('ACCOUNT'),
                  // _buildAccountOption(
                  //   Icons.person_outline,
                  //   'Profile Information',
                  //   () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) {
                  //           return ProfilePage();
                  //         },
                  //       ),
                  //     );
                  //   },
                  // ),

                  // _buildAccountOption(
                  //   Icons.credit_card,
                  //   'Payment Methods',
                  //   () {},
                  // ),
                  // _buildAccountOption(
                  //   Icons.location_on_outlined,
                  //   'Saved Addresses',
                  //   () {},
                  // ),
                  _buildSectionTitle('BOOKINGS'),
                  _buildAccountOption(
                    Icons.calendar_today,
                    'My Bookings',
                    () {},
                  ),
                  _buildSectionTitle('ABOUT'),
                  _buildAccountOption(Icons.email_outlined, 'About Us', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return AboutUsPage();
                        },
                      ),
                    );
                  }),
                  _buildSectionTitle('SUPPORT'),
                  // _buildAccountOption(Icons.help_outline, 'Help Center', () {}),
                  _buildAccountOption(Icons.email_outlined, 'Contact Us', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ContactUsPage();
                        },
                      ),
                    );
                  }),

                  // _buildAccountOption(Icons.star_border, 'Rate Our App', () {}),
                  if (!(state.isLoggedIn ?? false)) ...[
                    // Show login section only if not logged in
                  ] else ...[
                    // Show user profile if logged in
                    _buildSectionTitle('ACTIONS'),

                    _buildAccountOption(Icons.logout, 'Logout', () {
                      _showLogoutConfirmation(context);
                    }, color: Colors.red),
                  ],

                  // _buildAccountOption(Icons.settings_outlined, 'Settings', () {
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => const AccountSettingsPage(),
                  //     ),
                  //   );
                  // }),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildLoginSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),
          const Text(
            'Log in to manage your\nAccount',
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 50,
            width: double.infinity,
            child: TextButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => LoginBottomSheet(login: 0),
                );
              },
              style: TextButton.styleFrom(
                backgroundColor: maincolor1,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: const Text(
                'Log in',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserProfileSection(LoginState state) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ProfilePage();
            },
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [maincolor1!, maincolor1!.withOpacity(0.8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: maincolor1!.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                // border: Border.all(color: Colors.white, width: 1),
              ),
              child: CircleAvatar(
                radius: 28,
                backgroundColor: Colors.white.withOpacity(0.3),
                child: Icon(Icons.person, size: 28, color: Colors.white),
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Profile Information',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  state.phoneNumber ?? '',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            Spacer(),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ProfilePage();
                    },
                  ),
                );
              },
              icon: Icon(Icons.navigate_next_rounded, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 25, 20, 10),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.grey.shade600,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildAccountOption(
    IconData icon,
    String title,
    VoidCallback onTap, {
    Color? color,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(icon, color: color ?? maincolor1),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: color ?? Colors.black87,
          ),
        ),
        trailing: Icon(Icons.chevron_right, color: Colors.grey.shade400),
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<LoginBloc>().add(const LoginEvent.logout());
              Navigator.pop(context);
            },
            child: Text('Logout', style: TextStyle(color: maincolor1)),
          ),
        ],
      ),
    );
  }
}

class AccountSettingsPage extends StatelessWidget {
  const AccountSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Settings'),
        backgroundColor: maincolor1,
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 15),
        children: [
          _buildSettingTile(
            context,
            'Notification Settings',
            Icons.notifications_none,
            Colors.blue,
          ),
          _buildSettingTile(
            context,
            'Privacy Settings',
            Icons.lock_outline,
            Colors.purple,
          ),
          _buildSettingTile(context, 'Language', Icons.language, Colors.green),
          _buildSettingTile(
            context,
            'Theme',
            Icons.color_lens_outlined,
            Colors.orange,
          ),
          const Divider(height: 30),
          _buildSettingTile(
            context,
            'Delete Account',
            Icons.delete_outline,
            Colors.red,
            showConfirmation: true,
            confirmationTitle: 'Delete Account',
            confirmationMessage:
                'This will permanently delete your account and all data. This action cannot be undone.',
            actionText: 'Delete',
          ),
        ],
      ),
    );
  }

  Widget _buildSettingTile(
    BuildContext context,
    String title,
    IconData icon,
    Color color, {
    bool showConfirmation = false,
    String confirmationTitle = '',
    String confirmationMessage = '',
    String actionText = '',
  }) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: color),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      trailing: Icon(Icons.chevron_right, color: Colors.grey.shade400),
      onTap: () {
        if (showConfirmation) {
          _showConfirmationDialog(
            context,
            confirmationTitle,
            confirmationMessage,
            actionText,
          );
        }
      },
    );
  }

  void _showConfirmationDialog(
    BuildContext context,
    String title,
    String message,
    String actionText,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Handle action
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('$actionText requested'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: Text(actionText, style: TextStyle(color: maincolor1)),
          ),
        ],
      ),
    );
  }
}
