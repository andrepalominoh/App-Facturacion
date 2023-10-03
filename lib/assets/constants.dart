// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';

class Constants {
  static const Color COLOR_PRIMARY = Color.fromRGBO(14, 177, 230,1);
  static const Color COLOR_SECONDARY = Color.fromARGB(14, 177, 230,1);
  static const Color COLOR_TERTIARY = Color.fromARGB(14, 177, 230,1);
  static const Color COLOR_BACKGROUND = Colors.white;

  static const Color COLOR_NAVIGATION_DRAWER_HEADER =
      Color.fromRGBO(37, 65, 101, 1);
  static const Color COLOR_NAVIGATION_DRAWER_BACKGROUND =
      Color.fromRGBO(37, 65, 101, 0.85);
  static const Color COLOR_NAVIGATION_DRAWER_SELECTED =
      Color.fromARGB(255, 182, 250, 179);
  static const Color COLOR_NAVIGATION_DRAWER_NOT_SELECTED =
      Color.fromARGB(255, 11, 255, 2);
  static const Color COLOR_NAVIGATION_DRAWER_DIVIDER_PRIMARY =
      Color.fromARGB(255, 5, 89, 137);

  static const String CONFIG_AUDIT_TYPE_OPEN = "SVC-APE";
  static const String CONFIG_AUDIT_TYPE_CLOSE = "SVC-CLO";
  static const String CONFIG_AUDIT_TYPE_FORCE = "SVC-FOR";

  //API CONSTANTS - TELEFONICA
  static const String API_URL = "https://devfactura.movistar.com.pe/Online/";
  //static const String API_URL = "http://localhost:4006/api/tracks";

  ////////// SERVICIOS PARA API TELEFONICA
  static const String API_REQUEST_POST_GET_TOKEN = 'Token';
  ////////////
  static const String API_RESPONSE_STATUS_KEY = "status";
  static const String API_RESPONSE_MESSAGE_KEY = "message";
  static const String API_RESPONSE_RESPONSE_KEY = "response";
  static const String API_RESPONSE_STATUS_SUCCESS = "success";
  static const String API_RESPONSE_STATUS_ERROR = "error";

  static const String API_REQUEST_USER_LOGIN = 'authentication/login';
  static const String API_REQUEST_SYNCRHONIZATION_GET = 'entity/synchronization/generate';
  static const String API_REQUEST_CATEGORY_LIST = 'entity/category/get';
  static const String API_REQUEST_DISTRICT_LIST = 'entity/user/get-district';
  static const String API_REQUEST_CHANNEL_LIST = 'entity/channel/get';
  static const String API_REQUEST_PERIOD_LIST = 'entity/period/get';
  static const String API_REQUEST_USER_VALID = 'entity/validated/users';
  static const String API_REQUEST_SELLPOINT_LIST = 'entity/pollster-sell-point/get';
  static const String API_REQUEST_SKU_LIST = 'entity/sku/get';
  static const String API_REQUEST_LAST_ANSWER_LIST =
      'entity/survey-detail-values/get';
  static const String API_REQUEST_ANSWER_LIST = 'entity/answer/get';

  static const String API_REQUEST_SKUS_UPLOAD = 'entity/sku/upload';
  static const String API_REQUEST_SELL_POINTS_UPLOAD =
      'entity/sell-point/upload';
  static const String API_REQUEST_ANSWERS_UPLOAD = 'entity/answer/upload';
  static const String API_REQUEST_CHANNEL_CATEGORY_LIST = 'entity/channel-category/get';
  static const String API_REQUEST_SELLPOINT_CATEGORY_CONFIGURATION_LIST = 'entity/sell-point-category-configuration/get';
  static const String API_REQUEST_SELLPOINT_CATEGORY_CONFIGURATION_LIST_V2 = 'entity/sell-point-category-configuration-v2/get';
  static const String API_REQUEST_SELLPOINT_CATEGORY_CONFIGURATION_UPLOAD = 'entity/sell-point-category-configuration/upload';
  static const String API_REQUEST_SELLPOINT_CATEGORY_CONFIGURATION_UPLOAD_V2 = 'entity/sell-point-category-configuration-v2/upload';

  static const String ANSWER_SUCCESS = 'Realizado Correctamente';
  static const String ANSWER_FAILED = 'Ha Fallado Algo';

  static const int DB_VERSION = 2;
  static const String DB_NAME = 'lya_surveys_v2.db';

  static const String DB_TABLE_BACK_IDENTIFIER = 'back_';

  static const String DB_TABLE_USERS = 'users';
  static const String DB_TABLE_SYNCHRONIZATIONS = 'synchronization';
  static const String DB_TABLE_CATEGORIES = 'categories';
  static const String DB_TABLE_DISTRICTS = 'districts';
  static const String DB_TABLE_CHANNELS = 'channels';
  static const String DB_TABLE_PERIODS = 'periods';
  static const String DB_TABLE_SELLPOINTS = 'sellpoints';
  static const String DB_TABLE_SKUS = 'skus';
  static const String DB_TABLE_ANSWERS = 'answers';
  static const String DB_TABLE_LAST_ANSWERS = 'last_answers';
  static const String DB_TABLE_CHANNEL_CATEGORY = 'channel_categories';
  static const String DB_TABLE_SELLPOINT_CATEGORY_CONFIGURATIONS = 'sell_point_category_configurations';
  static const String DB_TABLE_TYPES = 'types';

  ///////////Prueba//////////////////////////////////////
  static String API_REQUEST_POST_PRESETTLEMENT_CLIENT="xxx";
  static String API_REQUEST_GET_CUSTOMER="xxx";
  static String API_REQUEST_POST_DELIVERY_GET="xxx";
  static String API_REQUEST_POST_DELIVERY_NUMREQUEST="xxx";
  static String API_REQUEST_POST_SETTLEMENT_GET="xxx";
  static String API_REQUEST_GET_PAYMENT_APP="xxx";

}
