import 'package:dropdown_search/dropdown_search.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:kai_mobile/core/utils/custom_component.dart';
import 'package:kai_mobile/core/utils/navigator_helper.dart';
import 'package:kai_mobile/screens/book_seat_screen.dart';
import 'package:kai_mobile/utils/app_styles.dart';
import 'package:intl/intl.dart';

class TicketOrder extends StatefulWidget {
  final Map? dataJourney;
  const TicketOrder(@required this.dataJourney);

  @override
  State<TicketOrder> createState() => _TicketOrderState();
}

class _TicketOrderState extends State<TicketOrder> {
  var _currencies = [
    "Tuan",
    "Tuan Muda",
    "Nyonya",
    "Nona",
  ];

  // List<List> controllers = [];
  var train_fare = "0";
  var inputs = [];
  var class_selected;
  var selectedClassData;
  bool _validate = false;
  var _titelSelected = null;
  final oCcy = new NumberFormat("#.##", "id_IDR");

  getClass(fares) {
    var data = fares.map((fr) => "${fr["class"]}");
    return data.toList();
  }

  getPriceClass(className, fares) {
    var data = fares.firstWhere((fr) => fr["class"] == className);
    return data;
  }

  // handleController() {
  //   for (var i = 0;
  //       i < int.parse(widget.dataJourney?["data"]["passengerCount"]);
  //       i++) {
  //     controllers.add([TextEditingController(), null]);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    List<Widget> getInputPsg() {
      // handleController();
      List<Widget> childs = [];
      for (var i in widget.dataJourney?["controllerInputs"]) {
        childs.add(Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Detail Penumpang " +
                  (widget.dataJourney?["controllerInputs"].indexOf(i) + 1)
                      .toString(),
              style: Styles.headLineStyle2
                  .copyWith(color: Colors.black, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: i[0],
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Styles.primaryBold, width: 1.5)),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Styles.primaryBold, width: 1.5)),
                  errorBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Styles.primaryBold, width: 1.5)),
                  focusedErrorBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Styles.primaryBold, width: 1.5)),
                  hintText: "Nama Lengkap",
                  prefixIcon: Icon(
                    FluentSystemIcons.ic_fluent_person_accounts_regular,
                    color: Styles.primaryBold,
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            DropdownSearch<String>(
              popupProps: PopupProps.menu(
                showSelectedItems: true,
                disabledItemFn: (String s) => s.startsWith('I'),
              ),
              items: [
                "Tuan",
                "Tuan Muda",
                "Nyonya",
                "Nona",
              ],
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Styles.primaryBold, width: 1.5)),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Styles.primaryBold, width: 1.5)),
                    errorBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Styles.primaryBold, width: 1.5)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Styles.primaryBold, width: 1.5)),
                    hintText: "Status",
                    prefixIcon: Icon(
                      FluentSystemIcons.ic_fluent_app_title_filled,
                      color: Styles.primaryBold,
                    )),
              ),
              onChanged: (value) {
                i[1] = value.toString();
              },
            ),
            Divider(
              color: Colors.grey.shade600,
              height: 50,
            )
          ],
        ));
      }
      return childs;
    }

    return Scaffold(
      backgroundColor: Styles.bgColor,
      appBar: AppBar(
        title: Text("Pesan Tiket"),
        backgroundColor: Styles.primaryBold,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: getInputPsg(),
                ),
                DropdownSearch<dynamic>(
                  popupProps: PopupProps.menu(),
                  items: getClass(widget.dataJourney?["detail"]["train_fare"]),
                  dropdownDecoratorProps: DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Styles.primaryBold, width: 1.5)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Styles.primaryBold, width: 1.5)),
                        hintText: "Pilih Class",
                        errorText: _validate ? 'Wajib diisi!' : null,
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Styles.primaryBold, width: 1.5)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Styles.primaryBold, width: 1.5)),
                        prefixIcon: Icon(
                          FluentSystemIcons.ic_fluent_ticket_filled,
                          color: Styles.primaryBold,
                        )),
                  ),
                  onChanged: (value) {
                    setState(() => class_selected = value);
                    setState(() => train_fare =
                        "${getPriceClass(value, widget.dataJourney?["detail"]?["train_fare"])['fare']}");
                    setState(() => selectedClassData = getPriceClass(
                        value, widget.dataJourney?["detail"]?["train_fare"]));
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.all(10),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Kereta",
                  style: Styles.headLineStyle2.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                    "${widget.dataJourney?['detail']?['train_station_depart']?['station_code']} - ${widget.dataJourney?['detail']?['train_station_arrival']?['station_code']}   |   ${widget.dataJourney?['detail']?['depart_time'].split(' ')[0]}   |   ${widget.dataJourney?['detail']?['depart_time'].split(' ')[1].split(':')[0]}:${widget.dataJourney?['detail']?['depart_time'].split(' ')[1].split(':')[1]}"),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Harga",
                  style: Styles.headLineStyle2.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 18),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Pergi",
                  style: Styles.headLineStyle3.copyWith(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 7,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Penumpang x" +
                        widget.dataJourney!["data"]["passengerCount"]
                            .toString()),
                    Text(NumberFormat.currency(
                            locale: "id", symbol: "Rp. ", decimalDigits: 0)
                        .format((int.parse(
                                widget.dataJourney?["data"]["passengerCount"]) *
                            int.parse(train_fare)))
                        .toString())
                  ],
                ),
                Divider(
                  color: Colors.grey.shade600,
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total Pembayaran",
                      style: Styles.headLineStyle1
                          .copyWith(color: Colors.black, fontSize: 15),
                    ),
                    Text(
                      NumberFormat.currency(
                              locale: "id", symbol: "Rp. ", decimalDigits: 0)
                          .format((int.parse(widget.dataJourney?["data"]
                                  ["passengerCount"]) *
                              int.parse(train_fare)))
                          .toString(),
                      style: Styles.headLineStyle1
                          .copyWith(color: Styles.primaryBold, fontSize: 18),
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              var passengers = [];
              widget.dataJourney?["controllerInputs"].forEach((element) {
                passengers.add({
                  "name": element[0].text,
                  "status":
                      element[1] != null ? element[1].toLowerCase() : "tuan"
                });
              });

              if (selectedClassData == null) {
                setState(() {
                  _validate = true;
                });
              }

              if (selectedClassData?["wagon"] == null &&
                  selectedClassData?["wagon"]?["wagon_seat"] == null) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Kursi sudah tidak tersedia!"),
                  backgroundColor: Colors.red,
                ));
              }

              if (int.parse(widget.dataJourney?["data"]?["passengerCount"]) >
                  selectedClassData?["wagon"]?["wagon_seat"].length) {
                setState(() {
                  _validate = true;
                });
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Kursi tidak cukup!"),
                  backgroundColor: Colors.red,
                ));
              }

              if (_validate == false || selectedClassData.length > 0) {
                widget.dataJourney?["data"]["totalPay"] =
                    (int.parse(widget.dataJourney?["data"]["passengerCount"]) *
                            int.parse(train_fare))
                        .toString();
                widget.dataJourney?["data"]?["class_selected"] =
                    selectedClassData?["class"];
                widget.dataJourney?["data"]?["fare_selected"] =
                    selectedClassData?["id"].toString();
                widget.dataJourney?["passengers"] = passengers;
                goPush(BookSeat(widget.dataJourney));
              }
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                color: Styles.primaryBold,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                  child: Text(
                "Pilih Kursi",
                style: Styles.headLineStyle3.copyWith(color: Colors.white),
              )),
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ]),
      )),
    );
  }
}
