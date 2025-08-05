import 'dart:developer';
import 'dart:typed_data';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vibration/vibration.dart';
import '../widgets/public/my_snackbar.dart';
import 'app_colors.dart';

import 'regexes.dart';

DateTime lastSnackShowTime = DateTime.now().add(Duration(seconds: -3));
final Locale _prLocale = Locale('fa');
final Locale _enLocale = Locale('en');

class Utils {
  static Locale getEnLocale() => _enLocale;
  static Locale getPrLocale() => _prLocale;
  static bool isOtpValid(String code) {
    return RegExp(r'^\d{6}$').hasMatch(code);
  }

  static final player = AudioPlayer();

  static vibrate() => Vibration.vibrate(duration: 60);

  static Future<void> playSound(String soundPath) async =>
      await player.play(AssetSource(soundPath));

  static String padLeft(String text) => text.padLeft(2, '0');



  static TextDirection get defaultTextDirection =>
      isEnglishLocale() ? TextDirection.ltr : TextDirection.rtl;
  static TextDirection get getOpositeDirection =>
      isEnglishLocale() ? TextDirection.rtl : TextDirection.ltr;
  static TextAlign get defaultTextAlign => isEnglishLocale() ? TextAlign.left : TextAlign.right;
  static TextAlign get getOpositeTextAlign => isEnglishLocale() ? TextAlign.right : TextAlign.left;

  static Alignment get defaultAlignment =>
      isEnglishLocale() ? Alignment.centerLeft : Alignment.centerRight;
  static Alignment get getOpositeAlignment =>
      isEnglishLocale() ? Alignment.centerRight : Alignment.centerLeft;

  static bool isEnglishLocale() => Get.locale == _enLocale;



  static void shareUrl({required String url}) async {
    await SharePlus.instance.share(ShareParams(uri: Uri.parse(url)));
  }

  static void shareText({required String text}) async {
    await SharePlus.instance.share(ShareParams(text: text));
  }

  static bool isValidName(String input) {
    final pattern = RegExp(r'^[A-Za-z\u0600-\u06FF ]+$');
    return pattern.hasMatch(input);
  }

  static (String, bool) validateName(String input) {
    // 1. Trim leading/trailing whitespace
    final trimmed = input.trim();

    // 2. Remove any characters that aren’t A–Z, a–z, Persian letters, or space
    final filtered = trimmed.replaceAll(
      RegExp(r'[^A-Za-z\u0600-\u06FF ]'),
      '',
    );

    // 3. Collapse multiple spaces into a single space
    final normalized = filtered.replaceAll(
      RegExp(r'\s+'),
      ' ',
    );

    // 4. Valid if normalized == trimmed AND matches “one optional space” pattern
    final pattern = RegExp(r'^[A-Za-z\u0600-\u06FF]+(?: [A-Za-z\u0600-\u06FF]+)?$');
    final isValid = normalized == trimmed && pattern.hasMatch(normalized);

    return (normalized, isValid);
  }

  static String formatCardNumber(String input) {
    return input.replaceAllMapped(RegExp(r".{1,4}"), (match) => "${match.group(0)}    ").trim();
  }

  static void checkResponse(Response res,
      {Function()? onOk, Function()? onNull, Function()? onError, bool isShowError = true}) {
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
      {required String url, LaunchMode launchMode = LaunchMode.inAppBrowserView}) async {
    try {
      if (!await launchUrl(Uri.parse(url), mode: launchMode)) {
        throw Exception('Could not launch $url');
      }
    } catch (e) {
      log('Launch Error $e');
    }
  }

  static (String, bool) formatTextName(String input,
      {bool isSupportSpace = true, bool isSupportDot = true}) {
    bool hasError = false;
    String text = input.toLowerCase();
    if (text.startsWith(' ') || text.startsWith('.')) {
      text = text.substring(1);
      hasError = true;
    }
    if (text.isNotEmpty) {
      if (text.endsWith('  ')) {
        text = text.substring(0, text.length - 1);
        hasError = true;
      }
      if (!(Regexes.persianRegex.hasMatch(text) || Regexes.englishRegex.hasMatch(text))) {
        hasError = true;
        text = text.replaceAll(RegExp(r'[^A-Za-z\u0600-\u06FF ]'), '');
      }
      bool isEnglish = Regexes.englishDetector.hasMatch(text[0]);
      if (isEnglish && Regexes.persianDetector.hasMatch(text)) {
        hasError = true;
        text = text.replaceAll(Regexes.persianDetector, '');
      } else if (!isEnglish && Regexes.englishDetector.hasMatch(text)) {
        hasError = true;
        text = text.replaceAll(Regexes.englishDetector, '');
      }
      List<String> list = text.split('');

      for (int i = 0; i < list.length; i++) {
        if (i == 0) {
          list[0] = list[0].toUpperCase();
        }
        if (isSupportSpace) {
          if (list[i] == ' ' && i < list.length - 1) {
            list[i + 1] = list[i + 1].toUpperCase();
          }
        } else if (i != 0) {
          list[i] = list[i].toLowerCase();
        }
      }
      if (isSupportSpace) {
        if (list.where((element) => element == ' ').length > 2) {
          hasError = true;
          List<int> spaceIndex = [];
          for (var i = 0; i < list.length; i++) {
            if (list[i] == ' ') {
              spaceIndex.add(i);
            }
          }
          list.removeWhere((element) => element == ' ');
          list.insert(spaceIndex[0], ' ');
          list.insert(spaceIndex[1], ' ');
        }
      } else if (list.contains(' ')) {
        hasError = true;
        list.removeWhere((element) => element == ' ');
      }

      // if (isSupportDot) {
      //   if (list.where((element) => element == '.').length > 1) {
      //     hasError = true;
      //     int indxFirstSpace = list.indexWhere((element) => element == '.');
      //     list.removeWhere((element) => element == '.');
      //     list.insert(indxFirstSpace, '.');
      //   }
      // } else if (list.contains('.')) {
      //   hasError = true;
      //   list.removeWhere((element) => element == '.');
      // }

      text = list.join('');
    }
    return (text, hasError);
  }

  static void showErrorMessage({
    required String? message,
    required bool isSuccess,
  }) {
    Color color = isSuccess ? AppColors.white : AppColors.yellow;

    mySnackBar(
        icon: Icon(
          size: 26,
          isSuccess ? Icons.check_circle_outline_rounded : Icons.warning_rounded,
          color: color,
        ),
        color: color,
        message: message ?? '');
  }

  static Future<Uint8List?> selectNewImageFromGallery() async {
    Uint8List? image;
    int imageQuality = 40;
    final ImagePicker picker = ImagePicker();

    await picker.pickImage(imageQuality: imageQuality, source: ImageSource.gallery).then(
      (file) async {
        if (file != null) {
          image = await file.readAsBytes();
        }
      },
    );

    return image;
  }
}
