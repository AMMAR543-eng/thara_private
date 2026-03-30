import 'package:thara/Presentation/screens/authentication/register/kyc/widgets/build_bool_widget.dart';
import 'package:thara/Presentation/screens/authentication/register/kyc/widgets/build_files_widgets.dart';
import 'package:thara/Presentation/screens/authentication/register/kyc/widgets/build_single_choice.dart';

import '../../../../../../index/index_main.dart';
import 'build_multiple_choice_widget.dart';
import 'build_text_widget.dart';

class BuildKYCWidget extends StatefulWidget {
  final KycItemEntity question;
  GenericKeyboardManager<String>? manager;
  final KYCController kycController;

  BuildKYCWidget({
    super.key,
    required this.question,
    this.manager,
    required this.kycController,
  });

  @override
  State<BuildKYCWidget> createState() => _BuildKYCWidgetState();
}

class _BuildKYCWidgetState extends State<BuildKYCWidget> {
  @override
  Widget build(BuildContext context) {
    switch (widget.question.type) {
      case 'text':
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: BuildTextWidget(
            kycController: widget.kycController,
            question: widget.question,
            keyboardType: TextInputType.text,
          ),
        );
      case 'number':
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          child: BuildTextWidget(
            kycController: widget.kycController,
            question: widget.question,
            keyboardType: TextInputType.number,
            focusNode: widget.manager?.getFocusNode(0),
          ),
        );
      case 'bool':
        return BuildBoolWidget(
          kycController: widget.kycController,
          question: widget.question,
        );

      case 'single_choice':
        return BuildSingleChoiceWidget(
          kycController: widget.kycController,
          question: widget.question,
        );
      case 'multi_choice':
        return BuildMultipleChoiceWidget(
          kycController: widget.kycController,
          question: widget.question,
        );
      case 'file':
        return BuildFileWidget(
          kycController: widget.kycController,
          question: widget.question,
        );
      default:
        return const SizedBox();
    }
  }
}
