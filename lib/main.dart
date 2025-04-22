import 'package:flutter/material.dart'; // استيراد مكتبة Flutter لبناء واجهات المستخدم
import 'package:provider/provider.dart'; // استيراد Provider لإدارة الحالة
import 'quiz_page.dart'; // استيراد صفحة اللعبة
import 'info_page.dart'; // استيراد صفحة المعلومات
import 'video.dart'; // استيراد صفحة الفيديو

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light; // الوضع الافتراضي: عادي

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme() {
    themeMode = isDarkMode ? ThemeMode.light : ThemeMode.dark;
    notifyListeners(); // تحديث الواجهة بعد التغيير
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: SustainabilityApp(),
    ),
  );
}

// ✅ الكلاس الرئيسي للتطبيق
class SustainabilityApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: themeProvider.themeMode,
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.lightGreen[100], // تحديث لون الخلفية هنا
        textTheme: TextTheme(
          bodyLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Verdana'),
          bodyMedium: TextStyle(fontSize: 16, fontFamily: 'Verdana'),
          titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Verdana'),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.black, // لون الخلفية في الوضع الداكن
        textTheme: TextTheme(
          bodyLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'Verdana'),
          bodyMedium: TextStyle(fontSize: 16, color: Colors.white, fontFamily: 'Verdana'),
          titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'Verdana'),
        ),
      ),
      home: MainMenu(),
    );
  }
}

// ✅ شاشة القائمة الرئيسية
class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor, // استخدام لون الخلفية المحدد في ThemeData
      appBar: AppBar(
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: Icon(themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              themeProvider.toggleTheme(); // التبديل بين الوضعين
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            top: 20,
            left: 20,
            child: Image.asset(
              'assets/logo.png',
              width: 200,
              height: 189,
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Sustainability",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, fontFamily: 'Times New Roman'),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                MainButton(text: "Sustainability Information", onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => InfoPage()));
                }),
                MainButton(text: "Sustainability Game ", onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => QuizPage()));
                }),
                MainButton(text: "Video about sustainability", onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => VideoPage()));
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ✅ كلاس لإنشاء زر رئيسي قابل لإعادة الاستخدام
class MainButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  MainButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          textStyle: TextStyle(fontSize: 18, fontFamily: 'Verdana'),
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
        ),
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}