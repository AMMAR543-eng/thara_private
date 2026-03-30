import '../../../../../index/index_main.dart';

class DepositesListViewWidget extends StatelessWidget {
  final ProcessController controller;

  const DepositesListViewWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final List<DepositeEntity> items = controller.depositeDataEntity?.items ?? [];

    if (items.isEmpty) {
      return PlaceholderImage(
        image: Images.no_data,
        messege: "no_data".tr,
        isAsset: true,
      );
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final DepositeEntity item = items[index];

        final String ref = item.ref ?? "—";
        final String sourceIban = item.sourceIban ?? "—";
        final bool knownSource = item.knownSource ?? false;
        final String accountLabel =
        knownSource ? "investment_account".tr : "unknown_source".tr;

        final double amount = double.tryParse(item.amount ?? "0") ?? 0;
        final String formattedAmount = amount.toStringAsFixed(2);
        final String date = item.date ?? "-";

        return DepositCard(
          ref: ref,
          accountLabel: accountLabel,
          sourceIban: sourceIban,
          formattedAmount: formattedAmount,
          date: date,
        );
      },
    );
  }
}
