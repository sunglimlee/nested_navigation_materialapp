import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  // [error] Avoid using private types in public APIs.
/*
  [answer]
  From the latest docs:

  Subclasses should override this method to return a newly created
  instance of their associated [State] subclass:

  @override
  State<MyWidget> createState() => _MyWidgetState();
  So you should replace

  @override
  _AnimatedContainerAppState createState() => _AnimatedContainerAppState();
  with

  @override
  State<AnimatedContainerApp> createState() => _AnimatedContainerAppState();
*/

  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Route _onRoute(RouteSettings settings) {
    final str = settings.name!.split("/")[1];
    print("lsl ${settings.name}"); // 왜 str 에 아무것도 없을 까?
    final index = int.parse(str);

    return MaterialPageRoute(
        builder: (BuildContext context) => Home(index: index));
  }

  @override
  Widget build(BuildContext context) {
    final navigatorKey = GlobalKey<NavigatorState>(); // _navigatorKey 가 있어야 navigation 을 할 수 있다.
    return Column(
      children: <Widget>[
        Expanded(
          child: MaterialApp( // 컬럼이 따로 만들어져 있다.
            title: 'Flutter Demo',
            initialRoute: '0/1',
            onGenerateRoute: _onRoute,
            debugShowCheckedModeBanner: false,
            key: navigatorKey,
          ),
        ),
        Container(
          height: 44.0,
          color: Colors.blueAccent,
          child: const Center(
            child: Text("permanent view", textDirection: TextDirection.ltr),
          ),
        )
      ],
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key, this.index}) : super(key: key);
  final int? index;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text("View $index"),
    ),
    body: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text("View $index"),
          ElevatedButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed("/${index! + 1}"),
              child: const Text("Push")),
          SizedBox.fromSize(size: const Size.fromHeight(50),),
          if(index != 1)
          ElevatedButton(onPressed: () => Navigator.of(context).pop()
              , child: const Text("Pop"))
        ],
      ),
    ),
  );
}

void main() {
  runApp(
    const MyApp(),
  );
}