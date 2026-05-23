import 'package:flutter_test/flutter_test.dart';

import 'package:dhiman/core/constants/app_constants.dart';
import 'package:dhiman/core/utils/phone_utils.dart';

void main() {
  test('app branding constants', () {
    expect(AppConstants.appName, 'ধীমান');
    expect(AppConstants.appNameEn, 'Dhiman');
  });

  test('normalizes Bangladesh phone numbers', () {
    expect(normalizeBdPhone('01712345678'), '+8801712345678');
    expect(isValidBdPhone('01712345678'), isTrue);
  });
}
