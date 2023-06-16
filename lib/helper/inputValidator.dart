class InputValidator {



  static String? isPasswordValid(String? password) {
    if (password!.trim().isEmpty) {
      return "Password must not be empty";
    } else if (password.length < 6) {
      return "week password";
    } else return null;
  }

  static String? isPhoneValid(String? phone) {
    if (phone!.trim().isEmpty) {
      return "Phone must not be empty";
    } else if (phone.length < 11) {
      return "phone must be at least 11 number";
    } else if (!phone.startsWith("01")) {
      return "phone must start with 01(-----)";
    }
    else
      return null;
  }

  static String? isNameValid(String? name) {
    if (name!.trim().isEmpty) {
      return "Name must not be empty";
    } else if (name.length < 4) {
      return "Please Write Correct Name";
    } else
      return null;
  }


  static String? isEmailValid(String? email){
    if(email!.trim().isEmpty){
      return "Email must not be empty";
    }else if (!email.trim().endsWith("@gmail.com")){
      return "Email must end with  @gmail.com ";
    }else return null ;
  }


  static String? isAmountValid(String? age) {
    if (age!.trim().isEmpty) {

      return "Amount must not be empty";
    } else if (age.trim().length > 10) {
      return "Amount must be at least 10 number ";
    } else
      return null;
  }
  static String? isUserNameValid(String? email){
    if(email!.trim().isEmpty){
      return "User Name must not be empty";
    }else if (email.trim().length < 7){
      return "User Name must at least 6 ";
    }else return null ;
  }



}