import 'package:equatable/equatable.dart';

class Profile extends Equatable {
  final String? profileId;
  final String? avatar;
  final String? birthDate;
  final String? sex;
  final String? title;
  final String? firstname;
  final String? lastname;
  final String? address;
  final String? dateCreated;

  const Profile({
    this.profileId,
    this.avatar,
    this.birthDate,
    this.sex,
    this.title,
    this.firstname,
    this.lastname,
    this.address,
    this.dateCreated,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      profileId: json['profileId']?.toString(),
      avatar: json['avatar']?.toString(),
      birthDate: json['birthDate']?.toString(),
      sex: json['sex']?.toString(),
      title: json['title']?.toString(),
      firstname: json['firstname']?.toString(),
      lastname: json['lastname']?.toString(),
      address: json['address']?.toString(),
      dateCreated: json['dateCreated']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        if (profileId != null) 'profileId': profileId,
        if (avatar != null) 'avatar': avatar,
        if (birthDate != null) 'birthDate': birthDate,
        if (sex != null) 'sex': sex,
        if (title != null) 'title': title,
        if (firstname != null) 'firstname': firstname,
        if (lastname != null) 'lastname': lastname,
        if (address != null) 'address': address,
        if (dateCreated != null) 'dateCreated': dateCreated,
      };

  Profile copyWith({
    String? profileId,
    String? avatar,
    String? birthDate,
    String? sex,
    String? title,
    String? firstname,
    String? lastname,
    String? address,
    String? dateCreated,
  }) {
    return Profile(
      profileId: profileId ?? this.profileId,
      avatar: avatar ?? this.avatar,
      birthDate: birthDate ?? this.birthDate,
      sex: sex ?? this.sex,
      title: title ?? this.title,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      address: address ?? this.address,
      dateCreated: dateCreated ?? this.dateCreated,
    );
  }

  @override
  List<Object?> get props {
    return [
      profileId,
      avatar,
      birthDate,
      sex,
      title,
      firstname,
      lastname,
      address,
      dateCreated,
    ];
  }
}

class UserVehicle extends Equatable {
  final String? profileId;
  final String? vehicleName;
  final String? carCompanyId;
  final String? carModelId;
  final String? numberPlate;

  const UserVehicle({
    this.profileId,
    this.vehicleName,
    this.carCompanyId,
    this.carModelId,
    this.numberPlate,
  });

  factory UserVehicle.fromJson(Map<String, dynamic> json) {
    return UserVehicle(
      profileId: json['profileId']?.toString(),
      vehicleName: json['vehicleName']?.toString(),
      carCompanyId: json['carCompanyId']?.toString(),
      carModelId: json['carModelId']?.toString(),
      numberPlate: json['numberPlate']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        if (profileId != null) 'profileId': profileId,
        if (vehicleName != null) 'vehicleName': vehicleName,
        if (carCompanyId != null) 'carCompanyId': carCompanyId,
        if (carModelId != null) 'carModelId': carModelId,
        if (numberPlate != null) 'numberPlate': numberPlate,
      };

  UserVehicle copyWith({
    String? profileId,
    String? vehicleName,
    String? carCompanyId,
    String? carModelId,
    String? numberPlate,
  }) {
    return UserVehicle(
      profileId: profileId ?? this.profileId,
      vehicleName: vehicleName ?? this.vehicleName,
      carCompanyId: carCompanyId ?? this.carCompanyId,
      carModelId: carModelId ?? this.carModelId,
      numberPlate: numberPlate ?? this.numberPlate,
    );
  }

  @override
  List<Object?> get props {
    return [
      profileId,
      vehicleName,
      carCompanyId,
      carModelId,
      numberPlate,
    ];
  }
}

class Organizations extends Equatable {
  final num? organizationId;
  final String? organizationName;
  final String? status;
  final String? dateCreated;
  final String? dateModified;
  final String? address;
  final num? contactNumber;
  final String? email;
  final String? country;
  final String? state;
  final String? postalCode;
  final String? websiteUrl;
  final dynamic kvp;

  const Organizations({
    this.organizationId,
    this.organizationName,
    this.status,
    this.dateCreated,
    this.dateModified,
    this.address,
    this.contactNumber,
    this.email,
    this.country,
    this.state,
    this.postalCode,
    this.websiteUrl,
    this.kvp,
  });

  factory Organizations.fromJson(Map<String, dynamic> json) {
    return Organizations(
      organizationId: num.tryParse(json['organizationId'].toString()),
      organizationName: json['organizationName']?.toString(),
      status: json['status']?.toString(),
      dateCreated: json['dateCreated']?.toString(),
      dateModified: json['dateModified']?.toString(),
      address: json['address']?.toString(),
      contactNumber: num.tryParse(json['contactNumber'].toString()),
      email: json['email']?.toString(),
      country: json['country']?.toString(),
      state: json['state']?.toString(),
      postalCode: json['postalCode']?.toString(),
      websiteUrl: json['websiteUrl']?.toString(),
      kvp: json['kvp'],
    );
  }

  Map<String, dynamic> toJson() => {
        if (organizationId != null) 'organizationId': organizationId,
        if (organizationName != null) 'organizationName': organizationName,
        if (status != null) 'status': status,
        if (dateCreated != null) 'dateCreated': dateCreated,
        if (dateModified != null) 'dateModified': dateModified,
        if (address != null) 'address': address,
        if (contactNumber != null) 'contactNumber': contactNumber,
        if (email != null) 'email': email,
        if (country != null) 'country': country,
        if (state != null) 'state': state,
        if (postalCode != null) 'postalCode': postalCode,
        if (websiteUrl != null) 'websiteUrl': websiteUrl,
        if (kvp != null) 'kvp': kvp,
      };

