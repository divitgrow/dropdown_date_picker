// ignore_for_file: avoid_print

import 'package:datepicker_dropdown/datepicker_dropdown.dart';
import 'package:datepicker_dropdown/order_format.dart';
import 'package:datepicker_dropdown_example/main_cnt.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dropdown Datepicker Demo',
      theme: ThemeData(
        brightness: Brightness.light,
        /* light theme settings */
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        /* dark theme settings */
      ),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Dropdown Date picker Demo'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final MainCnt cnt = Get.put(MainCnt()); // Initialize GetX Controller
    print('widget');
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Form(
        key: cnt.formKey,
        autovalidateMode: AutovalidateMode.disabled,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Wrap DropdownDatePicker in Obx so it updates automatically
              Obx(
                () => DropdownDatePicker(
                  key: cnt.dropdownKey.value,
                  locale: "en",
                  dateformatorder: OrderFormat.YDM,
                  isDropdownHideUnderline: true,
                  isFormValidator: true,
                  startYear: 1900,
                  endYear: 2030,
                  width: 10,
                  selectedDay: cnt.selectedDay.value,
                  selectedMonth: cnt.selectedMonth.value,
                  selectedYear: cnt.selectedYear.value,
                  onChangedDay: (value) {
                    cnt.selectedDay.value = int.parse(value ?? '');
                    print('onChangedDay: $value');
                  },
                  onChangedMonth: (value) {
                    cnt.selectedMonth.value = int.parse(value ?? '');
                    print('onChangedMonth: $value');
                  },
                  onChangedYear: (value) {
                    cnt.selectedYear.value = int.parse(value ?? '');
                    print('onChangedYear: $value');
                  },
                ),
              ),
              MaterialButton(
                onPressed: () {
                  if (cnt.formKey.currentState!.validate()) {
                    cnt.formKey.currentState!.save();
                    DateTime? date = _dateTime(cnt.selectedDay.value,
                        cnt.selectedMonth.value, cnt.selectedYear.value);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        action: SnackBarAction(
                          label: 'OK',
                          onPressed: () {},
                        ),
                        content: Text('Selected date is $date'),
                        elevation: 20,
                      ),
                    );
                  } else {
                    print('on error');
                    cnt.update(); // Trigger UI update in GetX controller
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          cnt.selectedDay.value = 1;
          cnt.selectedMonth.value = 7;
          cnt.selectedYear.value = 2022;

          cnt.updateDropdown();

          print(
              "Updated Date: ${cnt.selectedDay.value}-${cnt.selectedMonth.value}-${cnt.selectedYear.value}");
        },
        child: const Icon(Icons.change_circle),
      ),
    );
  }

  DateTime? _dateTime(int? day, int? month, int? year) {
    if (day != null && month != null && year != null) {
      return DateTime(year, month, day);
    }
    return null;
  }
}
