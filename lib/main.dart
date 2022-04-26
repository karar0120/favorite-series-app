import 'package:flutter/material.dart';
import 'package:imdb/Routes/App_router.dart';

import 'Constants/String_Constants.dart';

void main() {
  runApp(BreakingBad(
    appRouter: AppRouter(),
  ));
}

class BreakingBad extends StatelessWidget {
  final AppRouter appRouter;

  const BreakingBad({Key? key, required this.appRouter}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: CharactersScreen,
      onGenerateRoute: appRouter.genrateRoute,
    );
  }
}
