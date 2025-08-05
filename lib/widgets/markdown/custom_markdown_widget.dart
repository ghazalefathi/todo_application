import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/app_colors.dart';
import '../../core/enum.dart';
import '../../core/strings.dart';
import '../../core/utils.dart';
import '../public/my_network_image.dart';
import '../public/my_text_button.dart';
import '../public/my_text_widget.dart';

class CustomMarkdown extends StatelessWidget {
  final String data;
  final bool isPersian;

  const CustomMarkdown(this.data, {super.key, this.isPersian = false});

  @override
  Widget build(BuildContext context) {
    final lines = data.split(RegExp(r"\r?\n"));
    final widgets = <Widget>[];
    bool inFencedCode = false;
    bool inIndentedCode = false;
    final codeBuffer = StringBuffer();
    String? currentCodeLanguage;

    void flushCodeBlock() {
      widgets.add(_buildCodeBlock(codeBuffer.toString(), currentCodeLanguage));
      codeBuffer.clear();
      inFencedCode = false;
      inIndentedCode = false;
      currentCodeLanguage = null;
    }

    for (var line in lines) {
      // Fenced code block fences `
      if (line.trim().startsWith('```')) {
        if (inFencedCode) {
          // closing fence
          flushCodeBlock();
        } else {
          // opening fence
          inFencedCode = true;
          final langPart = line.trim().substring(3);
          currentCodeLanguage = langPart.isNotEmpty ? langPart : null;
        }
        continue;
      }

      if (inFencedCode) {
        codeBuffer.writeln(line);

        continue;
      }

      // Indented code blocks (4 spaces)
      if (line.startsWith('    ')) {
        if (!inIndentedCode) {
          inIndentedCode = true;
        }
        codeBuffer.writeln(line.substring(4));
        continue;
      } else if (inIndentedCode) {
        // flush indented block when indentation ends
        flushCodeBlock();
      }

      // Heading
      final headingMatch = RegExp(r'^(#{1,6})\s+(.*)').firstMatch(line);
      if (headingMatch != null) {
        final level = headingMatch.group(1)!.length;
        final text = headingMatch.group(2)!;
        widgets.add(_buildHeading(text, level, context));
        continue;
      }

      // Unordered list
      final listMatch = RegExp(r'^[-*+]\s+(.*)').firstMatch(line);
      if (listMatch != null) {
        widgets.add(_buildListItem(listMatch.group(1)!));
        continue;
      }

      // Horizontal rule
      if (RegExp(r'^(---|\*\*\*|___)\s*$').hasMatch(line)) {
        widgets.add(const Divider());
        continue;
      }

      // Blockquote
      final quoteMatch = RegExp(r'^>\s+(.*)').firstMatch(line);
      if (quoteMatch != null) {
        widgets.add(_buildBlockQuote(quoteMatch.group(1)!));
        continue;
      }

      // Image
      final imageMatch = RegExp(r'!\[(.*?)\]\((.*?)\)').firstMatch(line);
      if (imageMatch != null) {
        final altText = imageMatch.group(1)!;
        final imageUrl = imageMatch.group(2)!;
        widgets.add(_buildImage(imageUrl, altText));
        continue;
      }

      // Paragraph / inline
      if (line.trim().isNotEmpty) {
        widgets.add(_buildParagraph(line));
      } else {
        // Blank line = spacing
        widgets.add(const SizedBox(height: 8));
      }
    }

    // If document ends with an open code block
    if (inIndentedCode || inFencedCode) {
      widgets.add(_buildCodeBlock(codeBuffer.toString(), currentCodeLanguage));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      textDirection: isPersian ? TextDirection.rtl : TextDirection.ltr,
      children: widgets,
    );
  }

