import 'package:flutter/material.dart';

class CustomDropDown extends StatelessWidget {
  final String hintText;
  final String dText;
  final String drValue;
  final List data;
  final Function onChanged;
  final Function onTap;
  final bool misc;
  CustomDropDown(
      {this.hintText,
      this.misc,
      this.onChanged,
      this.drValue,
      this.data,
      this.dText,
      this.onTap});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 2, 1, 2),
      child: DropdownButton(
        elevation: 20,
        isDense: true,
        isExpanded: true,
        autofocus: true,
        icon: Icon(Icons.arrow_drop_down),
        iconEnabledColor: Colors.black,
        iconDisabledColor: Colors.grey[200],
        iconSize: 36,
        dropdownColor: Colors.grey[50],
        hint: Text(
          hintText,
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        value: drValue,
        items: data.map((item) {
          return DropdownMenuItem(
            child: misc
                ? Text(
                    item[dText],
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : Text(
                    "${item['from_time'].toString().substring(0, 5)}  to ${item['to_time'].toString().substring(0, 5)} ",
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
            value: item['id'].toString(),
          );
        }).toList(),
        onChanged: (String val) {
          onChanged(val);
        },
        onTap: onTap,
      ),
    );
  }
}
