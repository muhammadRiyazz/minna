import 'package:flutter/material.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({super.key});

  @override
  _ContactUsPageState createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  // Color Theme
  final Color _primaryColor = Colors.black;
  final Color _secondaryColor = Color(0xFFD4AF37);
  final Color _accentColor = Color(0xFFC19B3C);
  final Color _backgroundColor = Color(0xFFF8F9FA);
  final Color _cardColor = Colors.white;
  final Color _textPrimary = Colors.black;
  final Color _textSecondary = Color(0xFF666666);
  final Color _textLight = Color(0xFF999999);
  final Color _errorColor = Color(0xFFE53935);
  final Color _successColor = Color(0xFF00C853);

  final _formKey = GlobalKey<FormState>();
  bool _isSubmitting = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  final ScrollController _scrollController = ScrollController();
  bool _showAppBarTitle = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset > 100 && !_showAppBarTitle) {
        setState(() => _showAppBarTitle = true);
      } else if (_scrollController.offset <= 100 && _showAppBarTitle) {
        setState(() => _showAppBarTitle = false);
      }
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      setState(() => _isSubmitting = true);

      // Simulate sending message
      Future.delayed(Duration(seconds: 2), () {
        setState(() => _isSubmitting = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.check_circle, color: _cardColor),
                SizedBox(width: 10),
                Expanded(child: Text("Message sent successfully!")),
              ],
            ),
            backgroundColor: _successColor,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            duration: const Duration(seconds: 3),
          ),
        );
        _nameController.clear();
        _emailController.clear();
        _messageController.clear();
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            expandedHeight: 180.0,
            collapsedHeight: 70.0,
            pinned: true,
            snap: false,
            floating: false,
            backgroundColor: _primaryColor,
            elevation: 4,
            shadowColor: Colors.black.withOpacity(0.3),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: AnimatedOpacity(
                opacity: _showAppBarTitle ? 1.0 : 0.0,
                duration: Duration(milliseconds: 200),
                child: Text(
                  'Contact Us',
                  style: TextStyle(
                    color: _cardColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [_primaryColor, _primaryColor.withOpacity(0.9)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.contact_support_rounded,
                      size: 50,
                      color: _secondaryColor,
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Let's Connect",
                      style: TextStyle(
                        color: _cardColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Text(
                        "We're here to help and answer any questions",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: _cardColor.withOpacity(0.8),
                          fontSize: 14,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Contact Details Card
                  Container(
                    decoration: BoxDecoration(
                      color: _cardColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                      border: Border.all(
                        color: _secondaryColor.withOpacity(0.1),
                        width: 1,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: _secondaryColor.withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.contact_page_rounded,
                                  color: _secondaryColor,
                                  size: 20,
                                ),
                              ),
                              SizedBox(width: 12),
                              Text(
                                "Contact Information",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: _textPrimary,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          _buildContactItem(
                            Icons.email_rounded,
                            "Email Address",
                            "mttrip2025@gmail.com",
                            _secondaryColor,
                          ),
                          SizedBox(height: 16),
                          _buildContactItem(
                            Icons.phone_rounded,
                            "Phone Number",
                            "+91 9656666556",
                            _secondaryColor,
                          ),
                          // SizedBox(height: 16),
                          // _buildContactItem(
                          //   Icons.location_on_rounded,
                          //   "Office Address",
                          //   "123, Your Street, Your City, India",
                          //   _secondaryColor,
                          // ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 24),

                  // Contact Form Card
                  Container(
                    decoration: BoxDecoration(
                      color: _cardColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                      border: Border.all(
                        color: _secondaryColor.withOpacity(0.1),
                        width: 1,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: _secondaryColor.withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.message_rounded,
                                  color: _secondaryColor,
                                  size: 20,
                                ),
                              ),
                              SizedBox(width: 12),
                              Text(
                                "Send us a Message",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: _textPrimary,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                _buildFormField(
                                  controller: _nameController,
                                  label: "Full Name",
                                  hint: "Enter your full name",
                                  icon: Icons.person_outline_rounded,
                                  validator: (value) =>
                                      value!.isEmpty ? "Please enter your name" : null,
                                ),
                                SizedBox(height: 16),
                                _buildFormField(
                                  controller: _emailController,
                                  label: "Email Address",
                                  hint: "Enter your email address",
                                  icon: Icons.email_outlined,
                                  validator: (value) {
                                    if (value!.isEmpty) return "Please enter your email";
                                    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                                      return "Please enter a valid email";
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 16),
                                _buildFormField(
                                  controller: _messageController,
                                  label: "Your Message",
                                  hint: "Tell us how we can help you...",
                                  icon: Icons.chat_bubble_outline_rounded,
                                  maxLines: 5,
                                  validator: (value) =>
                                      value!.isEmpty ? "Please enter a message" : null,
                                ),
                                SizedBox(height: 24),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: _isSubmitting ? null : _submitForm,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: _secondaryColor,
                                      foregroundColor: _cardColor,
                                      padding: EdgeInsets.symmetric(vertical: 16),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      elevation: 2,
                                      shadowColor: _secondaryColor.withOpacity(0.3),
                                    ),
                                    child: _isSubmitting
                                        ? SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              color: _cardColor,
                                            ),
                                          )
                                        : Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.send_rounded, size: 20),
                                              SizedBox(width: 8),
                                              Text(
                                                "Send Message",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String title, String subtitle, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _textLight.withOpacity(0.2)),
      ),
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: _textLight,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 14,
            color: _textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      ),
    );
  }

  Widget _buildFormField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required String? Function(String?) validator,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: _textPrimary,
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          validator: validator,
          style: TextStyle(
            color: _textPrimary,
            fontSize: 14,
          ),
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: _secondaryColor),
            hintText: hint,
            hintStyle: TextStyle(color: _textLight),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: _textLight.withOpacity(0.3)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: _textLight.withOpacity(0.3)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: _secondaryColor, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: _errorColor),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: _errorColor, width: 2),
            ),
            contentPadding:  EdgeInsets.symmetric(
              horizontal: 16,
              vertical: maxLines > 1 ? 16 : 0,
            ),
          ),
        ),
      ],
    );
  }
}