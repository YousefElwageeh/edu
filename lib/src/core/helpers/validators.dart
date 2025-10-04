/// returns a validator that validates emtpy for the given field name
/// cla
///
class Valdiator {
  static String? Function(String? name) validateEmptyField(String fieldname) {
    return (String? value) {
      if (value!.isEmpty) {
        return "$fieldname Can't be Empty";
      }
      return null;
    };
  }

  static String? validatePassword(String? password) {
    if (password!.isEmpty) {
      return "Password Can't be Empty";
    }
    if ((password.trim().length) < 6) {
      return "Password Can't be less than 6";
    }

    return null;
  }

  static String? validateConfirmPassword(
      String? password, String? confirmPassword) {
    if (confirmPassword!.isEmpty) {
      return "Password Can't be Empty";
    }
    if (confirmPassword.trim() != password!.trim()) {
      return "Passwords don't match";
    }

    return null;
  }

  // static String? validateEmail(String? email) {
  //   if ((email?.trim().isEmpty ?? true) ||
  //       !GetUtils.isEmail(email?.trim() ?? "")) {
  //     return "Provide valid Email";
  //   }

  //   return null;
  // }

  static String? validateName(String? name) {
    if (name!.isEmpty) {
      return "Name Can't be Empty";
    }
    return null;
  }

  static String? validateReferralCode(String? code) {
    if (code!.isEmpty) {
      return "Referral Code Can't be Empty";
    }
    return null;
  }

  static String? validateLocation(String? location, String type) {
    if (location!.isEmpty) {
      return "$type Can't be Empty";
    }
    return null;
  }

  static String? validateBirthDate(String? date) {
    if (date!.isEmpty) {
      return "Please enter your birth date";
    }
    return null;
  }

  static String? validateFullName(String? name) {
    name!.trim();
    List<String> fullName = name.split(' ');
    if (fullName.length < 2 || fullName.any((element) => element.isEmpty)) {
      return "Enter Full Name";
    }
    return null;
  }

  static String? validateTitle(String? name) {
    if (name!.isEmpty) {
      return "Please enter the title";
    }
    return null;
  }

  static String? validateDesc(String? name) {
    if (name!.isEmpty) {
      return "Please enter the Desc";
    }
    return null;
  }

  static String? validatePhoneNoE164(String? value) {
    Pattern pattern = r'^\+?[1-9]\d{1,14}$';
    RegExp regex = RegExp(pattern.toString());
    if (!regex.hasMatch(value!)) {
      return 'Enter Valid Number';
    }
    return null;
  }

  static String? validatePhoneNo(String? value) {
    Pattern pattern = r'^(?:(?:\+|0{0,2})91(\s*[\-]\s*)?|[0]?)?[6789]\d{9}$';
    RegExp regex = RegExp(pattern.toString());
    if (!regex.hasMatch((value ?? "").trim())) {
      return 'Enter Valid Number';
    }
    return null;
  }

  static String? validateLoanAmount(String? value) {
    if (value!.isEmpty) {
      return "Please enter Loan Amount";
    }
    return null;
  }

  static String? validateCropDetails(String? value) {
    if (value!.isEmpty) {
      return "Please enter Crop Details";
    }
    return null;
  }

  static String? validateLandArea(String? value) {
    if (value!.isEmpty) {
      return "Please enter Land Area";
    }
    return null;
  }

  static String? validateCurrentLoan(String? value) {
    if (value!.isEmpty) {
      return "Please enter Current Loan Amount";
    }
    return null;
  }

  static String? validateLoanType(String? value) {
    if (value?.isEmpty ?? true) {
      return "Please select Loan Type";
    }
    return null;
  }

  static String? validateAddress(String? value) {
    if (value!.isEmpty) {
      return "Please enter Address";
    }
    return null;
  }

  static String? validatePincode(String? value) {
    if (value!.isEmpty) {
      return "Please enter Pincode";
    }
    if (value.length != 6) {
      return "Please enter valid Pincode";
    }
    return null;
  }

  static String? validateCity(String? value) {
    if (value!.isEmpty) {
      return "Please enter City";
    }
    return null;
  }

  static String? validateDistrict(String? value) {
    if (value!.isEmpty) {
      return "Please enter District";
    }
    return null;
  }

  static String? validateUniversity(String? value) {
    if (value!.isEmpty) {
      return "Please enter University";
    }
    return null;
  }

  static String? validateAssociation(String? value) {
    if (value!.isEmpty) {
      return "Please enter Association";
    }
    if (value.length < 20) {
      return "Please enter valid Association";
    }
    return null;
  }
}
