import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:quraan_app/models/quran_data.dart';
import 'package:quraan_app/view/screen/surah_list_screen.dart';

class QuranApp extends StatelessWidget {
  const QuranApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'القرآن الكريم',
      locale: const Locale('ar', 'SA'),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ar', 'SA'),
      ],
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF1E4D2B),   
          secondary: Color(0xFF2A593C),   
          tertiary: Color(0xFFCFA53E),    
          surface: Colors.white,
          onSurface: Color(0xFF1A1A1A),
        ),
        scaffoldBackgroundColor: const Color(0xFFFBFDF8),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(
            color: Color(0xFF1E4D2B),
            size: 24,
          ),
          titleTextStyle: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1E4D2B),
          ),
        ),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E4D2B),
          ),
          titleLarge: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1E4D2B),
          ),
          bodyLarge: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Color(0xFF1A1A1A),
          ),
          bodyMedium: TextStyle(
            fontSize: 26,
            color: Color(0xFF1A1A1A),
            height: 1.8,
          ),
        ),
        cardTheme: CardTheme(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: Colors.white,
          surfaceTintColor: Colors.white,
          shadowColor: const Color(0xFF1E4D2B).withOpacity(0.08),
        ),
        dividerTheme: DividerThemeData(
          color: const Color(0xFF1E4D2B).withOpacity(0.1),
          thickness: 1,
        ),
        iconTheme: const IconThemeData(
          color: Color(0xFF1E4D2B),
          size: 24,
        ),
      ),
      home: SurahListScreen(quranList: quranList),
    );
  }
}
