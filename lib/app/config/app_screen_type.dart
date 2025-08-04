import 'package:responsive_builder/responsive_builder.dart';

class AppScreenType {
  factory AppScreenType() {
    return _instance;
  }

  AppScreenType._internal();
  static final AppScreenType _instance = AppScreenType._internal();
  DeviceScreenType? _deviceScreenType;
  RefinedSize? _refinedSize;

  void init(DeviceScreenType deviceScreenType) {
    _deviceScreenType = deviceScreenType;
  }

  DeviceScreenType? get deviceScreenType => _deviceScreenType;
  RefinedSize? get refinedSize => _refinedSize;
}
