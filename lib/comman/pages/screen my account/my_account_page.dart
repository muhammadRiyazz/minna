import 'package:minna/comman/application/login/login_bloc.dart';
import 'package:minna/comman/const/const.dart';
import 'package:minna/comman/pages/log%20in/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:minna/comman/pages/screen%20my%20account/about%20us.dart';
import 'package:minna/comman/pages/screen%20my%20account/contact%20us.dart';
import 'package:minna/comman/pages/screen%20my%20account/profile.dart';
import 'package:url_launcher/url_launcher.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({super.key});

  @override
  State<MyAccountPage> createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  @override
  void initState() {
    super.initState();
    context.read<LoginBloc>().add(const LoginEvent.loginInfo());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          final isLoggedIn = state.isLoggedIn ?? false;
          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // 1. Premium Immersive Header
              SliverAppBar(
                expandedHeight: isLoggedIn ? 260.0 : 180.0,
                floating: false,
                pinned: true,
                backgroundColor: maincolor1,
                elevation: 0,
                leading: const SizedBox.shrink(),
                flexibleSpace: FlexibleSpaceBar(
                  expandedTitleScale: 1.2,
                  centerTitle: true,
                  title: !isLoggedIn
                      ? const Text(
                          'MY ACCOUNT',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 2,
                          ),
                        )
                      : null,
                  background: Stack(
                    children: [
                      // Atmospheric Background
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [maincolor1, maincolor1.withOpacity(0.85)],
                          ),
                        ),
                      ),
                      // Decorative Elements
                      Positioned(
                        top: -50,
                        right: -50,
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.03),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: -20,
                        child: Icon(
                          Iconsax.user_square,
                          size: 180,
                          color: Colors.white.withOpacity(0.04),
                        ),
                      ),
                      // Profile Info (Only when logged in)
                      if (isLoggedIn)
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 40),
                              _buildModernAvatar(state),
                              const SizedBox(height: 16),
                              Text(
                                state.isLoggedIn == true
                                    ? 'Verified Member'
                                    : 'Explorer',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.6),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                state.phoneNumber ?? 'Unknown User',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: -0.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              // 2. Main Menu Sections
              SliverToBoxAdapter(
                child: Transform.translate(
                  offset: const Offset(0, -20),
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      child: Column(
                        children: [
                          if (!isLoggedIn) ...[
                            const SizedBox(height: 15),

                            _buildLoginBanner(context),
                            // const SizedBox(height: 5),
                          ],

                          // Group 1: Account Settings
                          if (isLoggedIn)
                            _buildMenuCard(
                              title: 'ACCOUNT SETTINGS',
                              items: [
                                _buildMenuTile(
                                  icon: Iconsax.user_edit,
                                  color: Colors.blue,
                                  title: 'Profile Information',
                                  subtitle: 'Update your personal details',
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const ProfilePage(),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                          // Group 2: Support & Info
                          _buildMenuCard(
                            title: 'SUPPORT & INFORMATION',
                            items: [
                              _buildMenuTile(
                                icon: Iconsax.sms,
                                color: Colors.indigo,
                                title: 'Contact Us',
                                subtitle: 'Reach out to our support team',
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ContactUsPage(),
                                  ),
                                ),
                              ),
                              _buildMenuTile(
                                icon: Iconsax.info_circle,
                                color: Colors.teal,
                                title: 'About MT Trip',
                                subtitle: 'Learn more about our mission',
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const AboutUsPage(),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // Group 3: Legal
                          _buildMenuCard(
                            title: 'LEGAL & POLICY',
                            items: [
                              _buildMenuTile(
                                icon: Iconsax.security_safe,
                                color: Colors.purple,
                                title: 'Privacy Policy',
                                subtitle: 'How we protect your data',
                                onTap: () => _launchURL(
                                  'https://mttrip.in/privacy-policy',
                                ),
                              ),
                              _buildMenuTile(
                                icon: Iconsax.document_text,
                                color: Colors.orange,
                                title: 'Terms of Service',
                                subtitle: 'Our usage terms and conditions',
                                onTap: () => _launchURL(
                                  'https://mttrip.in/terms-and-conditions',
                                ),
                              ),
                            ],
                          ),

                          // Group 4: App Actions
                          if (isLoggedIn)
                            _buildMenuCard(
                              title: 'APP ACTIONS',
                              items: [
                                _buildMenuTile(
                                  icon: Iconsax.logout,
                                  color: Colors.red,
                                  title: 'Logout',
                                  subtitle: 'Safely sign out of your account',
                                  onTap: () => _showLogoutConfirmation(context),
                                  isDestructive: true,
                                ),
                              ],
                            ),

                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildModernAvatar(LoginState state) {
    return Container(
      width: 90,
      height: 90,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(0.1),
        border: Border.all(color: Colors.white.withOpacity(0.3), width: 4),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: const Center(
        child: Icon(Iconsax.user, color: Colors.white, size: 40),
      ),
    );
  }

  Widget _buildLoginBanner(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: borderSoft, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 25,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // 1. Header Section with Badge
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 25, 25, 20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: secondaryColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Iconsax.user_tag,
                    color: secondaryColor,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Join MT Trip',
                        style: TextStyle(
                          color: textPrimary,
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -0.5,
                        ),
                      ),
                      Text(
                        'Unlock a world of travel privileges',
                        style: TextStyle(
                          color: textSecondary,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 3. CTA Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => const LoginBottomSheet(login: 0),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: maincolor1,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Iconsax.login_1, size: 20),
                    SizedBox(width: 12),
                    Text(
                      'LOG IN / SIGN UP',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 15,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 15),
        ],
      ),
    );
  }

  Widget _buildBenefitItem(IconData icon, String text) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: maincolor1.withOpacity(0.05),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 14, color: maincolor1.withOpacity(0.6)),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: textPrimary.withOpacity(0.8),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuCard({required String title, required List<Widget> items}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 12, top: 24),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w900,
              color: textLight.withOpacity(0.8),
              letterSpacing: 1.5,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: borderSoft),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            children: items.asMap().entries.map((entry) {
              final idx = entry.key;
              final widget = entry.value;
              return Column(
                children: [
                  widget,
                  if (idx != items.length - 1)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Divider(color: borderSoft, height: 1),
                    ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuTile({
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: isDestructive
                      ? Colors.red.withOpacity(0.1)
                      : color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: Icon(
                    icon,
                    color: isDestructive ? Colors.red : color,
                    size: 24,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: isDestructive ? Colors.red : textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: textLight,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Iconsax.arrow_right_3,
                size: 16,
                color: textLight.withOpacity(0.4),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url)) {
      debugPrint('Could not launch $url');
    }
  }

  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Iconsax.logout, color: Colors.red, size: 32),
              ),
              const SizedBox(height: 20),
              const Text(
                'LOGOUT?',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Are you sure you want to sign out from your account?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: textLight,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        'CANCEL',
                        style: TextStyle(
                          color: textLight,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<LoginBloc>().add(
                          const LoginEvent.logout(),
                        );
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        'LOGOUT',
                        style: TextStyle(fontWeight: FontWeight.w900),
                      ),
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
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(30),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: secondaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Iconsax.status_up,
                  color: secondaryColor,
                  size: 40,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                '$service Coming Soon!',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'We\'re working hard to bring you the best $service experience. Stay tuned for updates!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: textLight,
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: maincolor1,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
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
    final Color primaryColor = Colors.black;
    final Color secondaryColor = Color(0xFFD4AF37);

    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        backgroundColor: primaryColor,
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
        trailing: Icon(
          Icons.chevron_right_rounded,
          color: Colors.grey.shade400,
        ),
        onTap: () {
          // Handle setting tap
        },
      ),
    );
  }
}
