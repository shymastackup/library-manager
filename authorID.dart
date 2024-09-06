import 'dart:math';

String generateUniqueID() {
  var timestamp = DateTime.now().millisecondsSinceEpoch;
  var random = Random().nextInt(10);
  return '$timestamp$random';
}


