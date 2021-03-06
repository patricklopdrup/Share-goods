import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:share_goods/models/user.dart';
import 'package:share_goods/screens/auth/authentication_handler.dart';
import 'package:share_goods/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //root widget of the app
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return StreamProvider<LocalUser>.value(
      //Specify Stream to listen to
      value: AuthService().user,
      //StreamProvider listen to a Stream and wraps MaterialApp
      //Anything inside (Wrapper) can access data provided from Stream
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => AuthenticationHandler()
        },
      ),
    );
  }
}
