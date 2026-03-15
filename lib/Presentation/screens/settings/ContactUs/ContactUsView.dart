import 'dart:math' as math;
import 'package:thara/Presentation/screens/settings/ContactUs/ContatctUsViewModel.dart';
import '../../../../index/index_main.dart';
import 'contact_section_widget.dart';

class ContactUsView extends StatefulWidget {
  const ContactUsView({Key? key}) : super(key: key);

  @override
  State<ContactUsView> createState() => _ContactUsViewState();
}

class _ContactUsViewState extends State<ContactUsView> {
  final _contactGlobalKey = GlobalKey<FormState>();
  final FocusNode myFocusNode = FocusNode();
  final colors = ColorMappingImpl();

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.backgroundDefault,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 1,
        centerTitle: true,
        title: Text(
          "contact_us".tr,
          style: context.typography.myriadSemi46Black.copyWith(
            color: colors.background_black_default,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: GetBuilder<ContatcusVieWModel>(
            init: ContatcusVieWModel(),
            builder: (controller) {
              final map = controller.infoMap;

              return Form(
                key: _contactGlobalKey,
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  children: [
                    // Text("select_inquiry_type".tr, style: ...),
                    // _buildDropdown(controller),
                    // Text("write_message_here".tr, style: ...),
                    // _buildMessageField(controller),
                    // _buildSubmitButton(controller),
                    ContactSectionWidget(map: map),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown(ContatcusVieWModel controller) {
    return Container(
      decoration: BoxDecoration(
        color: colors.background_neutral_100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.borderNeutralPrimary),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<Contatctus_TypesModel>(
          isExpanded: true,
          dropdownColor: colors.backgroundDefault,
          value: controller.contactTypes.first,
          icon: const Icon(Icons.arrow_drop_down),
          style: context.typography.font33Grey.copyWith(
            color: colors.textDisplay,
          ),
          onChanged: (newValue) {
            controller.setSelectedType(newValue!.value);
          },
          items: controller.contactTypes.map((type) {
            return DropdownMenuItem(
              value: type,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  type.text.tr,
                  style: context.typography.font49Grey.copyWith(
                    color: colors.textDisplay,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildMessageField(ContatcusVieWModel controller) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      cursorColor: colors.primaryButtonDefault,
      focusNode: myFocusNode,
      maxLines: 6,
      minLines: 4,
      decoration: InputDecoration(
        hintText: "write_message_here".tr,
        fillColor: colors.background_neutral_100,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: colors.borderNeutralPrimary),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: colors.primaryButtonDefault),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: colors.borderNeutralPrimary),
        ),
      ),
      onChanged: (value) {
        controller.message.value = value;
      },
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'message_required'.tr;
        } else if (value.length > 250) {
          return 'message_max_length'.tr;
        }
        return null;
      },
    );
  }

  Widget _buildSubmitButton(ContatcusVieWModel controller) {
    return Obx(
          () => PrimaryTextButton(
        appButtonSize: AppButtonSize.xlarge,
        onTap: controller.message.value.isEmpty
            ? null
            : () {
          if (_contactGlobalKey.currentState!.validate()) {
            // Trigger submit logic
          }
        },
        label: Text("send".tr, style: context.typography.myriadSemi46Black),
      ),
    );
  }
}
