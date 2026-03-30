import 'package:thara/index/index_main.dart';

class OpportunitiesItemsResponse extends OpportunitiesItemsEntity {
  const OpportunitiesItemsResponse({
    final String? id,
    final int? duration,
    final num? companyParticipationRate,
    final String? opportunityType,
    final num? feesAndTaxPercentage,
    final num? principalAmount,
    final String? interestPercentage,
    final num? sharePrice,
    final num? actualInterestPercentage,
    final String? score,
    final String? projectName,
    final String? projectSummary,
    final String? projectDetails,
    final List<ProjectImage>? projectImage,
    final num? collectedPercentage,
    final String? startAt,
    final String? conflictOfInteres,
    final String? startAtHuman,
    final String? endOfSubscription,
    final String? subscriptionClosedAt,
    final String? subscriptionStatus,
    final bool? subscribed,
    final bool? subscriptionStarted,
    final bool? subscriptionClosed,
    final num? daysToEnd,
    final bool? isOwner,
    final ActiveSubscriptionResponse? activeSubscription,
    final List<PaymentsScheduleResponse>? paymentsSchedule,
    final List<AttachmentModel>? attachments,
  }) : super(
          id: id,
          companyParticipationRate: companyParticipationRate,
          opportunityType: opportunityType,
          projectDetails: projectDetails,
          sharePrice: sharePrice,
          duration: duration,
          feesAndTaxPercentage: feesAndTaxPercentage,
          projectSummary: projectSummary,
          conflictOfInteres: conflictOfInteres,
          principalAmount: principalAmount,
          interestPercentage: interestPercentage,
          actualInterestPercentage: actualInterestPercentage,
          score: score,
          projectName: projectName,
          projectImage: projectImage,
          collectedPercentage: collectedPercentage,
          startAt: startAt,
          startAtHuman: startAtHuman,
          endOfSubscription: endOfSubscription,
          subscriptionClosedAt: subscriptionClosedAt,
          subscriptionStatus: subscriptionStatus,
          subscribed: subscribed,
          subscriptionStarted: subscriptionStarted,
          subscriptionClosed: subscriptionClosed,
          daysToEnd: daysToEnd,
          isOwner: isOwner,
          activeSubscription: activeSubscription,
          paymentsSchedule: paymentsSchedule,
          attachments: attachments,
        );

  factory OpportunitiesItemsResponse.fromJson(Map<String, dynamic> json) {
    return OpportunitiesItemsResponse(
      id: json['id'] as String?,
      duration: json['duration'] as int?,
      conflictOfInteres: json['conflictOfInterest'] as String?,
      projectDetails: json['projectDetails'] as String?,
      companyParticipationRate: json['companyParticipationRate'] as num?,
      opportunityType: json['opportunityType'] as String?,
      projectSummary: json['projectSummary'] as String?,
      feesAndTaxPercentage: json['feesAndTaxPercentage'] as num?,
      sharePrice: json['sharePrice'] as num?,
      principalAmount: json['principalAmount'] as num?,
      interestPercentage: json['interestPercentage'] as String?,
      actualInterestPercentage: json['actualInterestPercentage'] as num?,
      score: json['score'] as String?,
      projectName: json['projectName'] as String?,
      projectImage: (json['projectImage'] as List?)
          ?.map((item) => ProjectImage.fromJson(item))
          .toList(),
      collectedPercentage: json['collectedPercentage'] as num?,
      startAt: json['startAt'] as String?,
      startAtHuman: json['startAtHuman'] as String?,
      endOfSubscription: json['endOfSubscription'] as String?,
      subscriptionClosedAt: json['subscriptionClosedAt'] as String?,
      subscriptionStatus: json['subscriptionStatus'] as String?,
      subscribed: json['subscribed'] as bool?,
      subscriptionStarted: json['subscriptionStarted'] as bool?,
      subscriptionClosed: json['subscriptionClosed'] as bool?,
      daysToEnd: json['daysToEnd'] as num?,
      isOwner: json['isOwner'] as bool?,
      activeSubscription: json['activeSubscription'] != null
          ? ActiveSubscriptionResponse.fromJson(json['activeSubscription'])
          : null,
      paymentsSchedule: json['paymentsSchedule'] != null
          ? (json['paymentsSchedule'] as List)
              .map((item) => PaymentsScheduleResponse.fromJson(item))
              .toList()
          : null,
      attachments: (json['attachments'] as List?)
          ?.map((e) => AttachmentModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'duration': duration,
      'conflictOfInterest': conflictOfInteres,
      'projectSummary': projectSummary,
      'projectDetails': projectDetails,
      'sharePrice': sharePrice,
      'companyParticipationRate': companyParticipationRate,
      'opportunityType': opportunityType,
      'feesAndTaxPercentage': feesAndTaxPercentage,
      'principalAmount': principalAmount,
      'interestPercentage': interestPercentage,
      'actualInterestPercentage': actualInterestPercentage,
      'score': score,
      'projectName': projectName,
      'projectImage': projectImage?.map((e) => e.toJson()).toList(),
      'collectedPercentage': collectedPercentage,
      'startAt': startAt,
      'startAtHuman': startAtHuman,
      'endOfSubscription': endOfSubscription,
      'subscriptionClosedAt': subscriptionClosedAt,
      'subscriptionStatus': subscriptionStatus,
      'subscribed': subscribed,
      'subscriptionStarted': subscriptionStarted,
      'subscriptionClosed': subscriptionClosed,
      'daysToEnd': daysToEnd,
      'isOwner': isOwner,
      'activeSubscription': activeSubscription,
      'paymentsSchedule': paymentsSchedule,
      'attachments': attachments,
    };
  }
}

class ProjectImage {
  final int? id;
  final String? url;
  final String? mime;

  const ProjectImage({this.id, this.url, this.mime});

  factory ProjectImage.fromJson(Map<String, dynamic> json) {
    return ProjectImage(
      id: json['id'] as int?,
      url: json['url'] as String?,
      mime: json['mime'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'url': url, 'mime': mime};
  }
}

class AttachmentModel {
  final String? title;
  final MediaModel? media;

  const AttachmentModel({this.title, this.media});

  factory AttachmentModel.fromJson(Map<String, dynamic> json) {
    return AttachmentModel(
      title: json['title'] as String?,
      media: json['media'] != null ? MediaModel.fromJson(json['media']) : null,
    );
  }

  Map<String, dynamic> toJson() => {'title': title, 'media': media?.toJson()};
}

class MediaModel {
  final int? id;
  final String? url;
  final String? mime;

  const MediaModel({this.id, this.url, this.mime});

  factory MediaModel.fromJson(Map<String, dynamic> json) {
    return MediaModel(
      id: json['id'] as int?,
      url: json['url'] as String?,
      mime: json['mime'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {'id': id, 'url': url, 'mime': mime};
}
