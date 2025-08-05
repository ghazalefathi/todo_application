
import 'package:get/get.dart';
import 'package:todo_application/core/strings.dart';


class ApiProvider extends GetConnect {
  @override
  String? get baseUrl => '${MyStrings.baseUrl}/api/v1';

  @override
  Duration get timeout => Duration(seconds: 60);



  static String getImageUrl(String? imageUrl) => imageUrl == null
      ? ''
      : imageUrl.contains('http')
          ? imageUrl
          : '${MyStrings.baseUrl}$imageUrl';
}
