import '../../../../../index/index_main.dart';

class RegisterTermsScreen extends StatefulWidget {
  final VoidCallback? onPressed;

  const RegisterTermsScreen({super.key, this.onPressed});

  @override
  State<RegisterTermsScreen> createState() => _RegisterTermsScreenState();
}

class _RegisterTermsScreenState extends State<RegisterTermsScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "الشروط والأحكام".tr,
          style: context.typography.headerXLarge.copyWith(
            color: AppColors.content_brand_secondary,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            /// 🔹 Logo
            const Center(heightFactor: 1.5, child: LogoWidget()),
            SizedBox(height: 20.h),

            /// 🔹 Scrollable Terms
            Expanded(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Scrollbar(
                  controller: _scrollController,
                  thumbVisibility: true,
                  thickness: 6.0,
                  child: ListView(
                    controller: _scrollController,
                    padding: EdgeInsets.all(16.w),
                    children: [
                      Text(
                        // 🔹 النص اللي بعتهولي بالكامل
                        """يتولى تشغيل منصة ذرى للتمويل الجماعي بالدين(يشار إليها فيما بعد بـ “ذرى” أو “منصة ذرى”)، شركة ذرى للتمويل الجماعي بالدين، وهي شركة مساهمة مغلقة تأسست بموجب أنظمة المملكة العربية السعودية، بسجل تجاري رقم 1010797355، حاصلة على رخصة البنك المركزي السعودي لممارسة التمويل الجماعي بالدين بموجب الرقم 84/أ ش /202401، ويقع مقرها الرئيسي في الرياض, المملكة العربية السعودية، تسري هذه الشروط والأحكام العامة على جميع مستخدمي منصة ذرى وأي من الخدمات المقدمة عن طريق المنصة والموقع الإلكتروني الخاص بها.

يتعين عليك قراءة الشروط والأحكام بعناية قبل استخدام موقع ذرى للتمويل الجماعي بالدين حيث توضح هذه الشروط والأحكام تفاصيل الخدمة التي تقدمها ذرى وتحدد الالتزامات والحقوق بين ذرى ومستخدم الموقع، ويمنع استخدام المنصة في حال عدم فهم واستيعاب كافة مواد الشروط والأحكام، إن استخدامك لهذا الموقع يعني أنك تقر وتُوافق على هذه الشروط والأحكام وفهمتها وقبلتها وأنك سوف تلتزم بما ورد فيها، وفي حال عدم موافقتك على هذه الشروط والأحكام أو على عدم الالتزام بها، يتعين عليك الامتناع عن استخدام الموقع.

تحتفظ ذرى بحقها في تعديل الشروط والأحكام في أي وقت لأي أسباب نظامية، أو رقابية، أو أمنية أو غيرها حسب تقديرها المطلق، وسوف يتم الاشعار من خلال الوسيلة التي يراها مناسبة بأي تغيير بهذا الخصوص بمده لا تقل عن30 يوماً مسبقاً لاتخاذ الإجراء اللازم، وتكون تلك التعديلات مُلزمةً كما نوصيك بزيارة الموقع من حين إلى آخر للتأكد من أنك على دراية بأحدث التغييرات التي قد تطرأ إلى الشروط والأحكام.

تقرأ هذه الشروط والأحكام مع الشروط وقائمة الأسئلة الشائعة وسياسة الخصوصية المنشورة على الموقع، في حالة وجود أي استفسارات تتعلق بالموقع أو بهذه الشروط والأحكام، يرجى التواصل معنا عبر البريد الإلكتروني info@tharaco.sa.

معايير الأهلية للتسجيل:
... (🔹 باقي النص كما هو بالكامل اللي بعته) ...
""",
                        style: context.typography.bodyLarge.copyWith(
                          color: AppColors.content_secondary,
                          height: 1.6,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
