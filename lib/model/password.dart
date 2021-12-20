import 'package:formz/formz.dart';

enum PasswordValidatorError { empty, lessThan8Char }

class Password extends FormzInput<String, PasswordValidatorError> {
  const Password.pure() : super.pure('');

  const Password.dirty(String value) : super.dirty(value);

  @override
  PasswordValidatorError? validator(String value) {
    if (value.isEmpty) {
      return PasswordValidatorError.empty;
    } else if (value.length < 8) {
      return PasswordValidatorError.lessThan8Char;
    }
    return null;
  }
}
