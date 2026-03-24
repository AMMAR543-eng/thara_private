import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../index/index.dart';

class HandleKeyboardService {
  static final HandleKeyboardService _instance =
      HandleKeyboardService._internal();

  factory HandleKeyboardService() => _instance;

  HandleKeyboardService._internal();

  /// Map to store focus nodes with unique keys
  final Map<String, FocusNode> _focusNodes = {};

  /// Retrieve a FocusNode using a unique key
  FocusNode getFocusNode(String key) {
    if (!_focusNodes.containsKey(key)) {
      _focusNodes[key] = FocusNode();
    }
    return _focusNodes[key]!;
  }

  /// Builds a keyboard configuration with a "Done" button
  KeyboardActionsConfig buildConfig(BuildContext context, List<String> keys) {
    return KeyboardActionsConfig(
      keyboardBarColor: Colors.grey[100],
      nextFocus: true,
      defaultDoneWidget: TextButton(
        onPressed: () => FocusScope.of(context).unfocus(),
        child: Text(
          "done".tr,
          style: context.typography.bodyMedium.copyWith(color: AppColors.white),
        ),
      ),
      actions: keys
          .map(
            (key) => KeyboardActionsItem(
              focusNode: getFocusNode(key),
              toolbarButtons: [
                (node) {
                  return TextButton(
                    onPressed: () => node.unfocus(),
                    child: Text(
                      "done".tr,
                      style: context.typography.bodyMedium.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                  );
                },
              ],
            ),
          )
          .toList(),
    );
  }

  List<String> generateKeys(String screenName, int fieldCount) {
    return List.generate(fieldCount, (index) => '${screenName}_$index');
  }

  /// Dispose all focus nodes
  void dispose() {
    for (var node in _focusNodes.values) {
      node.dispose();
    }
    _focusNodes.clear();
  }
}

class GenericKeyboardManager<T> {
  final int nodeCount;
  final List<FocusNode> _focusNodes = [];

  GenericKeyboardManager({required this.nodeCount}) {
    _initializeFocusNodes();
  }

  /// Initialize focus nodes based on the given size
  void _initializeFocusNodes() {
    for (int i = 0; i < nodeCount; i++) {
      _focusNodes.add(FocusNode());
    }
  }

  /// Dispose all focus nodes properly
  void dispose() {
    for (var node in _focusNodes) {
      node.dispose();
    }
  }

  /// Get a specific FocusNode by index
  FocusNode getFocusNode(int index) {
    if (index < 0 || index >= _focusNodes.length) {
      throw Exception(
        'Index out of range. Max index is ${_focusNodes.length - 1}.',
      );
    }
    return _focusNodes[index];
  }

  /// Build KeyboardActionsConfig dynamically
  KeyboardActionsConfig buildConfig() {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: Colors.grey[200],
      nextFocus: true,
      actions: _focusNodes
          .map((node) => KeyboardActionsItem(focusNode: node))
          .toList(),
    );
  }

  /// Return the total number of FocusNodes created
  int get totalNodes => _focusNodes.length;
}
