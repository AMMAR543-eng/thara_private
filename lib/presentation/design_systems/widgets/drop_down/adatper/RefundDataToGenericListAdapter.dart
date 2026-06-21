import '../../../../../index/index_main.dart';

/// Adapter utility for BankAccount_Entity to GenericListModel
class BankAccountAdapterUtil {
  /// Convert a single `BankAccount_Entity` to `GenericListModel`
  static GenericListModel toGeneric(BankAccount_Entity entity) {
    return GenericListModel(
      id: entity.id ?? 0,
      name: entity.label ?? entity.alias ?? "بدون اسم",
      text: entity.iban ?? "", // or use accountNumber
    );
  }

  /// Convert a list of `BankAccount_Entity` to List<GenericListModel>
  static List<GenericListModel> toGenericList(List<BankAccount_Entity> list) {
    return list.map((e) => toGeneric(e)).toList();
  }
}
