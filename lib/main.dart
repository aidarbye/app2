import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medimom/app/presentation/check_lists/util/check_list_notifier.dart';
import 'package:medimom/app/presentation/check_lists/util/notification_service.dart';
import 'package:medimom/app/presentation/checklist/utils/checklistnotifier.dart';
import 'package:medimom/app/presentation/doctors/doctor_consumer.dart';
import 'package:medimom/app/presentation/splash/SplashPage.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  
  tz.initializeTimeZones();
  await NotificationService.instance.initNotifications();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CheckListSelectingNotifier()),
        ChangeNotifierProvider(create: (_) => CheckListSelectingCalendarNotifier()),
        ChangeNotifierProvider(create: (_) => CheckListSelectingCalendarWithNotifyNotifier()),
        ChangeNotifierProvider(create: (_) => MapNotifier()),
        ChangeNotifierProvider(create: (_) => DoctorMapNotifier()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        locale: Locale("ru","RU"),
        home: SplashPage()
      )
    )
  );
}