import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kai_mobile/core/utils/navigator_helper.dart';
import 'package:kai_mobile/screens/bottom_bar.dart';
import 'package:kai_mobile/screens/home_screen.dart';
import 'package:kai_mobile/screens/new_ticket_screen.dart';
import 'package:kai_mobile/screens/ticket_screen.dart';
import 'package:kai_mobile/utils/app_styles.dart';
import 'package:lottie/lottie.dart';

class LoadTicket extends StatefulWidget {
  final List dataTicket;
  const LoadTicket(@required this.dataTicket);

  @override
  State<LoadTicket> createState() => _LoadTicketState();
}

class _LoadTicketState extends State<LoadTicket> {
  SwitchPage() async {
    await Future.delayed(Duration(seconds: 3));
    var data = widget.dataTicket;
    goRemove(NewTicket(data));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SwitchPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                "assets/images/load_ticket.json",
              ),
            ]),
      ),
    );
  }
}
