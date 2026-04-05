import 'dart:developer';
import 'package:in_app_update/in_app_update.dart';

class UpdateManager {
  static Future<void> checkForUpdate() async {
    log('Checking for updates...');
    try {
      final info = await InAppUpdate.checkForUpdate();
      if (info.updateAvailability == UpdateAvailability.updateAvailable) {
        log('Update available! version: ${info.availableVersionCode}');
        
        // You can choose between performImmediateUpdate() or showFlexibleUpdateDisplay()
        // Immediate update forces the user to update before continuing
        await InAppUpdate.performImmediateUpdate().catchError((e) {
          log('Error performing immediate update: $e');
        });
      } else {
        log('No update available.');
      }
    } catch (e) {
      log('Error checking for update: $e');
    }
  }

  static Future<void> checkForFlexibleUpdate() async {
    log('Checking for flexible updates...');
    try {
      final info = await InAppUpdate.checkForUpdate();
      if (info.updateAvailability == UpdateAvailability.updateAvailable) {
        log('Flexible update available! version: ${info.availableVersionCode}');
        
        await InAppUpdate.startFlexibleUpdate().then((_) {
          // After downloading, we need to complete the update
          InAppUpdate.completeFlexibleUpdate().then((_) {
            log('Flexible update completed.');
          });
        }).catchError((e) {
          log('Error starting flexible update: $e');
        });
      }
    } catch (e) {
      log('Error checking for flexible update: $e');
    }
  }
}
