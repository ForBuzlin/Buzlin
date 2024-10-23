import 'dart:ui';

import 'package:flutter_remix/flutter_remix.dart';
import 'package:ibeauty/domain/service/tr_keys.dart';

import 'presentation/style/style.dart';

class AppConstants {
  AppConstants._();

  /// api urls
  static const String baseUrl = 'https://api.buzlin.ca/';
  static const String drawingBaseUrl = 'https://api.openrouteservice.org/';
  static const String googleApiKey = 'AIzaSyAPh6pqfLxj5rOL1IIY4yB2aayrL5UrRfg';
  static const String privacyPolicyUrl = '$baseUrl/privacy-policy';
  static const String adminPageUrl = 'https://a.buzlin.ca';
  static const String webUrl = 'https://buzlin.ca';
  static const String firebaseWebKey =
      'AIzaSyCHvjKHsqNTcSHQ6FYnuogFTFqvv21-1WY';
  static const String urlPrefix = 'https://buzlin.page.link';
  static const String androidPackageName = 'ca.buzlin.ca';
  static const String iosPackageName = 'ca.buzlin.ca';
  static const String routingKey =
      '5b3ce3597851110001cf624892f508d1746742a28c72af74d4e60f2b';
  static const String sellerAppAndroid =
      'https://buzlin.ca/';
  static const String sellerAppIos =
      'https://buzlin.ca/';
  static const bool isDemo = false;
  static const bool shopBadge = true;
  static const bool autoTrn = true;


  /// auth phone fields
  static const bool isSpecificNumberEnabled = true;
  static const bool isNumberLengthAlwaysSame = false;
  static const String countryCodeISO = 'PHL';
  static const bool showFlag = true;
  static const bool showArrowIcon = true;


  /// social sign-in
  static const socialSignIn = [
    FlutterRemix.google_fill,
   
  ];

  static const socialSignInAndroid = [
    FlutterRemix.google_fill,
    
  ];

  static List<String> genderList = [
    TrKeys.male,
    TrKeys.female,
    TrKeys.all,
  ];

  static const filterLayouts = [
    LayoutType.twoH,
    LayoutType.three,
    LayoutType.twoV,
    LayoutType.one,
    LayoutType.newUi,
  ];

  static const payLater = [
    "progress",
    "canceled",
    "rejected",
  ];

  /// new carts
  static const bestOffer = "assets/images/box.png";
  static const freeShipping = "assets/images/coin.png";

  /// location
  static const double demoLatitude = 41.304223;
  static const double demoLongitude = 69.2348277;
  static const double pinLoadingMin = 0.116666667;
  static const double pinLoadingMax = 0.611111111;

  ///refresh duration
  static const Duration timeRefresh = Duration(seconds: 30);

  ///image
  static const String loginBg = "assets/images/splash.png";
  static const String darkBgChat = "assets/images/darkBg.jpeg";
  static const String lightBgChat = "assets/images/lightBg.jpeg";

  /// shared preferences keys
  static const String keyLangSelected = 'keyLangSelected';
  static const String keyUser = 'keyUser';
  static const String keyGroupUser = 'keyGroupUser';
  static const String keyToken = 'keyToken';
  static const String keyAdmin = 'keyAdmin';
  static const String keyCartIsEmpty = 'keyCartIsEmpty';
  static const String keyCart = 'keyCart';
  static const String keySavedStores = 'keySavedStores';
  static const String keySearchStores = 'keySearchStores';
  static const String keyViewedProducts = 'keyViewedProducts';
  static const String keyWareHouse = 'keyWareHouse';
  static const String keyAddress = 'keyAddress';
  static const String keyLocation = 'keyLocation';
  static const String keyLikedProducts = 'keyLikedProducts';
  static const String keyLikedShops = 'keyLikedShops';
  static const String keyLikedMasters = 'keyLikedMasters';
  static const String keyCompareProducts = 'keyCompareProducts';
  static const String keySelectedCurrency = 'keySelectedCurrency';
  static const String keyGlobalSettings = 'keyGlobalSettings';
  static const String keyTranslations = 'keyTranslations';
  static const String keyLangLtr = 'keyLangLtr';
  static const String keyUiType = 'keyUiType';
  static const String keyBoard = 'keyBoard';

