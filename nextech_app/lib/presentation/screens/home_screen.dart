import 'package:flutter/material.dart';
import 'package:nextech_app/constants/app_colours.dart';
import 'package:nextech_app/constants/routes.dart';
import 'package:nextech_app/data/locator.dart';
import 'package:nextech_app/data/runtime_state.dart';
import 'package:nextech_app/storage/hive_local_storage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 50),
        ),
        welcomeText(),
        addDocCard(context),
        const Padding(
          padding: EdgeInsets.only(top: 20),
        ),
       
      ],
    ));
  }

  

  Widget addDocCard(context) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            title: const Text('Add Document'),
            subtitle: const Text('Add a document to the system'),
            trailing: const Icon(Icons.add),
            onTap: () async {
              Navigator.of(context).pushNamed(kCameraRoute);
            },
          ),
        ],
      ),
    );
  }

  Widget welcomeText() {
    return  Text("Welcome back ${HiveStorage.getUser().userName} !",
        style: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.bold,
          color: kPurpleColour
        ));
  }

  
}
