import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Color.fromRGBO(0, 255, 0, 1.0)),  // alternatively, Colors.deepOrange, etc.
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    return Scaffold(
      body: Center(  // wrap to horizontally center
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,  // to vertically center
          children: [
            Text('A random AWESOME idea from SEGS:'),
            BigCard(pair: pair),
            SizedBox(height: 10),  // visual spacing between BigCard and ElevatedButton
            ElevatedButton(
              onPressed: () {
                // print('button pressed')
                appState.getNext();
              },
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary  // defines a color (for the text in this case) that is a good fit for use on the app's primary color
    );

    return Card(
      color: theme.colorScheme.primary,
      elevation: 5,  // shadow of the BigCard
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          pair.asSnakeCase,
          style: style,
          semanticsLabel: "${pair.first} ${pair.second}",  // accessibility: for screen readers to correctly pronounce each generated word pair
        ),
      ),
    );
  }
}