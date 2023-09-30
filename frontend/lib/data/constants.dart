class ApiConstants {
  static String baseUrl = 'jsonplaceholder.typicode.com';
  static String registeredUsersEndpoint = '/user/register';
  static String loginUsersEndpoint = '/user/login';
  static String logoutUsersEndpoint = '/user/logout';
  static String registerlocationEndpoint = '/parking/registerlocation';
}

const url = 'http://192.168.103.214:4000';
final registration = url + ApiConstants.registeredUsersEndpoint;
final login = url + ApiConstants.loginUsersEndpoint;
final logout = url + ApiConstants.logoutUsersEndpoint;
final registerlocation = url + ApiConstants.registerlocationEndpoint;
