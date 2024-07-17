import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppInfo {
  late String? appName;
  late String? packageName;
  late String? version;
  late String? buildNumber;
  late String? deviceName;
  late String? sdkInt;

  AppInfo({
    this.appName,
    this.packageName,
    this.version,
    this.buildNumber,
    this.deviceName,
    this.sdkInt,
  });

  static Future<AppInfo> getInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    DeviceInfoPlugin info = DeviceInfoPlugin();

    String? deviceName = "";
    if (Platform.isAndroid) {
      deviceName = (await info.androidInfo).model;
    }
    if (Platform.isIOS) {
      deviceName = (await info.iosInfo).utsname.machine;
    }

    String? deviceVersion = "";
    if (Platform.isAndroid) {
      deviceVersion = "Android ${(await info.androidInfo).version.sdkInt}";
    }
    if (Platform.isIOS) {
      deviceVersion = "IOS ${(await info.iosInfo).utsname.version}";
    }

    return AppInfo(
      appName: packageInfo.appName,
      packageName: packageInfo.packageName,
      version: packageInfo.version,
      buildNumber: packageInfo.buildNumber,
      deviceName: deviceName,
      sdkInt: deviceVersion,
    );
  }

  @override
  String toString() {
    final Map<String, dynamic> data = {
      "appName": appName,
      "packageName": packageName,
      "version": version,
      "buildNumber": buildNumber,
      "deviceInfo": deviceName,
    };
    return jsonEncode(data);
  }
}