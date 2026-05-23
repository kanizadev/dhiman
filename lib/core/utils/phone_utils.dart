import '../constants/app_constants.dart';

/// Normalizes Bangladeshi phone numbers to E.164 (+8801XXXXXXXXX).
String normalizeBdPhone(String input) {
  var digits = input.replaceAll(RegExp(r'\D'), '');
  if (digits.startsWith('880')) {
    digits = digits.substring(3);
  } else if (digits.startsWith('0')) {
    digits = digits.substring(1);
  }
  if (digits.length == 10 && digits.startsWith('1')) {
    return '${AppConstants.countryCode}$digits';
  }
  if (digits.length == 11 && digits.startsWith('01')) {
    return '${AppConstants.countryCode}${digits.substring(1)}';
  }
  return '${AppConstants.countryCode}$digits';
}

bool isValidBdPhone(String input) {
  return AppConstants.bdPhoneRegex.hasMatch(input.trim());
}

String formatPhoneDisplay(String e164) {
  if (e164.startsWith('+880')) {
    final local = '0${e164.substring(4)}';
    if (local.length >= 11) {
      return '${local.substring(0, 5)} ${local.substring(5)}';
    }
    return local;
  }
  return e164;
}