  /// locales
  static const String localeCodeEn = 'en';

  static const String newOrder = 'new_order';
  static const String newParcelOrder = 'new_parcel_order';
  static const String newUserByReferral = 'new_user_by_referral';
  static const String statusChanged = 'status_changed';
  static const String newsPublish = 'news_publish';
  static const String addCashback = 'add_cashback';
  static const String shopApproved = 'shop_approved';
  static const String walletTopUp = 'wallet_top_up';
  static const String bookingStatusChanged = 'booking_status_changed';

  static const List infoImage = [
    "assets/images/save.png",
    "assets/images/delivery.png",
    "assets/images/fast.png",
    "assets/images/set.png",
  ];

  static const List imageTypes = [
    '.png',
    '.jpg',
    '.jpeg',
    '.webp',
    '.svg',
    '.jfif',
    '.gif',
  ];

  static const Map socialIcon = {
    "facebook": FlutterRemix.facebook_fill,
    "instagram": FlutterRemix.instagram_fill,
    "telegram": FlutterRemix.telegram_fill,
    "youtube": FlutterRemix.youtube_fill,
    "linkedin": FlutterRemix.linkedin_fill,
    "snapchat": FlutterRemix.snapchat_fill,
    "wechat": FlutterRemix.wechat_fill,
    "whatsapp": FlutterRemix.whatsapp_fill,
    "twitch": FlutterRemix.twitch_fill,
    "discord": FlutterRemix.discord_fill,
    "pinterest": FlutterRemix.pinterest_fill,
    "steam": FlutterRemix.steam_fill,
    "spotify": FlutterRemix.spotify_fill,
    "reddit": FlutterRemix.reddit_fill,
    "skype": FlutterRemix.skype_fill,
    "twitter": FlutterRemix.twitter_fill,
  };

  static const List infoTitle = [
    TrKeys.saveTime,
    TrKeys.deliveryRestriction,
    TrKeys.fast,
    TrKeys.set,
  ];

  static const List<Color> adsColor = [
    CustomStyle.seeAllColor,
    CustomStyle.success,
    CustomStyle.starColor,
    CustomStyle.primary,
  ];

  static const List<Color> serviceColors = [
    CustomStyle.service1,
    CustomStyle.service2,
    CustomStyle.service3,
    CustomStyle.service4,
    CustomStyle.service5,
    CustomStyle.service6,
    CustomStyle.service7,
    CustomStyle.service8,
    CustomStyle.service9,
    CustomStyle.service10,
    CustomStyle.service11,
    CustomStyle.service12,
  ];

  static const List<String> listOrderStatus = [
    TrKeys.canceled,
    TrKeys.delivered,
    TrKeys.pause,
    TrKeys.onAWay,
    TrKeys.ready,
    TrKeys.accepted,
    TrKeys.newKey,
  ];

  // static const List sort = [
  //   TrKeys.recommended,
  //   TrKeys.highestRated,
  //   TrKeys.lowestPrice,
  //   TrKeys.highestPrice,
  //   TrKeys.discount,
  // ];

  static const List reviewType = [
    TrKeys.cleanliness,
    TrKeys.masters,
    TrKeys.location,
    TrKeys.price,
    TrKeys.interior,
    TrKeys.serviceQuality,
    TrKeys.communication,
    TrKeys.equipment,
  ];

  static const List formType = [
    TrKeys.multipleChoice,
    TrKeys.shortAnswer,
    TrKeys.longAnswer,
    TrKeys.singleAnswer,
    TrKeys.dropDown,
    TrKeys.yesOrNo,
    TrKeys.descriptionText,
  ];
}

enum UploadType {
  shopsLogo,
  shopsBack,
  products,
  reviews,
  users,
  chats,
}

enum ExtrasType { color, text, image }

enum LayoutType { twoH, three, twoV, one, newUi }

enum DeliveryTypeEnum { delivery, pickup, digital }

enum OrderStatus { open, accepted, ready, onWay, delivered, canceled }

enum AuthType {
  login,
  signUpSendCode,
  confirm,
  signUpFull,
  forgetPassword,
  updatePassword,
}
