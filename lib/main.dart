import 'dart:math';
import 'package:flutter/material.dart';
import 'InventoryMember.dart';
import 'InventoryMember_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WEI Inventory Thomas',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,

        primaryColor: Colors.white, // These are the color of the ISATI
        cardColor: Colors.white,

        appBarTheme: const AppBarTheme(
          // color: Colors.white,
          elevation: 0,
        ),

        fontFamily: "Futura Light",

        textTheme: const TextTheme(
            headline1: TextStyle(
                fontSize: 48.0,
                fontWeight: FontWeight.w800,
                color: Colors.black87),
            headline2: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w300,
                color: Colors.black87),
            subtitle1: TextStyle(
                fontSize: 26.0,
                fontWeight: FontWeight.w800,
                color: Colors.black87)),


        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: const Color(0xfff70c36)),
      ),
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => const MyHomePage()
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<InventoryMember> inventories = [
    InventoryMember("Fromage", 2),
    InventoryMember("Cacahuètes", 3),
    InventoryMember("Peluche", 3),
  ];
  
  final List<MaterialColor> inventoriesColors = [
    Colors.primaries[Random().nextInt(Colors.primaries.length)],
    Colors.primaries[Random().nextInt(Colors.primaries.length)],
    Colors.primaries[Random().nextInt(Colors.primaries.length)]
  ];
  final mainColor = Colors.primaries[Random().nextInt(Colors.primaries.length)];
  final secondColor = Colors.primaries[Random().nextInt(Colors.primaries.length)];
  String newName = "";
  addItem(){
    setState(() {
      inventories.add(InventoryMember("TODO", 2));
      inventoriesColors.add(Colors.primaries[Random().nextInt(Colors.primaries.length)]);
    });
  }
  add(int index) {
    setState(() {
      inventories[index] = inventories[index].add();
    });
  }
  remove(int index) {
    setState(() {if (inventories[index].quantity - 1 <= 0) {
      inventories.removeAt(index);
      inventoriesColors.removeAt(index);
    } else {
      inventories[index] = inventories[index].remove();
    }});
  }
  rename(String newName, int index) {
    setState(() {
      inventories[index] = inventories[index].rename(newName);
    });
  }
  editInventoryMemberName(int index) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Entrez le nom du produit"),
          content: TextField(
            onChanged: (value) {
              newName = value;
            },
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Annuler"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Ok"),
              onPressed: () {
                rename(newName, index);
                newName = "";
                Navigator.of(context).pop();
              },
            ),
          ],
        ));
  }
  MaterialColor randomMaterialColor() {
    return Colors.primaries[Random().nextInt(Colors.primaries.length)];
  }

  Color contrastColor(Color iColor) {
    // Calculate the perceptive luminance (aka luma) - human eye favors green color... 
    final double luma = ((0.299 * iColor.red) + (0.587 * iColor.green) + (0.114 * iColor.blue)) / 255;

    // Return black for bright colors, white for dark colors
    return luma > 0.5 ? Colors.black : Colors.white;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 80,
            ), // Box to create padding on the top of the screen
            SizedBox(
              height: 60,
              child : Text(
                'My_Inventory',
                style: Theme.of(context).textTheme.headline1,
              ),
            ), //Title of the inventory
            Row( // Row to create the buttons to rename and remove inventory
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ClipOval(
                  child: Material(
                    color: mainColor,
                    child: InkWell(
                      splashColor: secondColor,
                      onTap: addItem,
                      child: const SizedBox(
                        width: 40,
                        height: 40,
                        child : Icon(Icons.edit, color: Colors.black),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 10,
                ),
                ClipOval(
                  child: Material(
                    color: secondColor,
                    child: InkWell(
                      splashColor: mainColor,
                      onTap: addItem,
                      child: const SizedBox(
                        width: 40,
                        height: 40,
                        child : Icon(Icons.delete, color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                child: GridView.builder(
                  itemBuilder: (context, index) => InventoryMemberWidget(
                      ivm: inventories[index],
                      myColor: inventoriesColors[index],
                      add: () => add(index),
                      remove: () => remove(index),
                      edit: () => editInventoryMemberName(index),
                  ),
                  itemCount: inventories.length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: 5/4,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addItem,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