  Organizations copyWith({
    num? organizationId,
    String? organizationName,
    String? status,
    String? dateCreated,
    String? dateModified,
    String? address,
    num? contactNumber,
    String? email,
    String? country,
    String? state,
    String? postalCode,
    String? websiteUrl,
    dynamic kvp,
  }) {
    return Organizations(
      organizationId: organizationId ?? this.organizationId,
      organizationName: organizationName ?? this.organizationName,
      status: status ?? this.status,
      dateCreated: dateCreated ?? this.dateCreated,
      dateModified: dateModified ?? this.dateModified,
      address: address ?? this.address,
      contactNumber: contactNumber ?? this.contactNumber,
      email: email ?? this.email,
      country: country ?? this.country,
      state: state ?? this.state,
      postalCode: postalCode ?? this.postalCode,
      websiteUrl: websiteUrl ?? this.websiteUrl,
      kvp: kvp ?? this.kvp,
    );
  }

  @override
  List<Object?> get props {
    return [
      organizationId,
      organizationName,
      status,
      dateCreated,
      dateModified,
      address,
      contactNumber,
      email,
      country,
      state,
      postalCode,
      websiteUrl,
      kvp,
    ];
  }
}

class Data extends Equatable {
  final String? userId;
  final String? userName;
  final String? password;
  final String? email;
  final String? lastLoggedIn;
  final bool? passwordChangeRequire;
  final String? dateCreated;
  final String? status;
  final String? passwordLastUpdated;
  final dynamic userSetting;
  final Profile? profile;
  final List<UserVehicle>? userVehicle;
  final List<Organizations>? organizations;

  const Data({
    this.userId,
    this.userName,
    this.password,
    this.email,
    this.lastLoggedIn,
    this.passwordChangeRequire,
    this.dateCreated,
    this.status,
    this.passwordLastUpdated,
    this.profile,
    this.userVehicle,
    this.organizations,
    this.userSetting,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      userId: json['userId']?.toString(),
      userName: json['userName']?.toString(),
      password: json['password']?.toString(),
      email: json['email']?.toString(),
      lastLoggedIn: json['lastLoggedIn']?.toString(),
      passwordChangeRequire:
          json['passwordChangeRequire'].toString().contains('true'),
      dateCreated: json['dateCreated']?.toString(),
      status: json['status']?.toString(),
      userSetting: json['userSetting'],
      passwordLastUpdated: json['passwordLastUpdated']?.toString(),
      profile: json['profile'] == null
          ? null
          : Profile.fromJson(Map<String, dynamic>.from(json['profile'])),
      userVehicle: json['userVehicle'] is List
          ? json['userVehicle']
              .map<UserVehicle>((e) => UserVehicle.fromJson(e))
              .toList()
          : null,
      organizations: json['organizations'] is List
          ? json['organizations']
              .map<Organizations>((e) => Organizations.fromJson(e))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        if (userId != null) 'userId': userId,
        if (userName != null) 'userName': userName,
        if (password != null) 'password': password,
        if (email != null) 'email': email,
        if (lastLoggedIn != null) 'lastLoggedIn': lastLoggedIn,
        if (passwordChangeRequire != null)
          'passwordChangeRequire': passwordChangeRequire,
        if (dateCreated != null) 'dateCreated': dateCreated,
        if (status != null) 'status': status,
        if (passwordLastUpdated != null)
          'passwordLastUpdated': passwordLastUpdated,
        if (profile != null) 'profile': profile,
        if (userVehicle != null) 'userVehicle': userVehicle,
        if (organizations != null) 'organizations': organizations,
        if (userSetting != null) 'userSetting': userSetting,
      };

  Data copyWith({
    String? userId,
    String? userName,
    String? password,
    String? email,
    String? lastLoggedIn,
    bool? passwordChangeRequire,
    String? dateCreated,
    String? status,
    String? passwordLastUpdated,
    dynamic userSetting,
    Profile? profile,
    List<UserVehicle>? userVehicle,
    List<Organizations>? organizations,
  }) {
    return Data(
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      password: password ?? this.password,
      email: email ?? this.email,
      lastLoggedIn: lastLoggedIn ?? this.lastLoggedIn,
      passwordChangeRequire:
          passwordChangeRequire ?? this.passwordChangeRequire,
      dateCreated: dateCreated ?? this.dateCreated,
      status: status ?? this.status,
      passwordLastUpdated: passwordLastUpdated ?? this.passwordLastUpdated,
      profile: profile ?? this.profile,
      userVehicle: userVehicle ?? this.userVehicle,
      organizations: organizations ?? this.organizations,
      userSetting: userSetting ?? this.userSetting,
    );
  }

  @override
  List<Object?> get props {
    return [
      userId,
      userName,
      password,
      email,
      lastLoggedIn,
      passwordChangeRequire,
      dateCreated,
      status,
      passwordLastUpdated,
      profile,
      userVehicle,
      organizations,
      userSetting,
    ];
  }
}

class UserInfo extends Equatable {
  final String? tokenType;
  final Data? data;

  const UserInfo({
    this.tokenType,
    this.data,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      tokenType: json['tokenType']?.toString(),
      data: json['data'] == null
          ? null
          : Data.fromJson(Map<String, dynamic>.from(json['data'])),
    );
  }

  Map<String, dynamic> toJson() => {
        if (tokenType != null) 'tokenType': tokenType,
        if (data != null) 'data': data?.toJson(),
      };

  UserInfo copyWith({
    String? tokenType,
    Data? data,
  }) {
    return UserInfo(
      tokenType: tokenType ?? this.tokenType,
      data: data ?? this.data,
    );
  }

  @override
  List<Object?> get props {
    return [
      tokenType,
      data,
    ];
  }
}
