class AuthError extends Error{
  String message;

  AuthError(this.message);
}