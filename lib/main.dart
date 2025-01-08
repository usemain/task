import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:usemain/providers/config.dart';
import 'package:usemain/routes/index.dart';
import 'package:usemain/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ConfigProvider configProvider = ConfigProvider();
  await init(configProvider);
  runApp(MainPage(configProvider: configProvider));
}

Future<void> init(ConfigProvider configProvider) async {
  bool? theme = (await SharedPreferences.getInstance()).getBool("Theme");
  configProvider.setTheme(theme ?? true);
}

class MainPage extends StatefulWidget {
  final ConfigProvider configProvider;

  const MainPage({
    super.key,
    required this.configProvider,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: widget.configProvider),
      ],
      child: Consumer<ConfigProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            title: 'core',
            initialRoute: '/',
            onGenerateRoute: routes,
            theme: initTheme(provider),
            locale: const Locale('zh', 'CH'),
            debugShowCheckedModeBanner: false,
            themeAnimationDuration: Duration.zero,
            themeAnimationStyle: AnimationStyle(
              curve: Curves.linear,
              duration: Duration.zero,
            ),
            scrollBehavior: CustomScrollBehavior(),
            supportedLocales: const [
              Locale('zh', 'CH'),
              Locale('en', 'US'),
            ],
            localizationsDelegates: const [
              GlobalWidgetsLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
          );
        },
      ),
    );
  }
}

class CustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Widget buildScrollbar(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }

  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }
}
