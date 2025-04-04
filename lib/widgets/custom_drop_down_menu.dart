import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_trial/utils/constants.dart';
import 'package:task_trial/views/dashboard/dashboard_screen.dart';
class CustomDropDownMenu extends StatelessWidget {
  const CustomDropDownMenu({super.key});


  @override
  Widget build(BuildContext context) {
    List<String> items = [
      'Today',
      'Last Week',
      'Last 15 Days',
      'Last 30 Days',
    ];
    return  Stack(
      children: [
     Positioned(
       top: 15,
       left: 14,
       child: Container(
        height: 25,
        width: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
        ),
       ),
     ),
      Positioned(
        child: DropdownMenu(
            initialSelection: items[0],
            width: 140,
            enabled: true,
            textAlign: TextAlign.start,
            menuStyle: MenuStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: Colors.transparent,
                  width: 2,
                ),
              )),
              elevation: MaterialStateProperty.all(0),
            ),
            inputDecorationTheme: InputDecorationTheme(
              contentPadding: const EdgeInsets.only(left: 20),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 2,
                ),
              ),
            ),
            textStyle: TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontFamily: Constants.primaryFont,
              fontWeight: FontWeight.w600,
            ),
            onSelected: (value) {
              _onMenuItemSelected(value!);
            },

            dropdownMenuEntries: [
              DropdownMenuEntry<String>(
                label: items[0],
                value: items[0],
              ),
              DropdownMenuEntry<String>(
                label: items[1],
                value: items[1],
              ),
              DropdownMenuEntry<String>(
                label: items[2],
                value: items[2],
              ),
              DropdownMenuEntry<String>(
                label: items[3],
                value: items[3],
              ),
            ]),
      )
      ],
    );
  }
  void _onMenuItemSelected(String value) {
    print('Selected value: $value');
  }
}
