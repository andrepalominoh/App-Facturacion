import 'dart:convert';

import 'package:lya_encuestas/assets/utils.dart';
import 'package:lya_encuestas/classes/database/data_access/answer_da.dart';
import 'package:lya_encuestas/classes/database/data_access/category_da.dart';
import 'package:lya_encuestas/classes/database/data_access/channel_category_da.dart';
import 'package:lya_encuestas/classes/database/data_access/channel_da.dart';
import 'package:lya_encuestas/classes/database/data_access/district_da.dart';
import 'package:lya_encuestas/classes/database/data_access/last_answer_da.dart';
import 'package:lya_encuestas/classes/database/data_access/sell_point_category_configuration_da.dart';
import 'package:lya_encuestas/classes/database/data_access/sell_point_da.dart';
import 'package:lya_encuestas/classes/database/data_access/sku_da.dart';
import 'package:lya_encuestas/classes/database/data_access/synchronization_da.dart';
import 'package:lya_encuestas/classes/database/data_access/user_da.dart';
import 'package:lya_encuestas/classes/database/models/answer.dart';
import 'package:lya_encuestas/classes/database/models/category.dart';
import 'package:lya_encuestas/classes/database/models/channel.dart';
import 'package:lya_encuestas/classes/database/models/channel_category.dart';
import 'package:lya_encuestas/classes/database/models/district.dart';
import 'package:lya_encuestas/classes/database/models/last_answer.dart';
import 'package:lya_encuestas/classes/database/models/period.dart';
import 'package:lya_encuestas/classes/database/models/sell_point.dart';
import 'package:lya_encuestas/classes/database/models/sell_point_category_configuration.dart';
import 'package:lya_encuestas/classes/database/models/sku.dart';
import 'package:lya_encuestas/classes/database/models/synchronization.dart';
import 'package:lya_encuestas/classes/database/models/user.dart';
import 'package:lya_encuestas/classes/http/services/answer_service.dart';
import 'package:lya_encuestas/classes/http/services/category_service.dart';
import 'package:lya_encuestas/classes/http/services/channel_category_service.dart';
import 'package:lya_encuestas/classes/http/services/channel_service.dart';
import 'package:lya_encuestas/classes/http/services/district_service.dart';
import 'package:lya_encuestas/classes/http/services/last_answers_service.dart';
import 'package:lya_encuestas/classes/http/services/sell_point_category_configuration_service.dart';
import 'package:lya_encuestas/classes/http/services/sell_point_service.dart';
import 'package:lya_encuestas/classes/http/services/sku_service.dart';
import 'package:lya_encuestas/classes/http/services/synchronization_service.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class Sync {
  static Future<String> backupDatabase(ProgressDialog loading, User user,
      Period period, Synchronization sync) async {
    loading.show(
        max: 100, msg: 'Respaldando cambios pendientes de sincronización...');
    String message = "";
    try {
      Synchronization? sync = Synchronization.parseModelObject(
          await SynchronizationDA().first(null));
      if (sync != null) {
        List<Sku> lstSKU =
            Sku.parseModelList(await SkuDA().list("id<=0", null));
        List<SellPoint> lstSP =
            SellPoint.parseModelList(await SellPointDA().list("id<=0", null));
        List<Answer> lstAnsw =
            Answer.parseModelList(await AnswerDA().list("id<=0", null));

        await SkuDA().insertBackMultiple(lstSKU, sync.id).then((value) => {
              SellPointDA().insertBackMultiple(lstSP, sync.id).then(
                  (value) => {AnswerDA().insertBackMultiple(lstAnsw, sync.id)})
            });
      }
    } catch (ex) {
      message = (message != ""
          ? message
          : "No se pudo cargar una base sincronizada desde el servidor. Por favor, intentelo nuevamente con una conexión estable.");
    }
    if (loading.isOpen()) loading.close();
    return "";
  }

  static Future<String> uploadDatabase(ProgressDialog loading, User user,
      Period period, Synchronization sync) async {
      bool verifyInternet = await Utils.internetConnectivity();
      if(verifyInternet){
            loading.show(
            max: 100,
            msg:
                'Subiendo todos los cambios realizados pendientes de sincronización...');
        String message = "";
        try {
          Synchronization? sync = Synchronization.parseModelObject(
              await SynchronizationDA().first(null));
          if (sync != null) {
            List<Sku> lstSKU =
                Sku.parseModelList(await SkuDA().list("id<=0", null));
            List<SellPoint> lstSP =
                SellPoint.parseModelList(await SellPointDA().list("id<=0", null));
            List<Answer> lstAnsw =
                Answer.parseModelList(await AnswerDA().list("id<=0", null));        
            await SkuService().upload(sync.id, lstSKU).then((value) => {
                  SellPointService()
                      .upload(sync.id, lstSP)
                      .then((value) => {
                        AnswerService().upload(sync.id, lstAnsw)
                      })
                });
          }
        } catch (ex) {
          message = (message != ""
              ? message
              : "No se pudo cargar una base sincronizada desde el servidor. Por favor, intentelo nuevamente con una conexión estable.");
        }
        if (loading.isOpen()) loading.close();
        return "";
      }else{
        return "No cuenta con conexión a internet";
      }
    
  }

  static Future<String> renewDatabase(
      ProgressDialog loading, User user, Period period) async {
        bool verifyInternet = await Utils.internetConnectivity();
        if(verifyInternet){
      loading.show(
          max: 100,
          msg:
              'Limpiando y sincronizando base de datos interna, por favor espere...');
      String message = "";
      try {
        /************************************************************************************************************/
        try {
          await UserDA().deleteAllBase(false);
        } catch (ex) {
          message =
              "No se pudo limpiar la base de datos interna. Contacte con un administrador.";
          throw Exception(ex);
        }

        Synchronization? sync;
        try {
          sync = (await SynchronizationService().get(user.id));
        } catch (ex) {
          message =
              "No se pudo obtener el código de sincronización. Contacte con un administrador.";
        }
        if (sync != null && message == "") {
          /************************************************************************************************************/
          try {
            await SynchronizationDA().insert(sync);
          } catch (ex) {
            message =
                "No se pudo guardar el código de sincronización. Contacte con un administrador.";
            throw Exception(ex);
          }
          /************************************************************************************************************/
          List<int> lstDistrictsInSellPoints = [];
          try {
            List<SellPoint> lstSellPoints =
                await SellPointService().list(user.id, period.id);
            for (var i = 0; i < lstSellPoints.length; i++) {
              lstDistrictsInSellPoints.add(lstSellPoints[i].districtId);
            }
            SellPointDA().insertMultiple(lstSellPoints);
          } catch (ex) {
            message =
                "No se pudieron obtener los puntos de venta asociados al encuestador.";
            throw Exception(ex);
          }
          /************************************************************************************************************/
          try {
            List<District> lstDistricts =
                await DistrictService().list(user.id, period.id);
            List<District> lstFinalDistricts = [];
            for (var i = 0; i < lstDistricts.length; i++) {
              if (lstDistrictsInSellPoints.contains(lstDistricts[i].id)) {
                lstFinalDistricts.add(lstDistricts[i]);
              }
            }
            DistrictDA().insertMultiple(lstFinalDistricts);
          } catch (ex) {
            message =
                "No se pudieron obtener los distritos asociados al encuestador.";
            throw Exception(ex);
          }
          /************************************************************************************************************/
          List<int> lstCategoryIds = [];
          try {
            List<Category> lstCategories =
                await CategoryService().list(user.id, period.id);
            CategoryDA().insertMultiple(lstCategories);
            for (var i = 0; i < lstCategories.length; i++) {
              lstCategoryIds.add(lstCategories[i].id);
            }
          } catch (ex) {
            message =
                "No se pudieron obtener las categorías asociadas al encuestador.";
            throw Exception(ex);
          }
          /************************************************************************************************************/
          try {
            List<Channel> lstChannels =
                await ChannelService().list(user.id, period.id);
            ChannelDA().insertMultiple(lstChannels);
          } catch (ex) {
            message =
                "No se pudieron obtener los canales asociados al encuestador.";
            throw Exception(ex);
          }
          /************************************************************************************************************/
          try {
            List<Sku> lstSkus = await SkuService().list(user.id, period.id);
            SkuDA().insertMultiple(lstSkus);
          } catch (ex) {
            message = "No se pudieron obtener los SKUs asociados al encuestador.";
            throw Exception(ex);
          }
          /************************************************************************************************************/
          try {
            List<Answer> lstAnswers =
                await AnswerService().list(user.id, period.id);
            AnswerDA().insertMultiple(lstAnswers);
          } catch (ex) {
            message =
                "No se pudieron obtener las respuestas asociados a las encuestas asignadas al encuestador.";
            throw Exception(ex);
          }        
          /************************************************************************************************************/
          try {
            List<ChannelCategory> lstChannelCategories =  await ChannelCategoryService().list(user.id, period.id);
            ChannelCategoryDA().insertMultiple(lstChannelCategories);
          } catch (ex) {
            message =
                "No se pudieron obtener las respuestas asociados a las encuestas asignadas al encuestador.";
            throw Exception(ex);
          }        
          /************************************************************************************************************/
          try {
            List<LastAnswer> lstLastAnswers =
                await LastAnswerService().list(user.id, period.id);
            LastAnswerDA().insertMultiple(lstLastAnswers);
          } catch (ex) {
            message =
                "No se pudieron obtener las respuestas anteriores asociados a las encuestas asignadas al encuestador.";
            throw Exception(ex);
          }
        }
        /************************************************************************************************************/
      } catch (ex) {
        message = (message != ""
            ? message
            : "No se pudo cargar una base sincronizada desde el servidor. Por favor, intentelo nuevamente con una conexión estable.");
      }
      if (loading.isOpen()) loading.close();
      return message;
        }else{
          return "No cuenta con conexión a internet";
        }
  }

  static Future<String> uploadSellPointCategoryConfiguration(Period periodG) async {
    String message = "";
    try {
        List<SellPointCategoryConfiguration> lstSellCatConf = SellPointCategoryConfiguration.parseModelList(await SellPointCategoryConfigurationDA().list(null,'sell_point_id asc'));
        await  SellPointCategoryConfigurationService().upload(periodG.id,lstSellCatConf);    
    } catch (ex) {
       message = (message != ""
          ? message
          : "No se pudo cargar los estados de punto de Venta. Por favor, intentelo nuevamente con una conexión estable.");
    }
    return "";
  }
  static Future<String> renewSellPointCategoryConfigTable(User user, Period period)async {
     String message = "";
   try {
      await SellPointCategoryConfigurationDA().deleteAllBase();
      List<SellPointCategoryConfiguration> lstSellPointCategoryConfs = await SellPointCategoryConfigurationService().list(user.id, period.id);
      SellPointCategoryConfigurationDA().insertMultiple(lstSellPointCategoryConfs);
    } catch (ex) {
       message = (message != ""
          ? message
          : "No se pudo actualizar los estados de punto de Venta. Por favor, intentelo nuevamente con una conexión estable.");
    }
    return "";
  }
}
