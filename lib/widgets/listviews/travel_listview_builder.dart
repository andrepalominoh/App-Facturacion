import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lya_encuestas/assets/constants.dart';
import 'package:lya_encuestas/classes/database/models/last_answer.dart';
import 'package:lya_encuestas/classes/database/models/travel.dart';
// import 'package:lya_encuestas/screens/menu_pages/add_payment_form_screen.dart';
import 'package:lya_encuestas/widgets/custom_buttom.dart';

class TravelListViewBuilder {
  static Widget build(BuildContext context, List<Travel> data, onTapItem) {
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
                      child: buildTravelItem(data[index],context));
                },
              ),
            ),
          ],
        ));
  }

  static Widget buildTravelItem(Travel travel,BuildContext context) {
    TextEditingController txtPurchase = TextEditingController();

    return Column(children: [
      const SizedBox(
        height: 8,
        child: Divider(),
      ),
      ListTile(
          title: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Center(
                          child: Text(
                            "Viaje " + travel.id.toString() + ":",
                            style: const TextStyle(
                                fontSize: 14,
                                color: Constants.COLOR_PRIMARY,
                                fontWeight: FontWeight.bold),
                          )
                      ),
                      Center(
                          child: Text(
                           (travel.name),
                            style: const TextStyle(
                                fontSize: 14,
                                color: Constants.COLOR_PRIMARY,
                                fontWeight: FontWeight.bold),
                          ),
                      ),
                      Center(
                        child:
                        CustomButton(title: "Registrar cobros", onPressed: () => RegistrarCobros(context,travel)),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                ],
              )))
    ]);

  }
  static Future<void> RegistrarCobros(BuildContext context,Travel objTravel) async {
    // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => AddPaymentFormScreen(SelTravel: objTravel,)),(route) => true);
  }

}
