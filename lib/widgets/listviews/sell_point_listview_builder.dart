import 'package:flutter/material.dart';
import 'package:lya_encuestas/assets/constants.dart';
import 'package:lya_encuestas/classes/database/models/channel.dart';
import 'package:lya_encuestas/classes/database/models/district.dart';
import 'package:lya_encuestas/classes/database/models/sell_point.dart';
import 'package:lya_encuestas/classes/database/models/sell_point_category_configuration.dart';
import 'package:lya_encuestas/widgets/search_data.dart';

class SellPointListViewBuilder {
  static Widget build(
      BuildContext context,
      String query,
      District? selDistrict,
      List<SellPoint> data,
      List<Channel> channels,
      List<SellPointCategoryConfiguration> sellpointCategoryConfs,
      SearchData searchData,
      onTapItem,onCloseSellPointTap) {
    return Expanded(
        child: Column(
      children: <Widget>[
        searchData,
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (context, index) {
              List<SellPointCategoryConfiguration> listSpConf=[];
              bool isPending =true;
              for(var i = 0; i < sellpointCategoryConfs.length; i++){
                if (sellpointCategoryConfs[i].sellPointId == data[index].id) {
                  listSpConf.add(sellpointCategoryConfs[i]);
                  isPending = false;
                }
              }
              return GestureDetector(
                  onTap: () {
                    onTapItem(index, data[index],isPending,listSpConf);
                  },
                  child: buildSellPointItem(data[index], channels,isPending,listSpConf,onCloseSellPointTap));
            },
          ),
        ),
      ],
    ));
  }

  static Widget buildSellPointItem( SellPoint sellpoint, List<Channel> channels,bool isPending,List<SellPointCategoryConfiguration> listSpConf,onCloseSellPointTap) {
    Channel? channel;
    for (var i = 0; i < channels.length; i++) {
      if (channels[i].id == sellpoint.channelId) {
        channel = channels[i];
        break;
      }
    }
    return Column(children: [
      const SizedBox(
        height: 8,
        child: Divider(),
      ),
      ListTile(
          leading: Icon(Icons.local_convenience_store_rounded, color: isPending?Colors.amber:Constants.COLOR_SECONDARY),
          title: Center( 
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                      child: (sellpoint.id < 0
                          ? (const Text(
                              "[ALTA DE PV]",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ))
                          : (Text(
                              "PV ID: [" + sellpoint.referenceSellPointId.toString() + "]",
                              style: const TextStyle(
                                  fontSize: 12,
                                  color: Constants.COLOR_PRIMARY,
                                  fontWeight: FontWeight.bold),
                            )))),
                  Flexible(
                      child: Text(
                    "[" + (channel == null ? "-" : channel.name) + "]",
                    style: const TextStyle(
                        fontSize: 12,
                        color: Constants.COLOR_PRIMARY,
                        fontWeight: FontWeight.bold),
                  ))
                ],
              ),
              const SizedBox(
                height: 3,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                      child: Text(sellpoint.name == ""
                          ? "Sin Nombre"
                          : sellpoint.name)),
                  (sellpoint.id<0?(const SizedBox(width: 0,)):(Flexible(
                    child: IconButton(
                      icon:const Icon(Icons.info_outline), 
                      color:isPending?Colors.amber:Constants.COLOR_SECONDARY,
                      onPressed: (){onCloseSellPointTap(sellpoint,listSpConf);},
                      splashRadius: 20,
                      padding: const EdgeInsets.all(5),
                    )
                  )))
                ],
              ),
              const SizedBox(
                height: 3,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                      child: Text(
                    sellpoint.address == ""
                        ? "Sin Dirección"
                        : sellpoint.address,
                    style: const TextStyle(
                        fontSize: 15,
                        color: Constants.COLOR_TERTIARY,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  )),
                ],
              ),
            ],
          )))
    ]);
  }
}
