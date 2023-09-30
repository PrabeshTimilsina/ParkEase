class ApiConstants {
  static String baseUrl = 'jsonplaceholder.typicode.com';
  static String registeredUsersEndpoint = '/user/register';
  static String nearestParkingEngpoint = '/parking/availableparkings';
}

const url = 'http://192.168.102.251:4000';
final registration = url + ApiConstants.registeredUsersEndpoint;
final getNearestParkings = url + ApiConstants.nearestParkingEngpoint;
