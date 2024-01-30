import '../../features/camera/data/models/damage_type_model.dart';

List<Map<String, dynamic>> damageTypeJson = [
  {
    "damageTypeId": 1,
    "damageTypeNameKey": "breakThrough",
    "damageTypeGuid": "wMxucuruHBUupNOoVy2MF",
    "damageTypeSlugId": "vo-thung-rach-xfgs5v",
    "damageTypeColor": "#BD10E0",
    "createdDate": "2022-09-21T03:57:45.343Z"
  },
  {
    "damageTypeId": 2,
    "damageTypeNameKey": "dented",
    "damageTypeGuid": "zmMJ5xgjmUpqmHd99UNq3",
    "damageTypeSlugId": "mop-bep-jtep4m",
    "damageTypeColor": "#A2FF43",
    "createdDate": "2022-09-21T03:57:45.343Z"
  },
  {
    "damageTypeId": 3,
    "damageTypeNameKey": "cracked",
    "damageTypeGuid": "5IfgehKG297bQPLkYoZTw",
    "damageTypeSlugId": "nut-ran-mtsphc",
    "damageTypeColor": "#0B7CFF",
    "createdDate": "2022-09-21T03:57:45.343Z"
  },
  {
    "damageTypeId": 4,
    "damageTypeNameKey": "scratches",
    "damageTypeGuid": "yfMzer07THdYoCI1SM2LN",
    "damageTypeSlugId": "tray-xuoc-g06jcx",
    "damageTypeColor": "#FFEC05",
    "createdDate": "2022-09-21T03:57:45.343Z"
  }
];

final List<DamageTypeModel> damageTypes =
    List.from(damageTypeJson.map((e) => DamageTypeModel.fromJson(e)).toList());
