import 'package:thara/index/index_main.dart';

/// ---------------------------------------------------------------------------
/// OPPORTUNITY TYPE (Frontend + Backend Mapping)
/// ---------------------------------------------------------------------------
/// Example:
/// name: "فواتير"
/// apiKey: "invoice"
class OpportunityType {
  final int id;
  final String name;
  final String? icon;     // UI icon asset
  final String? apiKey;   // Backend key: "invoice", "real_estate", etc.
  bool selected;

  OpportunityType({
    required this.id,
    required this.name,
    this.icon,
    this.apiKey,
    this.selected = false,
  });
}

/// ---------------------------------------------------------------------------
/// PACKAGE (Credit Rating) ENTITY
/// ---------------------------------------------------------------------------
/// Backend expects titles: "A-AA", "B-BB", "C-CC"
class PackageEntity {
  final int id;
  final String title;        // API value (credit rating)
  final String description;  // UI description
  bool selected;

  PackageEntity({
    required this.id,
    required this.title,
    required this.description,
    this.selected = false,
  });
}

/// ---------------------------------------------------------------------------
/// DURATION ENTITY (Frontend → Backend Mapping)
/// ---------------------------------------------------------------------------
/// Example:
/// title: "حتى 6 أشهر"
/// apiValue: "6"   <-- EXACT VALUE backend expects
class InvestmentDuration {
  final int id;
  final String title;       // UI string
  final String? apiValue;   // Backend value: "6", "12", "18"
  bool selected;

  InvestmentDuration({
    required this.id,
    required this.title,
    this.apiValue,
    this.selected = false,
  });
}

/// ---------------------------------------------------------------------------
/// AMOUNT ENTITY
/// ---------------------------------------------------------------------------
/// Stored as String for text controllers, later converted to int.
class InvestmentAmount {
  String? min;
  String? max;

  InvestmentAmount({this.min, this.max});
}

/// ---------------------------------------------------------------------------
/// MASTER ENTITY FOR WIZARD
/// ---------------------------------------------------------------------------
/// Contains all wizard step values.
class InvestmentWizardEntity {
  List<OpportunityType>? opportunities;
  InvestmentAmount? amount;
  List<PackageEntity>? packages;
  List<InvestmentDuration>? durations;

  InvestmentWizardEntity({
    this.opportunities,
    this.amount,
    this.packages,
    this.durations,
  });
}
