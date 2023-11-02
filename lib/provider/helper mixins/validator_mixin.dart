import 'package:testtask/utils/util_function.dart';

mixin Validators {
  String? emptyValidation(String? value) {
    if (!UtilFunctions.isValidString(value)) {
      return 'This field cannot be empty!';
    }
    return null;
  }
}
