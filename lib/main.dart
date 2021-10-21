import 'dart:io';
import 'package:crop_sales_app/screen//login/seller_login_page.dart';
import 'package:crop_sales_app/screen//main/initial_page.dart';
import 'package:crop_sales_app/screen/main/main_page_seller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:crop_sales_app/styles/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screen/main/main_page_buyer.dart';
import 'screen/main/store/main_provider.dart';
import 'screen/cart/store/shopping_cart_global_provider.dart';

Future<void> main() async {
  // InitializeAPP These two lines
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Determines if you are logged in.
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLogin = prefs.getBool('isLogin') ?? false;
  print('isLogin or not : ' + isLogin.toString());
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MainProvider()),
        ChangeNotifierProvider(create: (_) => ShopingCartGlobalProvider()),
      ],
      child: MyApp(
        isLogin: isLogin,
      ),
    ),
  );
  //
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle =
    SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  final isLogin;
  const MyApp({Key? key, this.isLogin}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: RefreshConfiguration(
        child: MaterialApp(
          title: 'LTID',
          localizationsDelegates: [
            RefreshLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('en'),
            const Locale('jp'),
          ],
          localeResolutionCallback:
              (Locale? locale, Iterable<Locale> supportedLocales) {
            return locale;
          },
          theme: ThemeData(
            primarySwatch: Colors.purple,
            primaryColor: AppColors.primaryColor,
            accentColor: AppColors.primaryColorAccent,
          ),
          debugShowCheckedModeBanner: false,
          home: isLogin ? BuyerMainPage() : InitialPage(),
        ),
      ),
    );
  }
}

/*
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
*/
