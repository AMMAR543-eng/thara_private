import '../../../index/index_main.dart';

class RootBlockedApp extends StatelessWidget {
  const RootBlockedApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Text(
            '⚠️ هذا الجهاز يحتوي على صلاحيات Root\nلا يمكن تشغيل التطبيق لأسباب أمنية.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.redAccent,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