  Widget _buildHeading(String text, int level, BuildContext context) {
    final sizes = [24.0, 20.0, 18.0, 16.0, 14.0, 12.0];
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 4),
      child: Text(
        text,
        textDirection: isPersian ? TextDirection.rtl : TextDirection.ltr,
        textAlign: isPersian ? TextAlign.right : TextAlign.left,
        style: generateTextStyle(isBold: true, fontSize: sizes[level - 1]),
      ),
    );
  }

  Widget _buildParagraph(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: RichText(
        textDirection: isPersian ? TextDirection.rtl : TextDirection.ltr,
        textAlign: isPersian ? TextAlign.right : TextAlign.left,
        text: _parseInline(text),
      ),
    );
  }

  Widget _buildCodeBlock(String code, String? language) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey.shade800,
      ),
      width: double.infinity,
      // padding: const EdgeInsets.all(4),
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        // The `spacing` property is not directly available in `Column`.
        // You would typically use `SizedBox` between children for spacing.
        // For demonstration, I'm removing it here.
        // If `modo_chats` provides a custom `Column` with `spacing`, you can re-add it.
        // spacing: 5,
        textDirection: TextDirection.rtl,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(15)),
              color: AppColors.black.withValues(alpha: .3),
            ),
            child: Row(textDirection: TextDirection.rtl, children: [
              MyTextButton(
                  height: 30,
                  borderRadius: BorderRadius.circular(7.5),
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  // bgColor: AppColors.white.withValues(alpha: .3),
                  onTap: () {
                    Clipboard.setData(ClipboardData(
                      text: code,
                    ));
                    Utils.showErrorMessage(
                        message: 'copied_succesfully'.tr, isSuccess: true);
                  },
                  // The `spacing` property is not directly available in `Row`.
                  // You would typically use `SizedBox` between children for spacing.
                  // For demonstration, I'm removing it here.
                  // If `modo_chats` provides a custom `Row` with `spacing`, you can re-add it.
                  // child: Row(textDirection: TextDirection.rtl, spacing: 5, children: [
                  child: Row(textDirection: TextDirection.rtl, children: [
                    Icon(Icons.copy_rounded,
                        size: 20, color: AppColors.white.withValues(alpha: .9)),
                    const SizedBox(width: 5), // Added SizedBox for spacing
                    Text('Copy',
                        style: generateTextStyle(
                            color: AppColors.white.withValues(
                                alpha: .9))), // Added a text for clarity
                  ])),
              const Spacer(),
              if (language != null)
                MyText(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  text: language,
                  color: AppColors.white.withValues(alpha: .7),
                )
            ]),
          ),
          SizedBox(
            width: double.infinity,
            child: MyText(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              text: code,
              textAlign: TextAlign.left,
              textDirection: TextDirection.ltr,
              color: AppColors.white.withValues(alpha: .8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText(
            text: '• ',
            color: AppColors.white,
            textDirection: isPersian ? TextDirection.rtl : TextDirection.ltr,
            textAlign: isPersian ? TextAlign.right : TextAlign.left,
          ),
          Expanded(
              child: RichText(
                  text: _parseInline(text),
                  textDirection:
                      isPersian ? TextDirection.rtl : TextDirection.ltr,
                  textAlign: isPersian ? TextAlign.right : TextAlign.left)),
        ],
      ),
    );
  }

  Widget _buildBlockQuote(String text) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: Colors.grey.shade400, width: 4),
        ),
        color: Colors.grey.shade100,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: RichText(
          text: _parseInline(text),
          textDirection: isPersian ? TextDirection.rtl : TextDirection.ltr,
          textAlign: isPersian ? TextAlign.right : TextAlign.left),
    );
  }

  Widget _buildImage(String imageUrl, String altText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          LayoutBuilder(
            builder: (context, constraints) => SizedBox.square(
              dimension: constraints.maxWidth,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: GestureDetector(
                      onTap: () => showImageDialog(context, imageUrl),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.contain, // Adjust as needed
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                strokeCap: StrokeCap.round,
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                                color: AppColors
                                    .white, // Assuming AppColors.white is accessible here
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Text('Could not load image: $altText',
                                style: generateTextStyle(color: Colors.red));
                          },
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      right: 5,
                      top: 5,
                      child: MyTextButton(
                          onTap: () => Utils.launchTheUrl(
                              url: imageUrl,
                              launchMode: LaunchMode.externalApplication),
                          height: 25,
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          bgColor: AppColors.black.withValues(alpha: .8),
                          child: Icon(
                            Icons.download_rounded,
                            color: AppColors.white.withValues(alpha: .8),
                          )))
                ],
              ),
            ),
          ),
          if (altText.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                altText,
                style: generateTextStyle(fontSize: 12, color: AppColors.red),
                textAlign: TextAlign.center,
              ),
            ),
        ],
      ),
    );
  }

  TextSpan _parseInline(String text) {
    final children = <TextSpan>[];
    int currentIndex = 0;
    // Updated pattern to include image syntax: !\[(.*?)\]\((.*?)\)
    final pattern = RegExp(
      r'(\*\*(.*?)\*\*)|(\*(.*?)\*)|(`(.*?)`)|\[(.*?)\]\((.*?)\)|!\[(.*?)\]\((.*?)\)',
      dotAll: true,
    );
    final matches = pattern.allMatches(text);
    for (final match in matches) {
      final start = match.start;
      final end = match.end;
      if (currentIndex < start) {
        children.add(TextSpan(text: text.substring(currentIndex, start)));
      }
      final bold = match.group(2);
      final italic = match.group(4);
      final code = match.group(6);
      final linkText = match.group(7);
      final linkUrl = match.group(8);
      final imageAltText = match.group(9); // New: Image Alt Text
      final imageUrl = match.group(10); // New: Image URL

      if (bold != null) {
        children.add(TextSpan(
          text: bold,
          style: generateTextStyle(isBold: true),
        ));
      } else if (italic != null) {
        children.add(TextSpan(
          text: italic,
          style: generateTextStyle(isItalic: true),
        ));
      } else if (code != null) {
        children.add(TextSpan(
          text: code,
          style: generateTextStyle(
              isItalic: true), // Typically code is not italic, adjust if needed
        ));
      } else if (linkText != null && linkUrl != null) {
        children.add(TextSpan(
          text: linkText,
          style: generateTextStyle(isLink: true),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              if (linkUrl.startsWith('http') || linkUrl.startsWith('https')) {
                Utils.launchTheUrl(url: linkUrl);
              }
            },
        ));
      } else if (imageAltText != null && imageUrl != null) {
        // For inline images, we will represent them as a special TextSpan,
        // or you might decide to replace the entire RichText with a Column
        // if you want actual image widgets within the paragraph.
        // For now, let's just show the alt text or a placeholder.
        // To truly embed an Image.network inline, you'd need a more complex
        // solution like a CustomTextSpan or a custom layout.
        // For simplicity, we'll just show the alt text in blue.
        children.add(TextSpan(
          text: '[$imageAltText]', // Showing alt text as placeholder
          style: generateTextStyle(
              isLink: true, color: Colors.purple), // Styling for image link
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              // You could launch the image URL here if you want
              if (imageUrl.startsWith('http') || imageUrl.startsWith('https')) {
                Utils.launchTheUrl(url: imageUrl);
              }
            },
        ));
      }
      currentIndex = end;
    }
    if (currentIndex < text.length) {
      children.add(TextSpan(text: text.substring(currentIndex)));
    }
    return TextSpan(
      style: generateTextStyle(fontSize: 14),
      children: children,
    );
  }
}

