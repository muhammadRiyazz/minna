import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:minna/comman/const/const.dart';

enum StatusType { success, error, warning, info }

class StatusBottomSheet extends StatelessWidget {
  final StatusType type;
  final String title;
  final String message;
  final String primaryButtonText;
  final VoidCallback? onPrimaryPressed;
  final bool showContactSupport;

  const StatusBottomSheet({
    super.key,
    required this.type,
    required this.title,
    required this.message,
    this.primaryButtonText = 'Understand',
    this.onPrimaryPressed,
    this.showContactSupport = false,
  });

  static Future<void> show({
    required BuildContext context,
    required StatusType type,
    required String title,
    required String message,
    String primaryButtonText = 'Understand',
    VoidCallback? onPrimaryPressed,
    bool showContactSupport = false,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatusBottomSheet(
        type: type,
        title: title,
        message: message,
        primaryButtonText: primaryButtonText,
        onPrimaryPressed: onPrimaryPressed,
        showContactSupport: showContactSupport,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color statusColor = _getStatusColor();
    final IconData statusIcon = _getStatusIcon();

    return Container(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
      decoration: const BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: textLight.withOpacity(0.3),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 32),

          // Icon Indicator
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              statusIcon,
              color: statusColor,
              size: 40,
            ),
          ),
          const SizedBox(height: 24),

          // Title
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: textPrimary,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 12),

          // Message
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: textSecondary,
              fontWeight: FontWeight.w500,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 32),

          // Actions
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: maincolor1,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
                if (onPrimaryPressed != null) onPrimaryPressed!();
              },
              child: Text(
                primaryButtonText.toUpperCase(),
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 14,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),

          if (showContactSupport) ...[
            const SizedBox(height: 12),
            TextButton(
              onPressed: () {
                // Handle contact support
                Navigator.pop(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Iconsax.headphone, size: 16, color: secondaryColor),
                  SizedBox(width: 8),
                  Text(
                    'Contact Support',
                    style: TextStyle(
                      color: secondaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Color _getStatusColor() {
    switch (type) {
      case StatusType.success:
        return successColor;
      case StatusType.error:
        return errorColor;
      case StatusType.warning:
        return warningColor;
      case StatusType.info:
        return maincolor1;
    }
  }

  IconData _getStatusIcon() {
    switch (type) {
      case StatusType.success:
        return Iconsax.tick_circle;
      case StatusType.error:
        return Iconsax.danger;
      case StatusType.warning:
        return Iconsax.warning_2;
      case StatusType.info:
        return Iconsax.info_circle;
    }
  }
}
