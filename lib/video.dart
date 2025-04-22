import 'package:flutter/material.dart'; // استيراد مكتبة Flutter لإنشاء واجهة المستخدم
import 'package:video_player/video_player.dart'; // استيراد مكتبة تشغيل الفيديو

// ✅ تعريف كلاس الصفحة التي تعرض الفيديو
class VideoPage extends StatefulWidget {
  @override
  _VideoPageState createState() => _VideoPageState(); // إنشاء حالة للصفحة
}

// ✅ كلاس الحالة (State) لصفحة الفيديو
class _VideoPageState extends State<VideoPage> {
  late VideoPlayerController _controller; // تعريف متغير للتحكم في تشغيل الفيديو
  bool isDarkMode = false; // متغير للتحكم في وضع الشاشة

  void toggleDarkMode() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset("assets/green.mp4") // تحميل الفيديو من `assets`
      ..initialize().then((_) { // تهيئة الفيديو عند تحميل الصفحة
        setState(() {}); // تحديث حالة التطبيق بعد التهيئة
        _controller.play(); // تشغيل الفيديو تلقائيًا عند فتح الصفحة
      });
  }

  @override
  void dispose() {
    _controller.dispose(); // إيقاف تشغيل الفيديو عند مغادرة الصفحة
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( // ✅ شريط التطبيق العلوي
        backgroundColor: isDarkMode ? Colors.black : Colors.green, // تغيير اللون حسب الوضع
        leading: IconButton( // أيقونة الرجوع
          icon: Icon(Icons.arrow_back, color: Colors.white), // أيقونة الرجوع بلون أبيض
          onPressed: () => Navigator.pop(context), // الرجوع عند الضغط على السهم
        ),
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.wb_sunny : Icons.nightlight_round),
            onPressed: toggleDarkMode,
          ),
        ],
      ),
      backgroundColor: isDarkMode ? Colors.black87 : Colors.lightGreen[100], // ✅ تغيير لون الخلفية حسب الوضع
      body: Center( // ✅ وضع الفيديو في منتصف الشاشة
        child: _controller.value.isInitialized // التحقق مما إذا كان الفيديو جاهزًا للتشغيل
            ? AspectRatio( // ✅ الحفاظ على نسبة العرض إلى الارتفاع للفيديو
                aspectRatio: _controller.value.aspectRatio, // ضبط الفيديو حسب أبعاده الأصلية
                child: VideoPlayer(_controller), // عرض الفيديو
              )
            : CircularProgressIndicator(), // عرض مؤشر تحميل أثناء تحميل الفيديو
      ),
    );
  }
}
