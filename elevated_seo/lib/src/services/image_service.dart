import 'package:elevated_seo/src/utils/functions.dart';
import 'package:image_picker/image_picker.dart';

Future<String> pickImage(ImageSource source) async {
  return await ImagePicker().getImage(source: source).then((value) {
    if (value != null) {
      return value.path;
    } else {
      return "Error";
    }
  }).catchError((e) {
    showMessage("Error: $e");
    return "Error";
  });
}
