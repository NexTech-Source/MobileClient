import 'package:flutter/material.dart';
import 'package:edge_detection/edge_detection.dart';
import 'package:image_picker/image_picker.dart';
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
    return Scaffold(body: Column(
      children: [
        const Padding(padding: EdgeInsets.only(top:40),),
        welcomeText(),
        addDocCard(context),
        const Padding(padding: EdgeInsets.only(top:20),),
        addDocCard2(context),


      ],
    ));
  }

  Widget addDocCard2(context)
  {
   return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            title: const Text('Add Document'),
            subtitle: const Text('Add a document to the system'),
            trailing: const Icon(Icons.add),
            onTap: () async {
              final ImagePicker _picker = ImagePicker();
              final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
              print("got the pic");
            },
          ),
        ],
      ),
    );
  }

  Widget welcomeText()
  {
    return const Text("Welcome back User!" , style: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
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
              String imagePath = await EdgeDetection.detectEdge ?? "";
              print(imagePath);
            },
          ),
        ],
      ),
    );
  }
}
