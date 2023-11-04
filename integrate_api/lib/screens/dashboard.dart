import 'package:flutter/material.dart';
import 'package:integrate_api/models/employee_model.dart';
import 'package:integrate_api/network/api_manager.dart';
import 'package:integrate_api/ui_components/posttextfield.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({
    super.key,
  });

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<PostModel> posts = [];
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getPosts();
  }

  // Method to get the posts
  Future<void> getPosts() async {
    try {
      final fetchedPosts = await ApiManager().fetchPosts();
      setState(() {
        posts = fetchedPosts;
      });
    } catch (error) {
      print("Error fetching posts:");
    }
  }

  // Method to call the add post api call
  Future<void> addPost() async {
    // Prepare the data to be sent in the request
    Map<String, dynamic> inputBody = {
      'title': titleController.text,
      'body': bodyController.text,
      'userId': 1,
      'id': 101
    };
    try {
      final newPost = await ApiManager().addNewPost(inputBody);
      setState(() {
        posts.add(newPost);
      });
      titleController.clear();
      bodyController.clear();
      Navigator.pop(context);
    } catch (error) {
      print("Error adding a new post: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffDFB2F4),
      appBar: AppBar(
        backgroundColor: const Color(0xff6F2DBD),
        title: const Text(
          "Rest API's",
          style:
              TextStyle(fontFamily: 'Monsterrat', fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 70,
            ),
            Expanded(child: buildListView())
          ],
        ),
      ),
      floatingActionButton: displayFAB(),
    );
  }

  // To display the Alert box for adding a new post
  AlertDialog addPostAlert() {
    return AlertDialog(
      title: const Text(
        "Add post",
        style: TextStyle(
            fontSize: 20,
            fontFamily: "Monsterrat",
            fontWeight: FontWeight.bold),
      ),
      content: Wrap(
        runSpacing: 20,
        children: [
          PostTextfield(controller: titleController),
          PostTextfield(controller: bodyController)
        ],
      ),
      actions: [displayAlertBoxButtons()],
    );
  }

  Center displayAlertBoxButtons() {
    var addButton = ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.purple)),
      child: const Text(
        "Add",
        style: TextStyle(
            fontSize: 12,
            fontFamily: "Monsterrat",
            fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        addPost();

        titleController.clear();
      },
    );
    var cancelButton = ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.purple)),
        child: const Text(
          "Cancel",
          style: TextStyle(
              fontSize: 12,
              fontFamily: "Monsterrat",
              fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          Navigator.pop(context);
        });
    return Center(
      child: Wrap(
        children: [
          addButton,
          const SizedBox(
            width: 10,
          ),
          cancelButton,
        ],
      ),
    );
  }

  // Method to display the FAB
  FloatingActionButton displayFAB() {
    return FloatingActionButton(
      backgroundColor: const Color(0xffD6F9DD),
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) {
              return addPostAlert();
            });
      },
      child: const Icon(
        Icons.add,
        size: 30,
        color: Colors.black,
      ),
    );
  }

  // Method to build the list view
  Widget buildListView() {
    return ListView.builder(
        itemCount: posts.length,
        itemBuilder: ((context, index) {
          PostModel result = posts[index];
          return Card(
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(20),
            ),
            margin: const EdgeInsets.only(left: 44, right: 44, bottom: 32),
            child: ListTile(
              contentPadding: EdgeInsets.all(16),
              title: Text(
                result.title.toString() ?? "",
                style: const TextStyle(
                    fontFamily: "Monsterrat",
                    fontSize: 20,
                    fontWeight: FontWeight.w900),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(result.body.toString() ?? "",
                    style: const TextStyle(
                        fontFamily: "Monsterrat",
                        fontSize: 18,
                        fontWeight: FontWeight.w700)),
              ),
            ),
          );
        }));
  }
}
