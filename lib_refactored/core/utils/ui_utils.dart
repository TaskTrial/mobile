import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

class UiUtils {
  // Show success snackbar
  static void showSuccessSnackBar({
    required String title,
    required String message,
    SnackPosition position = SnackPosition.TOP,
    Duration duration = const Duration(seconds: 4),
  }) {
    Get.snackbar(
      title,
      message,
      colorText: Colors.white,
      backgroundColor: Colors.transparent,
      icon: const Icon(Icons.check_circle, color: Colors.white),
      titleText: Text(
        title,
        style: AppTextStyles.h6.copyWith(color: Colors.white),
      ),
      messageText: Text(
        message,
        style: AppTextStyles.bodyMedium.copyWith(color: Colors.white),
      ),
      margin: const EdgeInsets.all(20),
      borderRadius: 10,
      backgroundGradient: const LinearGradient(
        colors: AppColors.successGradient,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      duration: duration,
      snackPosition: position,
      reverseAnimationCurve: Curves.easeInOut,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
    );
  }
  
  // Show error snackbar
  static void showErrorSnackBar({
    required String title,
    required String message,
    SnackPosition position = SnackPosition.TOP,
    Duration duration = const Duration(seconds: 4),
  }) {
    Get.snackbar(
      title,
      message,
      colorText: Colors.white,
      backgroundColor: Colors.transparent,
      icon: const Icon(Icons.error, color: Colors.white),
      titleText: Text(
        title,
        style: AppTextStyles.h6.copyWith(color: Colors.white),
      ),
      messageText: Text(
        message,
        style: AppTextStyles.bodyMedium.copyWith(color: Colors.white),
      ),
      margin: const EdgeInsets.all(20),
      borderRadius: 10,
      backgroundGradient: const LinearGradient(
        colors: AppColors.errorGradient,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      duration: duration,
      snackPosition: position,
      reverseAnimationCurve: Curves.easeInOut,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
    );
  }
  
  // Show warning snackbar
  static void showWarningSnackBar({
    required String title,
    required String message,
    SnackPosition position = SnackPosition.TOP,
    Duration duration = const Duration(seconds: 4),
  }) {
    Get.snackbar(
      title,
      message,
      colorText: Colors.white,
      backgroundColor: Colors.transparent,
      icon: const Icon(Icons.warning, color: Colors.white),
      titleText: Text(
        title,
        style: AppTextStyles.h6.copyWith(color: Colors.white),
      ),
      messageText: Text(
        message,
        style: AppTextStyles.bodyMedium.copyWith(color: Colors.white),
      ),
      margin: const EdgeInsets.all(20),
      borderRadius: 10,
      backgroundGradient: const LinearGradient(
        colors: [AppColors.warning, AppColors.warning],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      duration: duration,
      snackPosition: position,
      reverseAnimationCurve: Curves.easeInOut,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
    );
  }
  
  // Show info snackbar
  static void showInfoSnackBar({
    required String title,
    required String message,
    SnackPosition position = SnackPosition.TOP,
    Duration duration = const Duration(seconds: 4),
  }) {
    Get.snackbar(
      title,
      message,
      colorText: Colors.white,
      backgroundColor: Colors.transparent,
      icon: const Icon(Icons.info, color: Colors.white),
      titleText: Text(
        title,
        style: AppTextStyles.h6.copyWith(color: Colors.white),
      ),
      messageText: Text(
        message,
        style: AppTextStyles.bodyMedium.copyWith(color: Colors.white),
      ),
      margin: const EdgeInsets.all(20),
      borderRadius: 10,
      backgroundGradient: const LinearGradient(
        colors: [AppColors.info, AppColors.info],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      duration: duration,
      snackPosition: position,
      reverseAnimationCurve: Curves.easeInOut,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
    );
  }
  
  // Show confirmation dialog
  static Future<bool> showConfirmationDialog({
    required String title,
    required String message,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    Color confirmColor = AppColors.primary,
    Color cancelColor = AppColors.textSecondary,
  }) async {
    final result = await Get.dialog<bool>(
      AlertDialog(
        title: Text(title, style: AppTextStyles.h5),
        content: Text(message, style: AppTextStyles.bodyMedium),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: Text(
              cancelText,
              style: AppTextStyles.buttonMedium.copyWith(color: cancelColor),
            ),
          ),
          ElevatedButton(
            onPressed: () => Get.back(result: true),
            style: ElevatedButton.styleFrom(
              backgroundColor: confirmColor,
              foregroundColor: Colors.white,
            ),
            child: Text(confirmText, style: AppTextStyles.buttonMedium),
          ),
        ],
      ),
      barrierDismissible: false,
    );
    
    return result ?? false;
  }
  
  // Show loading dialog
  static void showLoadingDialog({
    String message = 'Loading...',
    bool barrierDismissible = false,
  }) {
    Get.dialog(
      WillPopScope(
        onWillPop: () async => barrierDismissible,
        child: AlertDialog(
          content: Row(
            children: [
              const CircularProgressIndicator(),
              const SizedBox(width: 20),
              Expanded(
                child: Text(
                  message,
                  style: AppTextStyles.bodyMedium,
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: barrierDismissible,
    );
  }
  
  // Hide loading dialog
  static void hideLoadingDialog() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }
  
  // Show bottom sheet
  static Future<T?> showBottomSheet<T>({
    required Widget child,
    bool isScrollControlled = false,
    bool isDismissible = true,
    bool enableDrag = true,
    Color backgroundColor = Colors.white,
    double? elevation,
    ShapeBorder? shape,
    Clip? clipBehavior,
  }) {
    return Get.bottomSheet<T>(
      child,
      isScrollControlled: isScrollControlled,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      backgroundColor: backgroundColor,
      elevation: elevation,
      shape: shape,
      clipBehavior: clipBehavior,
    );
  }
  
  // Show modal bottom sheet
  static Future<T?> showModalBottomSheet<T>({
    required Widget child,
    bool isScrollControlled = false,
    bool isDismissible = true,
    bool enableDrag = true,
    Color backgroundColor = Colors.white,
    double? elevation,
    ShapeBorder? shape,
    Clip? clipBehavior,
  }) {
    return Get.bottomSheet<T>(
      child,
      isScrollControlled: isScrollControlled,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      backgroundColor: backgroundColor,
      elevation: elevation,
      shape: shape,
      clipBehavior: clipBehavior,
    );
  }
  
  // Show custom dialog
  static Future<T?> showCustomDialog<T>({
    required Widget child,
    bool barrierDismissible = true,
    Color barrierColor = Colors.black54,
  }) {
    return Get.dialog<T>(
      child,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
    );
  }
  
  // Show date picker
  static Future<DateTime?> showDatePicker({
    required BuildContext context,
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
    DatePickerEntryMode initialEntryMode = DatePickerEntryMode.calendar,
    SelectableDayPredicate? selectableDayPredicate,
    String? helpText,
    String? cancelText,
    String? confirmText,
    String? errorFormatText,
    String? errorInvalidText,
    String? fieldHintText,
    String? fieldLabelText,
  }) {
    return showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: firstDate ?? DateTime(1900),
      lastDate: lastDate ?? DateTime(2100),
      initialEntryMode: initialEntryMode,
      selectableDayPredicate: selectableDayPredicate,
      helpText: helpText,
      cancelText: cancelText,
      confirmText: confirmText,
      errorFormatText: errorFormatText,
      errorInvalidText: errorInvalidText,
      fieldHintText: fieldHintText,
      fieldLabelText: fieldLabelText,
    );
  }
  
  // Show time picker
  static Future<TimeOfDay?> showTimePicker({
    required BuildContext context,
    TimeOfDay? initialTime,
    bool cancelText,
    bool confirmText,
    String? helpText,
    String? errorInvalidText,
    String? hourLabelText,
    String? minuteLabelText,
    bool useRootNavigator = true,
    RouteSettings? routeSettings,
  }) {
    return showTimePicker(
      context: context,
      initialTime: initialTime ?? TimeOfDay.now(),
      cancelText: cancelText,
      confirmText: confirmText,
      helpText: helpText,
      errorInvalidText: errorInvalidText,
      hourLabelText: hourLabelText,
      minuteLabelText: minuteLabelText,
      useRootNavigator: useRootNavigator,
      routeSettings: routeSettings,
    );
  }
  
  // Format date
  static String formatDate(DateTime date, {String format = 'MMM dd, yyyy'}) {
    // You can use intl package for more complex formatting
    return '${date.month}/${date.day}/${date.year}';
  }
  
  // Format time
  static String formatTime(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
  
  // Get responsive width
  static double getResponsiveWidth(BuildContext context, double percentage) {
    return MediaQuery.of(context).size.width * percentage;
  }
  
  // Get responsive height
  static double getResponsiveHeight(BuildContext context, double percentage) {
    return MediaQuery.of(context).size.height * percentage;
  }
  
  // Check if device is tablet
  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.width > 600;
  }
  
  // Check if device is phone
  static bool isPhone(BuildContext context) {
    return MediaQuery.of(context).size.width <= 600;
  }
}