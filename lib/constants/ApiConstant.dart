class ApiConstants {
  static const baseUrl = "https://7l60bxbl-3059.inc1.devtunnels.ms/";
  // static const baseUrl = "https://rml-backend-6a1ccbd78c62.herokuapp.com/";
  static const login = "api/v1/auth/login";
  static const socialLogin = "api/v1/auth/social";
  static const logout = "api/v1/auth/logout";
  static const signup = "api/v1/auth/signup";
  static const forgotPass = "api/v1/auth/forgot-password";
  static const verifyOTP = "api/v1/auth/verify-otp";
  static const resetPass = "api/v1/auth/reset-password";
  static const updatePassword = "/api/v1/auth/change-password";
  static const deleteUser = "/api/v1/users/delete/";
  static const verifyFingerPrint = "api/v1/auth/verify-fingerprint";
  // user RUD
  static const getUserDetails = "api/v1/users/get-me";
  static const updateUserDetails = "api/v1/users/update-me";
  static const deleteDetails = "api/v1/users/update-me";

  // Memories CRUD
  static const getAllMemories = "api/v1/memory/all";
  static const getMemoriesDates = "api/v1/memory/calender/memories";
  static const getAllMemoriesImages = "/api/v1/memory/all/images";
  static const findMemories = "api/memory/find/";
  static const createMemories = "api/v1/memory/create";
  // static const findMemories = "api/memory/find/";

  //categories CRUD
  static const getcategories = "api/v1/category/all";
// upload media
  static const uploadPictures = "api/v1/media/uploads";
  static const uploadMimTypes = "/api/v1/media/signed-url";
  static const getPicture = "https://remember-my-love-bucket.s3.amazonaws.com";
// packcages
  static const getAllPackages = "api/v1/package/all";
  static const buySubscription = "/api/v1/package/buy-subscription";
  // static const profile = "${_baseUrl}api/profile";
  // static const logout = "${_baseUrl}api/logout";
  // static const qanswers = "${_baseUrl}api/questions-and-answers";
}
