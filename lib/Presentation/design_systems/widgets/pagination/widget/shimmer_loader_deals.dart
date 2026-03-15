import 'package:flutter/material.dart';
import '../../../../screens/dashboard/widgets/shimmer_widget.dart';

class ShimmerLoaderDeals extends StatelessWidget {
  const ShimmerLoaderDeals({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      shrinkWrap: true,
      itemCount: 6, // Number of shimmer placeholders
      itemBuilder: (context, index) {
        return const ForseItemShimmerWidget();
      },
    );
  }
}
