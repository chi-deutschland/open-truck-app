import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:trucker_app/config.dart';
import 'package:trucker_app/home_tab.dart';
import 'package:trucker_app/screens/ladung.dart';
import 'package:trucker_app/screens/piece_details.dart';
import 'package:trucker_app/screens/piece_photo_screen.dart';
import 'package:trucker_app/screens/tour.dart';
import 'providers/camera_provider.dart';
import 'providers/tour_details_provider.dart';
import 'screens/camera_stream.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const TruckerApp());
}

class TruckerApp extends StatelessWidget {
  const TruckerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// To set orientation always portrait
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: TourDetailsProvider(),
        ),
        ChangeNotifierProvider.value(
          value: CameraProvider(),
        ),
      ],
      child: CupertinoApp(
          debugShowCheckedModeBanner: false,
          theme: const CupertinoThemeData(
            brightness: Brightness.light,
            primaryColor: backgroundColor,
          ),
          // Start the app with the "/" named route. In this case, the app starts
          // on the FirstScreen widget.
          // initialRoute: '/',
          routes: {
            // When navigating to the "/" route, build the LoginScreen widget.
            '/': (context) => HomeTab(),
            '/tour': (context) => const TourScreen(),
            '/camera': (context) => CameraStream(),
            '/piece': (context) => const PieceDetails(),
            '/piece_photo': (context) => PiecePhotoScreen(),
            '/ladung': (context) => const LadungScreen(),
          }),
    );
  }
}
