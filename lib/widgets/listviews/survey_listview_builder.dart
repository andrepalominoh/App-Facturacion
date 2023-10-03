import 'package:flutter/material.dart';
import 'package:lya_encuestas/assets/constants.dart';
import 'package:lya_encuestas/classes/database/models/last_answer.dart';

class SurveyListViewBuilder {
  static Widget build(BuildContext context, List<LastAnswer> data, onTapItem) {
    return Expanded(
        child: Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () {
                    onTapItem(index, data[index]);
                  },
                  child: buildSurveyItem(data[index]));
            },
          ),
        ),
      ],
    ));
  }

  static Widget buildSurveyItem(LastAnswer lastAnswer) {
    return Column(children: [
      const SizedBox(
        height: 8,
        child: Divider(),
      ),
      ListTile(
          leading: const Icon(Icons.drive_file_rename_outline,
              color: Constants.COLOR_SECONDARY),
          title: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                      child: Text(
                    "Encuesta ID: [" + lastAnswer.surveyId.toString() + "]",
                    style: const TextStyle(
                        fontSize: 14,
                        color: Constants.COLOR_PRIMARY,
                        fontWeight: FontWeight.bold),
                  )),
                  Flexible(
                      child: Text(
                    "[" + (lastAnswer.periodName) + "]",
                    style: const TextStyle(
                        fontSize: 14,
                        color: Constants.COLOR_PRIMARY,
                        fontWeight: FontWeight.bold),
                  ))
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                const Text(
                  "ORDEN DE TRABAJO: ",
                  style: TextStyle(
                      fontSize: 14,
                      color: Constants.COLOR_TERTIARY,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  lastAnswer.workOrderCode +
                      " [" +
                      lastAnswer.workOrderId.toString() +
                      "]",
                  style: const TextStyle(
                      fontSize: 14,
                      color: Constants.COLOR_PRIMARY,
                      fontWeight: FontWeight.normal),
                )
              ]),
              const SizedBox(
                height: 4,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                const Text(
                  "TIPO DE ESTUDIO: ",
                  style: TextStyle(
                      fontSize: 14,
                      color: Constants.COLOR_TERTIARY,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  lastAnswer.surveyTypeName,
                  style: const TextStyle(
                      fontSize: 14,
                      color: Constants.COLOR_PRIMARY,
                      fontWeight: FontWeight.normal),
                )
              ]),
              const SizedBox(
                height: 4,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                const Text(
                  "FRECUENCIA: ",
                  style: TextStyle(
                      fontSize: 14,
                      color: Constants.COLOR_TERTIARY,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  lastAnswer.frecuencyTypeName,
                  style: const TextStyle(
                      fontSize: 14,
                      color: Constants.COLOR_PRIMARY,
                      fontWeight: FontWeight.normal),
                )
              ]),
              const SizedBox(
                height: 4,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                const Text(
                  "TIPO DE PREGUNTAS: ",
                  style: TextStyle(
                      fontSize: 14,
                      color: Constants.COLOR_TERTIARY,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  lastAnswer.surveyConfigTypeName,
                  style: const TextStyle(
                      fontSize: 14,
                      color: Constants.COLOR_PRIMARY,
                      fontWeight: FontWeight.normal),
                )
              ]),
              const SizedBox(
                height: 4,
              ),
            ],
          )))
    ]);
  }
}
