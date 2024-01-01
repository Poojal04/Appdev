import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';

class Post {
  int userId;
  int id;
  String title;
  String body;

  Post({required this.userId, required this.id, required this.title, required this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'] ?? 0,
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      body: json['body'] ?? '',
    );
  }
}

Future<List<Post>> fetchPosts() async {
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

  if (response.statusCode == 200) {
    List<dynamic> jsonList = json.decode(response.body);
    List<Post> posts = jsonList.map((json) => Post.fromJson(json)).toList();
    return posts;
  } else {
    throw Exception('Failed to load posts');
  }
}

List<Post> filterPosts(List<Post> posts, {int? userId, int? id, String? title, String? body}) {
  return posts.where((post) {
    return (userId == null || post.userId == userId) &&
        (id == null || post.id == id) &&
        (title == null || post.title.contains(title)) &&
        (body == null || post.body.contains(body));
  }).toList();
}

void displayPosts(List<Post> filteredPosts) {
  if (filteredPosts.isNotEmpty) {
    print('Filtered Posts:');
    for (var post in filteredPosts) {
      print('Post ID: ${post.id}, Title: ${post.title}, Body: ${post.body}');
    }
  } else {
    print('No posts found for the specified criteria.');
  }
}

void main() async {
  try {
    List<Post> posts = await fetchPosts();

    
    print('Enter UserID (or leave blank to ignore):');
    var userIdInput = stdin.readLineSync();
    var userId = userIdInput != null && userIdInput.isNotEmpty ? int.tryParse(userIdInput) : null;

    print('Enter ID (or leave blank to ignore):');
    var idInput = stdin.readLineSync();
    var id = idInput != null && idInput.isNotEmpty ? int.tryParse(idInput) : null;

    print('Enter Title Keyword (or leave blank to ignore):');
    var title = stdin.readLineSync();

    print('Enter Body Keyword (or leave blank to ignore):');
    var body = stdin.readLineSync();

    // Filtering posts based on user input
    List<Post> filteredPosts = filterPosts(posts, userId: userId, id: id, title: title, body: body);
    displayPosts(filteredPosts);
  } catch (e) {
    print('Error: $e');
  }
}
