import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'ChangeNamePopUp.dart';
import 'InventoryPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Thomas Inventory',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,

        primaryColor: Colors.white, // These are the color of the ISATI
        cardColor: Colors.white,

        appBarTheme: const AppBarTheme(
          color: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          elevation: 0,
        ),

        textTheme: TextTheme(
            headline1: GoogleFonts.lato(
                fontSize: 48.0,
                fontWeight: FontWeight.w800,
                color: Colors.black87),
            headline2: GoogleFonts.lato(
                fontSize: 24.0,
                fontWeight: FontWeight.w300,
                color: Colors.black87),
            subtitle1: GoogleFonts.lato(
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
        '/': (context) => const MyHomePage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  static MaterialColor randomMaterialColor() {
    return Colors.primaries[Random().nextInt(Colors.primaries.length)];
  }

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Inventory> inventories = [];

  addInventory(String newName) {
    setState(() {
      inventories.add(Inventory(
        mainColor: MyHomePage.randomMaterialColor(),
        secondColor: MyHomePage.randomMaterialColor(),
        title: newName,
        removeInventory: () => removeInventory(inventories.length-1),
      ));
    });
  }
  addAndRequestInventory() {
    ChangeNamePopUp()
        .show(context, "Entrez le nom de l'inventaire", "", addInventory);
  }
  removeInventory(int index) {
    print(index);
    setState(() {
      inventories.removeAt(index);
    });
    Navigator.of(context).pop(context);
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
              child: Text(
                'Stock',
                style: Theme.of(context).textTheme.headline1,
              ),
            ), //Title of the App
            Expanded(
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                child: ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
                  itemBuilder: (context, index) => SizedBox(
                    height: 75,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(
                              width: 5.0, color: inventories[index].mainColor),
                        ),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: TextButton(
                        style: ButtonStyle(
                          //Col: Colors.transparent,
                          overlayColor: MaterialStateProperty.all(
                              inventories[index].mainColor),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => inventories[index]));
                        },
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              20, 0, 20, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "#${index + 1}",
                                style: Theme.of(context).textTheme.headline2,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                inventories[index].title,
                                style: Theme.of(context).textTheme.headline2,
                              ),
                              const Spacer(
                                flex: 1,
                              ),
                              Icon(
                                Icons.arrow_forward_ios_sharp,
                                size: Theme.of(context)
                                    .textTheme
                                    .headline2
                                    ?.fontSize,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  itemCount: inventories.length,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addAndRequestInventory,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
