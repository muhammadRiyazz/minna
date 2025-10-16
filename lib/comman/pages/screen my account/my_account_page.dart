import 'package:minna/comman/application/login/login_bloc.dart';
import 'package:minna/comman/const/const.dart';
import 'package:minna/comman/pages/log%20in/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minna/comman/pages/screen%20my%20account/about%20us.dart';
import 'package:minna/comman/pages/screen%20my%20account/contact%20us.dart';
import 'package:minna/comman/pages/screen%20my%20account/profile.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({super.key});

  @override
  State<MyAccountPage> createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  // Color Theme - Consistent with home page
  final Color _primaryColor = Colors.black;
  final Color _secondaryColor = Color(0xFFD4AF37); // Gold
  final Color _accentColor = Color(0xFFC19B3C); // Darker Gold
  final Color _backgroundColor = Color(0xFFF8F9FA);
  final Color _cardColor = Colors.white;
  final Color _textPrimary = Colors.black;
  final Color _textSecondary = Color(0xFF666666);
  final Color _textLight = Color(0xFF999999);

  @override
  void initState() {
    super.initState();
    context.read<LoginBloc>().add(const LoginEvent.loginInfo());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              // App Bar
              SliverAppBar(
                backgroundColor:_primaryColor ,
                expandedHeight: 120,
                floating: false,
                pinned: true,
                elevation: 4,
                shadowColor: Colors.black.withOpacity(0.3),
                surfaceTintColor: Colors.white,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    'My Account',
                    style: TextStyle(
                      color: 
                      Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  centerTitle: true,
                
                ),
                
              ),
      
              // Main Content
              SliverList(
                delegate: SliverChildListDelegate([
                  if (!(state.isLoggedIn ?? false)) ...[
                    _buildLoginSection(context),
                  ] else ...[
                    // _buildUserProfileSection(state),
                  ],
                  
                  
                  // Account Management
               state.isLoggedIn ?? false?   _buildSectionTitle('ACCOUNT MANAGEMENT'):SizedBox(),
               state.isLoggedIn ?? false?    _buildAccountOption(
                    Icons.person_outline_rounded,
                    'Profile Information',
                    'Update your personal details',
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfilePage()),
                      );
                    },
                  ):SizedBox
                  (),
                  // _buildAccountOption(
                  //   Icons.credit_card_rounded,
                  //   'Payment Methods',
                  //   'Manage your payment options',
                  //   () {
                  //     _showComingSoonBottomSheet(context, "Payment Methods");
                  //   },
                  // ),
                  // _buildAccountOption(
                  //   Icons.location_on_outlined,
                  //   'Saved Addresses',
                  //   'Your frequently used addresses',
                  //   () {
                  //     _showComingSoonBottomSheet(context, "Saved Addresses");
                  //   },
                  // ),
      
                  // // Booking & History
                  // _buildSectionTitle('BOOKINGS & HISTORY'),
                  // _buildAccountOption(
                  //   Icons.bookmark_border_rounded,
                  //   'My Bookings',
                  //   'View all your bookings',
                  //   () {
                  //     _showComingSoonBottomSheet(context, "My Bookings");
                  //   },
                  // ),
                  // _buildAccountOption(
                  //   Icons.history_rounded,
                  //   'Booking History',
                  //   'Past travel history',
                  //   () {
                  //     _showComingSoonBottomSheet(context, "Booking History");
                  //   },
                  // ),
                  // _buildAccountOption(
                  //   Icons.favorite_border_rounded,
                  //   'Wishlist',
                  //   'Saved destinations & deals',
                  //   () {
                  //     _showComingSoonBottomSheet(context, "Wishlist");
                  //   },
                  // ),
      
                  // Support & Information
                  _buildSectionTitle('SUPPORT & INFORMATION'),
                  // _buildAccountOption(
                  //   Icons.help_outline_rounded,
                  //   'Help Center',
                  //   'Get help with your bookings',
                  //   () {
                  //     _showComingSoonBottomSheet(context, "Help Center");
                  //   },
                  // ),
                  _buildAccountOption(
                    Icons.email_outlined,
                    'Contact Us',
                    'Reach out to our support team',
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ContactUsPage()),
                      );
                    },
                  ),
                  _buildAccountOption(
                    Icons.info_outline_rounded,
                    'About Us',
                    'Learn more about MT Trip',
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AboutUsPage()),
                      );
                    },
                  ),
                  // _buildAccountOption(
                  //   Icons.star_border_rounded,
                  //   'Rate Our App',
                  //   'Share your experience',
                  //   () {
                  //     _showComingSoonBottomSheet(context, "Rate Our App");
                  //   },
                  // ),
                  _buildAccountOption(
                    Icons.share_outlined,
                    'Share App',
                    'Invite friends to MT Trip',
                    () {
                      _showComingSoonBottomSheet(context, "Share App");
                    },
                  ),
      
                  // Legal
                  _buildSectionTitle('LEGAL'),
                  _buildAccountOption(
                    Icons.security_outlined,
                    'Privacy Policy',
                    'How we protect your data',
                    () {
                      _showComingSoonBottomSheet(context, "Privacy Policy");
                    },
                  ),
                  _buildAccountOption(
                    Icons.description_outlined,
                    'Terms of Service',
                    'Our terms and conditions',
                    () {
                      _showComingSoonBottomSheet(context, "Terms of Service");
                    },
                  ),
      
                  // Account Actions
                  if (state.isLoggedIn ?? false) ...[
                    _buildSectionTitle('ACCOUNT ACTIONS'),
                    // _buildAccountOption(
                    //   Icons.settings_outlined,
                    //   'Settings',
                    //   'App preferences and settings',
                    //   () {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(builder: (context) => AccountSettingsPage()),
                    //     );
                    //   },
                    // ),
                    _buildAccountOption(
                      Icons.logout_rounded,
                      'Logout',
                      'Sign out from your account',
                      () {
                        _showLogoutConfirmation(context);
                      },
                      isDestructive: true,
                    ),
                  ],
      
                  SizedBox(height: 30),
                ]),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildLoginSection(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [_primaryColor, Color(0xFF2D2D2D)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: _primaryColor.withOpacity(0.3),
            blurRadius: 15,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _secondaryColor.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.person_add_alt_1_rounded,
                  color: _secondaryColor,
                  size: 28,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Join MT Trip',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Unlock exclusive features and benefits',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          SizedBox(
            height: 50,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => LoginBottomSheet(login: 0),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _secondaryColor,
                foregroundColor: _primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.login_rounded, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Login / Sign Up',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 12),
          Center(
            child: Text(
              'Manage bookings & history',
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 12,
                height: 1.5,
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
          MaterialPageRoute(builder: (context) => ProfilePage()),
        );
      },
      child: Container(
        margin: EdgeInsets.all(16),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.black,
          // gradient: LinearGradient(
          //   colors: [_primaryColor, Color(0xFF2D2D2D)],
          //   begin: Alignment.topLeft,
          //   end: Alignment.bottomRight,
          // ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: _primaryColor.withOpacity(0.3),
              blurRadius: 15,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [_secondaryColor, _accentColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: _secondaryColor.withOpacity(0.3),
                    blurRadius: 8,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Icon(
                Icons.person_rounded,
                color: Colors.white,
                size: 28,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    state.userId ?? 'Welcome Back!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    state.phoneNumber ?? '',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                    ),
                  ),
                
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white,
                size: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildStatItem(String value, String label, IconData icon) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _secondaryColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: _secondaryColor, size: 18),
        ),
        SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            color: _primaryColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: _textSecondary,
            fontSize: 12,
          ),
        ),
      ],
    );
  }



  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 25, 20, 12),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: _textSecondary,
          letterSpacing: 1.5,
        ),
      ),
    );
  }

  Widget _buildAccountOption(
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap, {
    bool isDestructive = false,
  }) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.withOpacity(0.1)),
      ),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: isDestructive 
                ? Colors.red.withOpacity(0.1)
                : _secondaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: isDestructive ? Colors.red : _secondaryColor,
            size: 20,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: isDestructive ? Colors.red : _textPrimary,
            fontSize: 15,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: _textLight,
            fontSize: 12,
          ),
        ),
        trailing: Container(
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.arrow_forward_ios_rounded,
            color: _textLight,
            size: 14,
          ),
        ),
        onTap: onTap,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.logout_rounded,
                  color: Colors.red,
                  size: 32,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Logout?',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: _textPrimary,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Are you sure you want to logout from your account?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: _textSecondary,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: _textSecondary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12),
                        side: BorderSide(color: Colors.grey.shade300),
                      ),
                      child: Text('Cancel'),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<LoginBloc>().add(const LoginEvent.logout());
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Text('Logout'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showComingSoonBottomSheet(BuildContext context, String service) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _secondaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.construction_rounded,
                  color: _secondaryColor,
                  size: 40,
                ),
              ),
              SizedBox(height: 16),
              Text(
                '$service Coming Soon!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: _textPrimary,
                ),
              ),
              SizedBox(height: 12),
              Text(
                'We\'re working hard to bring you the best $service experience. Stay tuned for updates!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: _textSecondary,
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: Text(
                    'Got It!',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class AccountSettingsPage extends StatelessWidget {
  const AccountSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Color _primaryColor = Colors.black;
    final Color _secondaryColor = Color(0xFFD4AF37);

    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: _primaryColor,
        elevation: 0,
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 16),
        children: [
          _buildSettingSection('PREFERENCES', [
            _buildSettingTile(
              'Notification Settings',
              Icons.notifications_none_rounded,
              Colors.blue,
              'Manage your notification preferences',
            ),
            _buildSettingTile(
              'Privacy Settings',
              Icons.lock_outline_rounded,
              Colors.purple,
              'Control your privacy options',
            ),
            _buildSettingTile(
              'Language',
              Icons.language_rounded,
              Colors.green,
              'App language settings',
            ),
            _buildSettingTile(
              'Theme',
              Icons.color_lens_outlined,
              Colors.orange,
              'Dark/Light theme preferences',
            ),
          ]),
          _buildSettingSection('DATA & STORAGE', [
            _buildSettingTile(
              'Clear Cache',
              Icons.cleaning_services_rounded,
              Colors.blueGrey,
              'Free up storage space',
            ),
            _buildSettingTile(
              'Data Usage',
              Icons.data_usage_rounded,
              Colors.cyan,
              'Manage your data consumption',
            ),
          ]),
          _buildSettingSection('ACCOUNT', [
            _buildSettingTile(
              'Delete Account',
              Icons.delete_outline_rounded,
              Colors.red,
              'Permanently delete your account',
              isDestructive: true,
            ),
          ]),
        ],
      ),
    );
  }

  Widget _buildSettingSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(20, 25, 20, 12),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Colors.grey.shade600,
              letterSpacing: 1.5,
            ),
          ),
        ),
        ...children,
      ],
    );
  }

  Widget _buildSettingTile(
    String title,
    IconData icon,
    Color color,
    String subtitle, {
    bool isDestructive = false,
  }) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.withOpacity(0.1)),
      ),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: isDestructive ? Colors.red : Colors.black87,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
        ),
        trailing: Icon(Icons.chevron_right_rounded, color: Colors.grey.shade400),
        onTap: () {
          // Handle setting tap
        },
      ),
    );
  }
}