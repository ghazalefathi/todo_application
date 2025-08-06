import 'dart:developer';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vibration/vibration.dart';
import '../widgets/public/my_snackbar.dart';
import 'app_colors.dart';

DateTime lastSnackShowTime = DateTime.now().add(Duration(seconds: -3));

class Utils {
  static final player = AudioPlayer();

  static vibrate() => Vibration.vibrate(duration: 60);

  static Future<void> playSound(String soundPath) async =>
      await player.play(AssetSource(soundPath));

  static String padLeft(String text) => text.padLeft(2, '0');

  static TextDirection get defaultTextDirection => TextDirection.ltr;

  static TextAlign get defaultTextAlign => TextAlign.left;

  static Alignment get defaultAlignment => Alignment.centerLeft;

  static void shareUrl({required String url}) async {
    await SharePlus.instance.share(ShareParams(uri: Uri.parse(url)));
  }

  static void shareText({required String text}) async {
    await SharePlus.instance.share(ShareParams(text: text));
  }

  static void checkResponse(Response res,
      {Function()? onOk,
      Function()? onNull,
      Function()? onError,
      bool isShowError = true}) {
    if (res.body == null) {
      if (onNull != null) {
        onNull();
      }
      return;
    }
    if (res.isOk) {
      if (onOk != null) {
        onOk();
      }
      return;
    } else {
      if (isShowError) {
        if (res.body is Map) {
          Map mp = res.body;
          if (mp.containsKey('message')) {
            showErrorMessage(message: res.body['message'], isSuccess: false);
          } else if (mp.containsKey('detail')) {
            if (mp['detail'] is String) {
              showErrorMessage(message: res.body['detail'], isSuccess: false);
            }
          }
        } else if (res.body is List) {
          List mp = res.body;
          if (mp.first is String) {
            showErrorMessage(message: mp.first, isSuccess: false);
          }
        } else if (onNull == null) {
          showErrorMessage(message: 'communication_error'.tr, isSuccess: false);
        }
      }
      if (onError != null) {
        onError();
      }
    }
  }

  static Future<void> launchTheUrl(
      {required String url,
      LaunchMode launchMode = LaunchMode.inAppBrowserView}) async {
    try {
      if (!await launchUrl(Uri.parse(url), mode: launchMode)) {
        throw Exception('Could not launch $url');
      }
    } catch (e) {
      log('Launch Error $e');
    }
  }

  static void showErrorMessage({
    required String? message,
    required bool isSuccess,
  }) {
    Color color = isSuccess ? AppColors.white : AppColors.yellow;

    mySnackBar(
        icon: Icon(
          size: 26,
          isSuccess
              ? Icons.check_circle_outline_rounded
              : Icons.warning_rounded,
          color: color,
        ),
        color: color,
        message: message ?? '');
  }
}
