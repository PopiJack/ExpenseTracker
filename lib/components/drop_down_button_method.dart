import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/expense.dart';

class CustomDropDownButton extends StatefulWidget {
  const CustomDropDownButton({super.key, required this.dropDownValues, required this.onChanged});

  final List dropDownValues;
  final ValueChanged<Category> onChanged;

  @override
  State<CustomDropDownButton> createState() => _CustomDropDownButtonState();
}

class _CustomDropDownButtonState extends State<CustomDropDownButton> {
  late Category _selectedCategory;

  @override
  void initState() {
    _selectedCategory = widget.dropDownValues[0];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {},
        style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 204, 251, 208))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DropdownButton(
                value: _selectedCategory,
                underline: const SizedBox.shrink(),
                items: Category.values
                    .map(
                      (category) => DropdownMenuItem(
                          value: category,
                          child: Row(
                            children: [
                              Icon(categoryIcons[category], color: Colors.black,),
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
                    _selectedCategory = value;
                  });
                  widget.onChanged(value);
                })
          ],
        ));
  }
}
