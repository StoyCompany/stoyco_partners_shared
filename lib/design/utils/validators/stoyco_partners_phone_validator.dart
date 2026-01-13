import 'package:reactive_forms/reactive_forms.dart';
import 'package:stoyco_partners_shared/design/models/phone_number_model.dart';

class StoycoPartnersPhoneValidator extends Validator<PhoneNumber?> {
  @override
  Map<String, dynamic>? validate(AbstractControl<PhoneNumber?> control) {
    final phoneNumber = control.value;
    if (phoneNumber == null || phoneNumber.number!.isEmpty) {
      return {'phoneNumberMissing': 'Phone number is null'};
    }

    if (!phoneNumber.isValid) {
      return {'phoneNumberInvalid': 'Phone number is invalid'};
    }

    return null;
  }
}