void showImageDialog(BuildContext context, String imageUrl) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: AppColors.transparent,
        child: LayoutBuilder(
          builder: (context, constraints) => Container(
            width: constraints.maxWidth,
            height: constraints.maxWidth + 100,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Stack(
                children: [
                  Positioned.fill(
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            color: AppColors.white.withValues(alpha: .1),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: SizedBox(),
                            ),
                          ))),
                  Positioned.fill(
                      bottom: 0,
                      child: InteractiveViewer(
                          child: MyNetworkImage(
                              imageAddress: imageUrl, boxFit: BoxFit.contain))),
                  Positioned(
                      left: 10,
                      top: 10,
                      child: MyTextButton(
                          onTap: () => Utils.launchTheUrl(
                              url: imageUrl,
                              launchMode: LaunchMode.externalApplication),
                          height: 25,
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          bgColor: AppColors.black.withValues(alpha: .8),
                          child: Icon(Icons.download_rounded,
                              color: AppColors.white.withValues(alpha: .8)))),
                  Positioned(
                      top: 0,
                      right: 10,
                      child: MyTextButton(
                          onTap: () => Get.back(),
                          child: Icon(Icons.cancel, color: AppColors.red)))
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

TextStyle generateTextStyle({
  bool isItalic = false,
  bool isBold = false,
  bool isLink = false,
  double? fontSize,
  Color? color, // Added color parameter
}) {
  return TextStyle(
    color: color ?? (isLink ? Colors.blue : AppColors.white),
    fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
    fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
    decoration: isLink ? TextDecoration.underline : TextDecoration.none,
    fontFamily:
        MyStrings.getFonts(fontType: isBold ? FontType.bold : FontType.regular),
    fontFamilyFallback: [
      MyStrings.getFonts(fontType: isBold ? FontType.bold : FontType.regular)
    ],
    fontSize: fontSize,
  );
}
