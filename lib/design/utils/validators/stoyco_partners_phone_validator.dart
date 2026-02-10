import 'package:reactive_forms/reactive_forms.dart';
import 'package:stoyco_partners_shared/design/models/phone_number_model.dart';

class StoycoPartnersPhoneValidator extends Validator<PhoneNumber?> {
  @override
  Map<String, dynamic>? validate(AbstractControl<PhoneNumber?> control) {
    final PhoneNumber? phoneNumber = control.value;
    if (phoneNumber == null ||
        phoneNumber.number == null ||
        phoneNumber.number!.isEmpty) {
      return <String, dynamic>{'phoneNumberMissing': 'Phone number is null'};
    }

    if (!phoneNumber.isValid) {
      return <String, dynamic>{'phoneNumberInvalid': 'Phone number is invalid'};
    }

    return null;
  }
}
