import '../../../../../../index/index_main.dart';

class AddressItemWidget extends StatelessWidget {
  final AddressEntity address;
  final bool isSelected;
  final VoidCallback onTap;

  const AddressItemWidget({
    Key? key,
    required this.address,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.grayLight.withOpacity(0.15)
              : AppColors.grayLight.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.grayLight,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Radio<AddressEntity>(
              value: address,
              groupValue: isSelected ? address : null,
              onChanged: (_) => onTap(),
              activeColor: AppColors.primary,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildText("city".tr, address.city, context),
                  _buildText("district".tr, address.district, context),
                  _buildText("street".tr, address.street, context),
                  _buildText(
                      "building_number".tr, address.buildingNumber, context),
                  if (address.isPrimary)
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Row(
                        children: [
                          const Icon(Icons.check_circle,
                              color: Colors.green, size: 18),
                          const SizedBox(width: 4),
                          Text(
                            "primary_address".tr,
                            style: context.typography.font33Grey.copyWith(
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildText(String label, String value, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: context.typography.font33Grey.copyWith(
              color: AppColors.background_black,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: context.typography.font40White.copyWith(
                color: AppColors.background_black,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
