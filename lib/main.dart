import 'package:admob_localization_app/view/screens/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'const/strings.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'data/app_localizations.dart';
import 'logic/change_lang_cubit/change_lang_cubit.dart';
import 'logic/test_counter_bloc/counter_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  RequestConfiguration configuration = RequestConfiguration(
    testDeviceIds: [testDeviceIdString],
  );

  MobileAds.instance.updateRequestConfiguration(configuration);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ChangeLangCubit>(
          create: (BuildContext context) => ChangeLangCubit()..getChosenLang(),
        ),
        BlocProvider<CounterCubit>(
          create: (BuildContext context) => CounterCubit(),
        ),
      ],
      child: BlocBuilder<ChangeLangCubit, ChangeLangState>(
        builder: (context, state) {
          String languageCode = ChangeLangCubit.get(context).theChosenLange;
          return MaterialApp(
            locale: Locale(languageCode),
            supportedLocales: const [
              Locale('en'),
              Locale('ar'),
            ],
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            localeResolutionCallback: (devicLang, supportedLang) {
              for (Locale local in supportedLang) {
                if (devicLang != null &&
                    local.languageCode == devicLang.languageCode) {
                  return devicLang;
                }
              }

              return supportedLang.first;
            },
            debugShowCheckedModeBanner: false,
            title: 'admob',
            home: const HomeView(),
          );
        },
      ),
    );
  }
}
