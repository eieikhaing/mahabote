import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var selectedDate = DateTime.now();
  var selected = false;
  var f = DateFormat("dd/MM/yyyy EEEE");
  var day = DateFormat("EEEE");
  var modVal = 0;
  var indexOfModValue = 0;
  var houseName = "";
  var isChecked = false;
  var showCheck = false;
  late DateTime? picked;
  var myanmarYear;
  var housesSequence = [
    {"key": 1, "value": 'Sunday'},
    {"key": 4, "value": 'Wednesday'},
    {"key": 0, "value": 'Saturday'},
    {"key": 3, "value": 'Tuesday'},
    {"key": 6, "value": 'Friday'},
    {"key": 2, "value": 'Monday'},
    {"key": 5, "value": 'Thursday'}
  ];

  var housesSequencyByModVal = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Mahabote"),
      ),
      body: _homeDesign(),
    );
  }

  var selectedBirthday = "";
  TextStyle _selectedBoteColor(val, birthday) => TextStyle(
      color: selectedBirthday == birthday
          ? Theme.of(context).primaryColor
          : Colors.black);
  Text _labelBoteText(val, birthday) =>
      Text(val, style: _selectedBoteColor(val, birthday));

  TextStyle _selectedColor(val) => TextStyle(
      color: houseName == val ? Theme.of(context).primaryColor : Colors.black);

  Text _labelText(val) => Text(val, style: _selectedColor(val));

  Widget _mahaboteLayout() => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(""),
                _labelText("အဓိပတိ"),
                const Text(""),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _labelText("အထွန်း"),
                _labelText("သိုက်"),
                _labelText("ရာဇ"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _labelText("မရဏ"),
                _labelText("ဘင်္ဂ"),
                _labelText("ပုတိ"),
              ],
            ),
          ],
        ),
      );

  Widget _mahaboteSequenceLayout() => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(""),
                _labelBoteText("${housesSequencyByModVal[6]["key"]}",
                    housesSequencyByModVal[6]["value"]),
                const Text(""),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _labelBoteText("${housesSequencyByModVal[2]["key"]}",
                    housesSequencyByModVal[2]["value"]),
                _labelBoteText("${housesSequencyByModVal[3]["key"]}",
                    housesSequencyByModVal[3]["value"]),
                _labelBoteText("${housesSequencyByModVal[4]["key"]}",
                    housesSequencyByModVal[4]["value"]),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _labelBoteText("${housesSequencyByModVal[1]["key"]}",
                    housesSequencyByModVal[1]["value"]),
                _labelBoteText("${housesSequencyByModVal[0]["key"]}",
                    housesSequencyByModVal[0]["value"]),
                _labelBoteText("${housesSequencyByModVal[5]["key"]}",
                    housesSequencyByModVal[5]["value"]),
              ],
            ),
          ],
        ),
      );

  String _houseResult(year, day) {
    var houses = ["ဘင်္ဂ", "အထွန်း", "ရာဇ", "အဓိပတိ", "မရဏ", "သိုက်", "ပုတိ"];
    return houses[(year - day - 1) % 7];
  }

  Widget _homeDesign() => ListView(
        children: <Widget>[
          Container(
            height: 120,
            color: Theme.of(context).primaryColor,
            child: ElevatedButton(
                onPressed: () async {
                  picked = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(1800),
                      lastDate: DateTime(2025),
                      helpText: 'Select Your Birthday',
                      cancelText: 'Not now');
                  if (picked != null) {
                    myanmarYear = picked!.year - 638;
                    isChecked = false;
                    setState(() {
                      calculateBoteResult();
                    });
                  }
                },
                child: selected
                    ? Text(f.format(selectedDate))
                    : const Text("Select Your Birthday")),
          ),
          showCheck == false
              ? Container()
              : Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      const Text("borned before Thingun HnitSan 1st Day?"),
                      Checkbox(
                        checkColor: Colors.white,
                        value: isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value!;
                            calculateBoteResult();
                          });
                        },
                      ),
                    ],
                  ),
                ),
          Container(
            margin: const EdgeInsets.all(12),
            height: 150,
            child: Card(child: Center(child: _mahaboteLayout())),
          ),
          selected == false
              ? Container()
              : Container(
                  margin: const EdgeInsets.all(12),
                  child: Card(
                      child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            children: [
                              Text("အကြွင်း $modVal"),
                              Text(
                                houseName,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor),
                              ),
                            ],
                          ))),
                ),
          selected == false
              ? Container()
              : Container(
                  margin: const EdgeInsets.all(12),
                  height: 150,
                  child: Card(child: Center(child: _mahaboteSequenceLayout())),
                )
        ],
      );

  void calculateBoteResult() {
    setState(() {
      if (picked!.month < 4) {
        myanmarYear = picked!.year - 639;
      }

      if (picked!.month == 4) {
        showCheck = true;
        if (isChecked) {
          myanmarYear = picked!.year - 639;
        } else {
          myanmarYear = picked!.year - 638;
        }
      } else {
        showCheck = false;
      }
      selectedDate = picked!;
      modVal = myanmarYear % 7;
      houseName = _houseResult(myanmarYear, picked!.weekday);
      selected = true;
      selectedBirthday = day.format(selectedDate);
      final index =
          housesSequence.indexWhere((element) => element["key"] == modVal);

      housesSequencyByModVal =
          housesSequence.sublist(index) + housesSequence.sublist(0, index);
    });
  }
}
