
import 'dart:convert';

ApiResponseModel apiResponseModelFromJson(String str) => ApiResponseModel.fromJson(json.decode(str));

String apiResponseModelToJson(ApiResponseModel data) => json.encode(data.toJson());

class ApiResponseModel {
    List<Item> items;
    bool hasMore;
    int quotaMax;
    int quotaRemaining;

    ApiResponseModel({
        required this.items,
        required this.hasMore,
        required this.quotaMax,
        required this.quotaRemaining,
    });

    factory ApiResponseModel.fromJson(Map<String, dynamic> json) => ApiResponseModel(
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        hasMore: json["has_more"]??false,
        quotaMax: json["quota_max"]??0,
        quotaRemaining: json["quota_remaining"]??0,
    );

    Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "has_more": hasMore,
        "quota_max": quotaMax,
        "quota_remaining": quotaRemaining,
    };
}

class Item {
    List<String> tags;
    Owner owner;
    bool isAnswered;
    int viewCount;
    int answerCount;
    int score;
    int lastActivityDate;
    int creationDate;
    int questionId;
   // ContentLicense contentLicense;
    String link;
    String title;
    int? lastEditDate;
    int? acceptedAnswerId;

    Item({
        required this.tags,
        required this.owner,
        required this.isAnswered,
        required this.viewCount,
        required this.answerCount,
        required this.score,
        required this.lastActivityDate,
        required this.creationDate,
        required this.questionId,
        required this.link,
        required this.title,
        this.lastEditDate,
        this.acceptedAnswerId,
    });

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        tags: List<String>.from(json["tags"].map((x) => x)),
        owner: Owner.fromJson(json["owner"]),
        isAnswered: json["is_answered"]??false,
        viewCount: json["view_count"]??0,
        answerCount: json["answer_count"]??0,
        score: json["score"]??0,
        lastActivityDate: json["last_activity_date"]??0,
        creationDate: json["creation_date"]??0,
        questionId: json["question_id"]??0,
       // contentLicense: contentLicenseValues.map[json["content_license"]]!,
        link: json["link"]??'',
        title: json["title"]??'',
        lastEditDate: json["last_edit_date"]??0,
        acceptedAnswerId: json["accepted_answer_id"]??0,
    );

    Map<String, dynamic> toJson() => {
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "owner": owner.toJson(),
        "is_answered": isAnswered,
        "view_count": viewCount,
        "answer_count": answerCount,
        "score": score,
        "last_activity_date": lastActivityDate,
        "creation_date": creationDate,
        "question_id": questionId,
       // "content_license": contentLicenseValues.reverse[contentLicense],
        "link": link,
        "title": title,
        "last_edit_date": lastEditDate,
        "accepted_answer_id": acceptedAnswerId,
    };
}

enum ContentLicense {
    CC_BY_SA_40
}

final contentLicenseValues = EnumValues({
    "CC BY-SA 4.0": ContentLicense.CC_BY_SA_40
});

class Owner {
    int? accountId;
    int? reputation;
    int? userId;
   // UserType userType;
    String? profileImage;
    String displayName;
    String? link;
    int? acceptRate;

    Owner({
        this.accountId,
        this.reputation,
        this.userId,
        this.profileImage,
        required this.displayName,
        this.link,
        this.acceptRate,
    });

    factory Owner.fromJson(Map<String, dynamic> json) => Owner(
        accountId: json["account_id"]??0,
        reputation: json["reputation"]??0,
        userId: json["user_id"]??0,
       // userType: userTypeValues.map[json["user_type"]]!,
        profileImage: json["profile_image"]??'',
        displayName: json["display_name"]??'',
        link: json["link"]??'',
        acceptRate: json["accept_rate"]??0,
    );

    Map<String, dynamic> toJson() => {
        "account_id": accountId,
        "reputation": reputation,
        "user_id": userId,
       // "user_type": userTypeValues.reverse[userType],
        "profile_image": profileImage,
        "display_name": displayName,
        "link": link,
        "accept_rate": acceptRate,
    };
}

enum UserType {
    DOES_NOT_EXIST,
    REGISTERED
}

final userTypeValues = EnumValues({
    "does_not_exist": UserType.DOES_NOT_EXIST,
    "registered": UserType.REGISTERED
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
