import 'package:flutter/material.dart';
import 'package:lya_encuestas/assets/constants.dart';
import 'package:lya_encuestas/classes/database/models/last_answer.dart';
import 'package:lya_encuestas/widgets/search_data.dart';

class WorkOrderListViewBuilder {
  static Widget build(BuildContext context, String query, List<LastAnswer> data,
      SearchData searchData, onTapItem) {
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
                  onTap: () {
                    onTapItem(index, data[index]);
                  },
                  child: buildLastAnswerItem(data[index]));
            },
          ),
        ),
      ],
    ));
  }

  static Widget buildLastAnswerItem(LastAnswer lastAnswer) {
    return Column(children: [
      const SizedBox(
        height: 8,
        child: Divider(),
      ),
      ListTile(
          leading:
              const Icon(Icons.poll_outlined, color: Constants.COLOR_SECONDARY),
          title: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                      child: Text(
                    "WO ID: [" + lastAnswer.surveyId.toString() + "]",
                    style: const TextStyle(
                        fontSize: 12,
                        color: Constants.COLOR_PRIMARY,
                        fontWeight: FontWeight.bold),
                  )),
                  Flexible(
                      child: Text(
                    "[" + lastAnswer.workOrderCode + "]",
                    style: const TextStyle(
                        fontSize: 12,
                        color: Constants.COLOR_PRIMARY,
                        fontWeight: FontWeight.bold),
                  ))
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(child: Text(lastAnswer.surveyConfigTypeName)),
                ],
              ),
            ],
          )))
    ]);
  }
}
