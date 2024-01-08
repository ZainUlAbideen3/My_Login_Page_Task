// exception handle class

class AuthExceptionHandler {
  static String errorMessageFromErrorCode(String? errorCode) {
    switch (errorCode) {
      case "ERROR_INVALID_EMAIL":
        return "Your email address appears to be malformed.";
        break;
      case "ERROR_WRONG_PASSWORD":
        return "Your password is wrong.";
        break;
      case "ERROR_USER_NOT_FOUND":
        return "User with this email doesn't exist.";
        break;
      case "ERROR_USER_DISABLED":
        return "User with this email has been disabled.";
        break;
      case "ERROR_TOO_MANY_REQUESTS":
        return "Too many requests. Try again later.";
        break;
      case "ERROR_OPERATION_NOT_ALLOWED":
        return "Signing in with Email and Password is not enabled.";
        break;
      case "ERROR_EMAIL_ALREADY_IN_USE":
      case "account-exists-with-different-credential":
      case "email-already-in-use":
        return "Email is already in use";
        break;
      case "wrong-password":
        return "Wrong password";
        break;
      case "user-not-found":
        return "  User not found";
        break;
      case "user-disabled":
        return "User disabled.";
        break;
      case "operation-not-allowed":
        return "Too many requests to log into this account.";
        break;
      case "invalid-email":
        return "Email address is invalid.";
        break;
      default:
        return "Login failed. Please try again.";
        break;
    }
  }
}
