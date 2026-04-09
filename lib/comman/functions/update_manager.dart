import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:in_app_update/in_app_update.dart';

class UpdateManager {
  /// Handles In-App Update errors gracefully, specifically focusing on code -10 (App not owned).
  static void _handleUpdateError(dynamic e, String context) {
    bool isAppNotOwned = false;
    
    // Pattern match for Code -10: Install Error (-10): The app is not owned by any user on this device.
    if (e is PlatformException) {
      if (e.code == 'TASK_FAILURE' && (e.message?.contains('-10') == true || e.details?.toString().contains('-10') == true)) {
        isAppNotOwned = true;
      }
    } else if (e.toString().contains('-10')) {
      isAppNotOwned = true;
    }

    if (isAppNotOwned) {
      if (kDebugMode) {
        log('[$context] In-App Update: App not owned (Code -10). This error is expected in debug/side-loaded builds and can be ignored during development.');
      } else {
        log('[$context] In-App Update: App not owned (-10). In-app updates are only available for apps installed through the Google Play Store.');
      }
    } else {
      log('[$context] Error: $e');
    }
  }

  static Future<void> checkForUpdate() async {
    log('Checking for updates...');
    try {
      final info = await InAppUpdate.checkForUpdate();
      if (info.updateAvailability == UpdateAvailability.updateAvailable) {
        log('Update available! version: ${info.availableVersionCode}');
        
        await InAppUpdate.performImmediateUpdate().catchError((e) {
          _handleUpdateError(e, 'Immediate Update');
        });
      } else {
        log('No update available.');
      }
    } catch (e) {
      _handleUpdateError(e, 'Check For Update');
    }
  }

  static Future<void> checkForFlexibleUpdate() async {
    log('Checking for flexible updates...');
    try {
      final info = await InAppUpdate.checkForUpdate();
      if (info.updateAvailability == UpdateAvailability.updateAvailable) {
        log('Flexible update available! version: ${info.availableVersionCode}');
        
        await InAppUpdate.startFlexibleUpdate().then((_) {
          InAppUpdate.completeFlexibleUpdate().then((_) {
            log('Flexible update completed.');
          });
        }).catchError((e) {
          _handleUpdateError(e, 'Flexible Update Start');
        });
      }
    } catch (e) {
      _handleUpdateError(e, 'Check For Flexible Update');
    }
  }
}
