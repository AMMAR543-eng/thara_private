import 'package:thara/index/index_main.dart';


class OpportunitiesItemsEntity extends Equatable {
  final String? id;
  final num? companyParticipationRate;
  final String? opportunityType;
  final num? feesAndTaxPercentage;
  final num? principalAmount;
  final String? interestPercentage;
  final num? actualInterestPercentage;
  final String? score;
  final String? conflictOfInteres;
  final String? projectName;
  final String? projectSummary;
  final String? projectDetails;
  final List<ProjectImage>? projectImage;
  final num? collectedPercentage;
  final int? duration;
  final String? startAt;
  final String? startAtHuman;
  final String? endOfSubscription;
  final String? subscriptionClosedAt;
  final String? subscriptionStatus;
  final bool? subscribed;
  final bool? subscriptionStarted;
  final bool? subscriptionClosed;
  final num? daysToEnd;
  final num? sharePrice;
  final bool? isOwner;
  final ActiveSubscriptionEntity? activeSubscription;
  final List<PaymentsScheduleEntity>? paymentsSchedule;
  final List<AttachmentModel>? attachments;

  const OpportunitiesItemsEntity({
    this.id,
    this.companyParticipationRate,
    this.projectSummary,
    this.duration,
    this.opportunityType,
    this.projectDetails,
    this.conflictOfInteres,
    this.sharePrice,
    this.feesAndTaxPercentage,
    this.principalAmount,
    this.interestPercentage,
    this.actualInterestPercentage,
    this.score,
    this.projectName,
    this.projectImage,
    this.collectedPercentage,
    this.startAt,
    this.startAtHuman,
    this.endOfSubscription,
    this.subscriptionClosedAt,
    this.subscriptionStatus,
    this.subscribed,
    this.subscriptionStarted,
    this.subscriptionClosed,
    this.daysToEnd,
    this.activeSubscription,
    this.isOwner,
    this.paymentsSchedule,
    this.attachments,
  });

  @override
  // Implementing the props getter to compare fields of the entity
  List<Object?> get props => [
    id,
    conflictOfInteres,
    projectSummary,
    projectDetails,
    companyParticipationRate,
    duration,
    opportunityType,
    sharePrice,
    feesAndTaxPercentage,
    principalAmount,
    interestPercentage,
    actualInterestPercentage,
    score,
    projectName,
    projectImage,
    collectedPercentage,
    startAt,
    startAtHuman,
    endOfSubscription,
    subscriptionClosedAt,
    subscriptionStatus,
    subscribed,
    subscriptionStarted,
    subscriptionClosed,
    daysToEnd,
    activeSubscription,
    isOwner,
    paymentsSchedule,
    attachments,
  ];
}
