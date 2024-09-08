import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/expense.dart';

class CustomDropDownButton2 extends StatefulWidget {
  const CustomDropDownButton2({super.key, required this.dropDownValues, required this.onChanged});

  final List<WaysOfPayment> dropDownValues;
  final ValueChanged<WaysOfPayment> onChanged;
  @override
  State<CustomDropDownButton2> createState() => _CustomDropDownButtonState2();
}

class _CustomDropDownButtonState2 extends State<CustomDropDownButton2> {
  late WaysOfPayment _waysOfPayment;
  @override
  void initState() {
    _waysOfPayment = widget.dropDownValues[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {},
        style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 204, 239, 251))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DropdownButton(
                value: _waysOfPayment,
                underline: const SizedBox.shrink(),
                items: WaysOfPayment.values
                    .map(
                      (category) => DropdownMenuItem<WaysOfPayment>(
                          value: category,
                          child: Row(
                            children: [
                              Icon(categoryPaymentsIcons[category], color: Colors.black,),
                              const SizedBox(width: 5,),
                              Text(category.name),
                            ],
                          )),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }

                  setState(() {
                    _waysOfPayment = value;
                  });
                })
          ],
        ));
  }
}
