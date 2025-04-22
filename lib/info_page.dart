import 'package:flutter/material.dart'; // استيراد مكتبة Flutter لإنشاء الواجهة الرسومية

// ✅ كلاس يمثل صفحة المعلومات عن الاستدامة
class InfoPage extends StatefulWidget {
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  bool isDarkMode = false; // متغير لإدارة الوضع الداكن

  // دالة للتبديل بين الوضع الداكن والوضع الفاتح
  void toggleDarkMode() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDarkMode ? Colors.black : Colors.green, // لون AppBar بناءً على الوضع
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.wb_sunny : Icons.nightlight_round), // تغيير الأيقونة بناءً على الوضع
            onPressed: toggleDarkMode, // تبديل الوضع الداكن
          ),
        ],
      ),
      backgroundColor: isDarkMode ? Colors.black87 : Colors.lightGreen[100], // لون الخلفية بناءً على الوضع
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // ✅ عنوان رئيسي للصفحة
                Text(
                  "🌱 Understanding Sustainability",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black, // لون النص بناءً على الوضع
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),

                // ✅ الفقرة الرئيسية حول الاستدامة
                Text(
                  "Sustainability is about creating a balance between the environment, economy, and society to ensure a better future for all. "
                  "It focuses on using natural resources wisely to prevent depletion and environmental harm. One of the biggest threats to sustainability is carbon dioxide (CO₂) emissions, "
                  "which contribute to global warming. These emissions come from burning fossil fuels, deforestation, and industrial activities. Reducing our carbon footprint by using public transportation, "
                  "conserving energy, and switching to renewable energy sources like solar and wind power can help mitigate climate change.\n\n"
                  
                  "Another critical aspect of sustainability is waste management. Recycling plays a significant role in reducing pollution by turning used materials into new products, "
                  "preventing them from ending up in landfills. Items like paper, plastic, glass, and metals can be recycled, reducing the need for raw materials and minimizing environmental damage. "
                  "Biodegradable materials, such as food waste and wood, naturally decompose, while non-biodegradable waste, like plastic and Styrofoam, takes centuries to break down and causes long-term pollution.\n\n"
                  
                  "Water conservation is also essential for sustainability. Many regions around the world face water shortages, and small actions like fixing leaks, turning off taps when not in use, "
                  "and using water-efficient appliances can significantly reduce water waste. Protecting forests by planting trees instead of cutting them down helps maintain biodiversity, absorb CO₂, and improve air quality.\n\n"
                  
                  "A practical approach to sustainability is following the 3R principle: Reduce, Reuse, and Recycle. Reducing unnecessary consumption, reusing items whenever possible, "
                  "and recycling waste materials can significantly decrease environmental damage. Choosing eco-friendly alternatives, such as reusable fabric bags instead of plastic ones, further supports sustainability efforts. "
                  "By making conscious decisions in daily life, such as using energy-efficient appliances, minimizing waste, and supporting renewable energy, individuals can contribute to a more sustainable and healthier planet. 🌍💚",
                  style: TextStyle(
                    fontSize: 18,
                    color: isDarkMode ? Colors.white70 : Colors.black, // لون النص بناءً على الوضع
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}