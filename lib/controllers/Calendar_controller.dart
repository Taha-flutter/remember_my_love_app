import 'package:get/get.dart';

import 'HomeScreenController.dart';

class CalendarController extends GetxController {
  @override
  void onInit() {
    focusedDay = DateTime.now().obs;
    years = List.generate(20, (index) => focusedDay.value.year + index);

    super.onInit();
  }

  RxBool calendarHidden = false.obs;
  late Rx<DateTime> focusedDay;

  late List<int> years;

  final List<String> months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  void toggleCalendarVisibility(bool val) {
    calendarHidden.value != val ? calendarHidden.value = val : null;
  }

  String getMonthName(int month) {
    return [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ][month - 1];
  }

  int getMonthIndex(String monthName) {
    return [
          'Jan',
          'Feb',
          'Mar',
          'Apr',
          'May',
          'Jun',
          'Jul',
          'Aug',
          'Sep',
          'Oct',
          'Nov',
          'Dec',
        ].indexOf(monthName) +
        1;
  }

  void decrementYear() {
    focusedDay.value =
        DateTime(focusedDay.value.year - 1, focusedDay.value.month, 1);
  }

  void incrementYear() {
    focusedDay.value =
        DateTime(focusedDay.value.year + 1, focusedDay.value.month, 1);
  }

  void changeYear(int year) {
    focusedDay.value = DateTime(year, focusedDay.value.month, 1);
  }

  void onTabChange(DateTime focusday) {
    focusedDay.value = focusday;
    final homeController = Get.find<HomeScreenController>();
    homeController.getmemories(
        year: focusday.year.toString(), month: focusday.month.toString());
  }

  void changeMonth(String month) {
    focusedDay.value = DateTime(
        focusedDay.value.year, getMonthIndex(month), focusedDay.value.day);
  }

// Future<void> getCalendarDatesmemories({String? year, String? month}) async {
//     // ColoredPrint.green("Fetching Memories");
//     isloading.value = true;
//     ColoredPrint.green(
//         "Month: ${calendarController.focusedDay.value.month} Year: ${calendarController.focusedDay.value.year}");
//     Response? response = await ApiService.getRequest(
//         ApiConstants.getAllMemories,
//         queryParameters: {
//           "month": calendarController.focusedDay.value.month.toString(),
//           "year": calendarController.focusedDay.value.year.toString(),
//           // "search": "all",
//           "status": "all",
//           "favorites": "all",
//           "recipient": "all"
//         });
//     if (response != null) {
//       List<Map<String, dynamic>> memoryList =
//           List<Map<String, dynamic>>.from(response.data["memories"]);
//       memories.clear();
//       memories.addAll(memoryList
//           .map((memoryData) => MemoryModel.fromJson(memoryData))
//           .toList());
//       isloading.value = false;
//     }
//   }
}
