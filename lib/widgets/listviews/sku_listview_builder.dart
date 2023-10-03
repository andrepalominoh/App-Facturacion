import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lya_encuestas/assets/constants.dart';
import 'package:lya_encuestas/assets/utils.dart';
import 'package:lya_encuestas/classes/database/data_access/answer_da.dart';
import 'package:lya_encuestas/classes/database/data_access/period_da.dart';
import 'package:lya_encuestas/classes/database/data_access/sku_da.dart';
import 'package:lya_encuestas/classes/database/data_access/user_da.dart';
import 'package:lya_encuestas/classes/database/models/answer.dart';
import 'package:lya_encuestas/classes/database/models/category.dart';
import 'package:lya_encuestas/classes/database/models/last_answer.dart';
import 'package:lya_encuestas/classes/database/models/period.dart';
import 'package:lya_encuestas/classes/database/models/sell_point.dart';
import 'package:lya_encuestas/classes/database/models/sku.dart';
import 'package:lya_encuestas/classes/database/models/user.dart';
import 'package:lya_encuestas/widgets/search_data.dart';

class SkuListViewBuilder {

  Widget build( BuildContext context, String query, SellPoint sellPoint, Category? selCategory, List<Sku> data, List<Category> categories,List<Answer> answers, SearchData searchData/*, onTapItem*/) {
    return Expanded(
        child: Column(
      children: <Widget>[
        searchData,
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                /* onTap: () {
                  onTapItem(index, data[index]);
                }, */
                child: buildSkuItem(data[index],sellPoint ,categories, answers)
              );
            },
          ),
        ),
      ],
    ));
  }

  Widget buildSkuItem(Sku sku,SellPoint sellPoint , List<Category> categories, List<Answer> answers) {
    
    TextEditingController txtPrice = TextEditingController();
    TextEditingController txtClosedInventory = TextEditingController();
    TextEditingController txtOpenInventory = TextEditingController();
    TextEditingController txtPurchase = TextEditingController();
    TextEditingController txtEstimatedSale = TextEditingController();

    Category? category;

    for (var i = 0; i < categories.length; i++) {
      if (categories[i].id == sku.categoryId) {
        category = categories[i];
        break;
      }
    }
    Answer? answer;
    for (var i = 0; i < answers.length; i++) {
      if (answers[i].skuId == sku.id) {
        answer = answers[i];
        break;
      }
    }

    if (answer != null) {
        txtPrice.text = answer.price.toString();
        txtClosedInventory.text = answer.closedInventory.toString();
        txtOpenInventory.text = answer.openInventory.toString();
        txtPurchase.text = answer.purchase.toString();
        txtEstimatedSale.text = answer.estimatedSale.toString();
      } else {
        txtPrice.text = "";
        txtClosedInventory.text = "";
        txtOpenInventory.text = "";
        txtPurchase.text = "";
        txtEstimatedSale.text = "";
    }

    return FutureBuilder(
      future: getLastAnswers(sku,sellPoint),
      builder: (BuildContext context,AsyncSnapshot<List<LastAnswer>> lastAnswers){
        List<LastAnswer>? lstAnswers = lastAnswers.data;
        List<Widget> fields = [];
        //Se hara un recorrido para obtener los campos a agregar
        if(lstAnswers!=null){
          for(LastAnswer la in lstAnswers){
            List<dynamic> lastAnswer=[];
            if(la.answers!=''){
              lastAnswer=jsonDecode(la.answers)['answers'];
            }

            if(la.surveyConfigTypeCode == Constants.CONFIG_AUDIT_TYPE_OPEN || la.surveyConfigTypeCode == Constants.CONFIG_AUDIT_TYPE_CLOSE || la.surveyConfigTypeCode == Constants.CONFIG_AUDIT_TYPE_FORCE){

              var rpta = lastAnswer.firstWhere((a)=>a['code']=='SMET-COMP',orElse: () => null,);
              fields.add(
                Column(children: [
                  Container(
                    alignment: Alignment.center,
                    child:Text((rpta!=null)?rpta['value'].toString():'',style: const TextStyle(fontSize: 12),),                    
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 248, 248, 192),  
                    ),
                    width: 40,
                  ),
                  SizedBox( width: 40, height: 30,                          
                    child:Focus(
                      onFocusChange: (bool hasFocus)=>{if(!hasFocus&&txtPurchase.text!=''){saveAnswer(lstAnswers, answer, sellPoint, sku, txtPurchase.text, txtOpenInventory.text, txtClosedInventory.text, txtPrice.text, txtEstimatedSale.text)}},
                      child: TextField(
                        controller: txtPurchase,
                        style: const TextStyle( fontSize: 14),
                        keyboardType: const TextInputType.numberWithOptions(decimal: false),
                        inputFormatters: <TextInputFormatter>[ FilteringTextInputFormatter.digitsOnly ],
                        decoration: const InputDecoration( contentPadding: EdgeInsets.symmetric(vertical: 2,horizontal:5), border: OutlineInputBorder(),
                          hintText: 'Co',
                          hintStyle:TextStyle(fontSize: 14)
                        ),
                      ),
                    )
                  ),
                  const Text('Co',style: TextStyle(fontSize: 11),)
                ],)
              );
              break;
            }
          }

        for(LastAnswer la in lstAnswers){
          List<dynamic> lastAnswer=[];
          if(la.answers!=''){
            lastAnswer=jsonDecode(la.answers)['answers'];
          }
          if(la.surveyConfigTypeCode == Constants.CONFIG_AUDIT_TYPE_FORCE || la.surveyConfigTypeCode == Constants.CONFIG_AUDIT_TYPE_CLOSE){
            var rptaIa = lastAnswer.firstWhere((a)=>a['code']=='SMET-INVOP',orElse: () => null,);
            var rptaIc = lastAnswer.firstWhere((a)=>a['code']=='SMET-INVCL',orElse: () => null,);
            fields.add(
              //Inventario Abierto
              Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child:Text((rptaIa!=null)?rptaIa['value'].toString():'',style: const TextStyle(fontSize: 12),),                    
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 248, 248, 192),  
                    ),
                    width: 40,
                  ),
                  SizedBox( width: 40, height: 30,                          
                    child: Focus(
                      onFocusChange: (bool hasFocus)=>{if(!hasFocus&&txtOpenInventory.text!=''){saveAnswer(lstAnswers, answer, sellPoint, sku, txtPurchase.text, txtOpenInventory.text, txtClosedInventory.text, txtPrice.text, txtEstimatedSale.text)}},
                      child: TextField(
                        controller: txtOpenInventory,
                        style: const TextStyle( fontSize: 14),
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: <TextInputFormatter>[ FilteringTextInputFormatter.digitsOnly ],
                        decoration: const InputDecoration( contentPadding: EdgeInsets.symmetric(vertical: 2,horizontal:5), border: OutlineInputBorder(),
                          hintText: 'Ia',
                          hintStyle:TextStyle( fontSize: 14)
                        ),
                      ),
                    ),
                  ),
                  const Text('Ia',style: TextStyle(fontSize: 11),)
                ],
              )
            );
            fields.add(
              Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child:Text((rptaIc!=null)?rptaIc['value'].toString():'',style: const TextStyle(fontSize: 12),),                    
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 248, 248, 192),  
                    ),
                    width: 40,
                  ),
                  SizedBox( width: 40, height: 30,                          
                    child: Focus(
                      onFocusChange: (bool hasFocus)=>{if(!hasFocus&&txtClosedInventory.text!=''){saveAnswer(lstAnswers, answer, sellPoint, sku, txtPurchase.text, txtOpenInventory.text, txtClosedInventory.text, txtPrice.text, txtEstimatedSale.text)}},
                      child: TextField(
                        controller: txtClosedInventory,
                        style: const TextStyle( fontSize: 14),
                        keyboardType: const TextInputType.numberWithOptions(decimal: false),
                        decoration: const InputDecoration( contentPadding: EdgeInsets.symmetric(vertical: 2,horizontal:5), border: OutlineInputBorder(),
                          hintText: 'Ic',
                          hintStyle:TextStyle( fontSize: 14)
                        ),
                      ),
                    ),
                  ),
                  const Text('Ic',style: TextStyle(fontSize: 11),)
                ],
              ),
            );
            break;
          }
        }

        for(LastAnswer la in lstAnswers){
            List<dynamic> lastAnswer=[];
            if(la.answers!=''){
              lastAnswer=jsonDecode(la.answers)['answers'];
            }
            if(la.surveyConfigTypeCode == Constants.CONFIG_AUDIT_TYPE_CLOSE){
              var rpta = lastAnswer.firstWhere((a)=>a['code']=='SMET-PREC',orElse: () => null,);
              fields.add(
                //Inventario Abierto
                Column(
                  children: [
                    SizedBox( width: 40, height: 30,                          
                      child: Focus(
                        onFocusChange: (bool hasFocus)=>{if(!hasFocus&&txtPrice.text!=''){saveAnswer(lstAnswers, answer, sellPoint, sku, txtPurchase.text, txtOpenInventory.text, txtClosedInventory.text, txtPrice.text, txtEstimatedSale.text)}},
                        child: TextField(
                          controller: txtPrice,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          style: const TextStyle( fontSize: 14),
                          decoration: const InputDecoration( contentPadding: EdgeInsets.symmetric(vertical: 2,horizontal:5), border: OutlineInputBorder(),
                            hintText: 'Pr',
                            hintStyle:TextStyle(fontSize: 14)
                          ),
                        ),
                      ),
                    ),
                    const Text('Pr',style: TextStyle(fontSize: 11),)
                  ],
                )
              );
              break;
            }
          }
        }

        return Column(
          children: [
            const SizedBox(
              height: 8,
              child: Divider(),
            ),
            ListTile(
              leading: ((answer == null ? const Icon(Icons.drive_file_rename_outline, color: Colors.red) : const Icon(Icons.error_outline, color: Constants.COLOR_SECONDARY))),
              title: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: (sku.id < 0
                              ? (const Text(
                                  "[ALTA DE SKU]",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                ))
                              : (Text(
                                  "SKU ID: [" + sku.referenceSkuId.toString() + "]",
                                  style: const TextStyle(
                                      fontSize: 12,
                                      color: Constants.COLOR_PRIMARY,
                                      fontWeight: FontWeight.bold),
                                ))
                        )
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        child: 
                          Text(
                            sku.name == "" ? "Sin Nombre" : sku.name,
                            style: const TextStyle(
                              fontSize: 14,
                              
                            ),
                          )
                        ,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Wrap(
                              spacing: 4,
                              children: fields
                            )                        
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ))
            )
          ]
        );
      }
    );
  }

  Future<List<LastAnswer>> getLastAnswers(Sku sku,SellPoint sellPoint)async{
    Period? period = Period.parseModelObject(await PeriodDA().first(null));
    List<LastAnswer> data = await Utils.getLastAnswers(period!, sku, sellPoint);
    return data;
  }

  Future<void> saveAnswer(List<LastAnswer>? la,Answer? answer,SellPoint sellPoint,Sku sku,String purchase,String invOpen, String invClose, String price, String estimatedSale) async{
    Period? period = Period.parseModelObject(await PeriodDA().first(null));
    User? user = await UserDA().getLogued();
    if(la!.isNotEmpty){
      await SkuDA().setPrioritize(sku.id);
      for(LastAnswer lastAnswer in la){
        if (answer != null) {
          AnswerDA().deleteWhere(" sell_point_id=${sellPoint.id} and sku_id=${sku.id} and survey_id=${lastAnswer.surveyId} ");
        }
        //conocer que datos debo guardar en cada caso del survey
        String rPurchase='';
        String rInvOpen='';
        String rInvClose='';
        String rPrice='';
        String rEstimatedSale='';
        if(lastAnswer.surveyConfigTypeCode == Constants.CONFIG_AUDIT_TYPE_OPEN || lastAnswer.surveyConfigTypeCode == Constants.CONFIG_AUDIT_TYPE_CLOSE || lastAnswer.surveyConfigTypeCode == Constants.CONFIG_AUDIT_TYPE_FORCE){
          rPurchase=purchase;
        }
        if(lastAnswer.surveyConfigTypeCode == Constants.CONFIG_AUDIT_TYPE_FORCE || lastAnswer.surveyConfigTypeCode == Constants.CONFIG_AUDIT_TYPE_CLOSE){
          rInvClose=invClose;rInvOpen=invOpen;
        }
        if(lastAnswer.surveyConfigTypeCode == Constants.CONFIG_AUDIT_TYPE_CLOSE){
          rPrice=price;
        }
        int minID = await AnswerDA().getMinID();
        if (minID > 0) minID = 0;
        Answer obj = Answer(
        id: minID - 1,
        periodId: period!.id,
        sellPointId: sellPoint.id,
        skuId: sku.id,
        surveyId: lastAnswer.surveyId,
        price: rPrice,
        closedInventory: rInvClose,
        openInventory: rInvOpen,
        purchase: rPurchase,
        estimatedSale: rEstimatedSale,
        syncPollsterFirstName: user!.firstName,
        syncPollsterLastName: user.lastName,
        syncPollsterEmail: user.email,
        syncRequestDate: '');
        await AnswerDA().insert(obj); 
      }
    }
  }
}