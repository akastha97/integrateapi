class ApiRouter {
  static const baseUrl = "https://jsonplaceholder.typicode.com/";

  static int? postId;

  static void setEmpID(int id) {
    postId = id;
  }

  static String get allEmployees => "$baseUrl/posts";

  static String get singleEmployee => "$baseUrl/posts/$postId";

  static String get createEmployee => "$baseUrl/posts";

  static String get updateEmployee => "$baseUrl/posts/$postId";
}
