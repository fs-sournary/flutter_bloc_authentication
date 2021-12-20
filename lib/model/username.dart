import 'package:formz/formz.dart';

enum UsernameValidatorError { empty, lessThan8Char }

class Username extends FormzInput<String, UsernameValidatorError> {
  const Username.pure() : super.pure('');

  const Username.dirty(String value) : super.dirty(value);

  @override
  UsernameValidatorError? validator(String value) {
    if (value.isEmpty) {
      return UsernameValidatorError.empty;
    } else if (value.length < 8) {
      return UsernameValidatorError.lessThan8Char;
    }
    return null;
  }
}
