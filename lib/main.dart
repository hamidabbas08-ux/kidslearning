import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'core/storage/save_system.dart';
import 'core/services/error_handler.dart';
import 'core/routes/app_routes.dart';

void main() {
  ErrorHandler.initialize();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SaveSystem()),
      ],
      child: const KidsLearningApp(),
    ),
  );
}

class KidsLearningApp extends StatelessWidget {
  const KidsLearningApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kids Learning Adventure',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.cartoonTheme,
      initialRoute: AppRoutes.splash,
      onGenerateRoute: AppRoutes.generateRoute,
      builder: (context, widget) {
        ErrorWidget.builder = (FlutterErrorDetails details) {
          return ErrorHandler.buildErrorWidget(context, details.exception);
        };
        return widget ?? const SizedBox.shrink();
      },
    );
  }
}
