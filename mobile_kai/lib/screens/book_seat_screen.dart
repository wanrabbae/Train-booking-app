import 'package:book_my_seat/book_my_seat.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kai_mobile/core/utils/navigator_helper.dart';
import 'package:kai_mobile/screens/bottom_bar.dart';
import 'package:kai_mobile/screens/load_ticket.dart';
import 'package:kai_mobile/screens/ticket_screen.dart';
import 'package:kai_mobile/utils/app_layout.dart';
import 'package:kai_mobile/utils/app_styles.dart';

class BookSeat extends StatefulWidget {
  final Map? dataJourney;
  const BookSeat(@required this.dataJourney);

  @override
  State<BookSeat> createState() => _BookSeatState();
}

class _BookSeatState extends State<BookSeat> {
  Set<SeatNumber> selectedSeats = Set();
  @override
  Widget build(BuildContext context) {
    print(widget.dataJourney);
    return Scaffold(
      backgroundColor: Styles.bgColor,
      appBar: AppBar(
        title: Text("Pilih Kursi"),
        backgroundColor: Styles.primaryBold,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 16,
            ),
            const Text("The Door"),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              width: double.infinity,
              // height: 500,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SeatLayoutWidget(
                    onSeatStateChanged: (rowI, colI, seatState) {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: seatState == SeatState.selected
                              ? Text("Selected Seat[$rowI][$colI]")
                              : Text("De-selected Seat[$rowI][$colI]"),
                        ),
                      );
                      if (seatState == SeatState.selected) {
                        selectedSeats.add(SeatNumber(rowI: rowI, colI: colI));
                      } else {
                        selectedSeats
                            .remove(SeatNumber(rowI: rowI, colI: colI));
                      }
                    },
                    stateModel: const SeatLayoutStateModel(
                      pathDisabledSeat: 'assets/svg_disabled_bus_seat.svg',
                      pathSelectedSeat: 'assets/svg_selected_bus_seats.svg',
                      pathSoldSeat: 'assets/svg_sold_bus_seat.svg',
                      pathUnSelectedSeat: 'assets/svg_unselected_bus_seat.svg',
                      rows: 12,
                      cols: 4,
                      seatSvgSize: 40,
                      currentSeatsState: [
                        [
                          SeatState.unselected,
                          SeatState.unselected,
                          SeatState.unselected,
                          SeatState.unselected,
                        ],
                        [
                          SeatState.unselected,
                          SeatState.unselected,
                          SeatState.unselected,
                          SeatState.unselected,
                        ],
                        [
                          SeatState.unselected,
                          SeatState.unselected,
                          SeatState.unselected,
                          SeatState.unselected,
                        ],
                        [
                          SeatState.unselected,
                          SeatState.unselected,
                          SeatState.unselected,
                          SeatState.unselected,
                        ],
                        [
                          SeatState.unselected,
                          SeatState.unselected,
                          SeatState.unselected,
                          SeatState.unselected,
                        ],
                        [
                          SeatState.unselected,
                          SeatState.unselected,
                          SeatState.unselected,
                          SeatState.unselected,
                        ],
                        [
                          SeatState.unselected,
                          SeatState.unselected,
                          SeatState.unselected,
                          SeatState.unselected,
                        ],
                        [
                          SeatState.unselected,
                          SeatState.unselected,
                          SeatState.unselected,
                          SeatState.unselected,
                        ],
                        [
                          SeatState.unselected,
                          SeatState.unselected,
                          SeatState.unselected,
                          SeatState.unselected,
                        ],
                        [
                          SeatState.unselected,
                          SeatState.unselected,
                          SeatState.unselected,
                          SeatState.unselected,
                        ],
                        [
                          SeatState.unselected,
                          SeatState.unselected,
                          SeatState.unselected,
                          SeatState.unselected,
                        ],
                        [
                          SeatState.unselected,
                          SeatState.unselected,
                          SeatState.unselected,
                          SeatState.unselected,
                        ],
                        [
                          SeatState.unselected,
                          SeatState.unselected,
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        'assets/svg_disabled_bus_seat.svg',
                        width: 20,
                        height: 20,
                      ),
                      const Text('Disabled')
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        'assets/svg_sold_bus_seat.svg',
                        width: 20,
                        height: 20,
                      ),
                      const Text('Sold')
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        'assets/svg_unselected_bus_seat.svg',
                        width: 20,
                        height: 20,
                      ),
                      const Text('Available')
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        'assets/svg_selected_bus_seats.svg',
                        width: 20,
                        height: 20,
                      ),
                      const Text('Selected by you')
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: GestureDetector(
                onTap: () {
                  print(widget.dataJourney);
                  goRemove(LoadTicket(), context);
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Styles.primaryBold,
                    borderRadius:
                        BorderRadius.circular(AppLayout.getHeight(15)),
                  ),
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      "Pesan Tiket",
                      style: Styles.headLineStyle3
                          .copyWith(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(selectedSeats.join(" , "))
          ],
        ),
      ),
    );
  }
}

class SeatNumber {
  final int rowI;
  final int colI;

  const SeatNumber({required this.rowI, required this.colI});

  @override
  bool operator ==(Object other) {
    return rowI == (other as SeatNumber).rowI &&
        colI == (other as SeatNumber).colI;
  }

  @override
  int get hashCode => rowI.hashCode;

  @override
  String toString() {
    return '[$rowI][$colI]';
  }
}
