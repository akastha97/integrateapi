class ApiRouter {
  static const baseUrl = "https://jsonplaceholder.typicode.com/";

  static int? postId;

  static void setEmpID(int id) {
    postId = id;
  }

  static String get allPosts => "$baseUrl/posts";

  static String get singlePost => "$baseUrl/posts/$postId";

  static String get newPost => "$baseUrl/posts";

  static String get updatePost => "$baseUrl/posts/$postId";
}
