import 'package:flutter/material.dart';
import 'package:integrate_api/models/employee_model.dart';
import 'package:integrate_api/network/api_manager.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({
    super.key,
  });

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<PostModel> posts = [];

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
      floatingActionButton: getFAB(),
    );
  }

  // Method to display the FAB
  FloatingActionButton getFAB() {
    return FloatingActionButton(
      backgroundColor: const Color(0xffD6F9DD),
      onPressed: () {},
      tooltip: '',
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
                padding: EdgeInsets.only(top: 8.0),
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
