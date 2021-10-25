import 'package:flutter/material.dart';
import 'package:crop_sales_app/styles/colors.dart';

class SearchBar extends StatefulWidget {
  final String keyword;
  final Function myOntap;
  const SearchBar({Key? key, required this.myOntap, this.keyword = ''}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final _textEditController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // The search keywords passed in from other pages bind
    // the value of the current input box to the value passed in.
    _textEditController.text = widget.keyword;
    // Control the input box cursor position to the last word.
    _textEditController.selection = TextSelection.fromPosition(
      TextPosition(
          affinity: TextAffinity.downstream, offset: widget.keyword.length),
    );
    return Container(
      color: Colors.white,
      height: 50,
      padding: EdgeInsets.only(top: 7, right: 15, bottom: 7, left: 15),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFF5F7F7),
                borderRadius: BorderRadius.circular(49 * 0.5),
              ),
              child: Container(
                child: TextField(
                  controller: _textEditController,
                  cursorColor: AppColors.primaryColor,
                  decoration: InputDecoration(
                    prefixIcon: Image.asset(
                      'assets/images/home/sousuo.png',
                      width: 15,
                      height: 15,
                    ),
                    isDense: true,
                    hintText: "Tomato",
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            /// Passes the input value callback to the click function.
            onTap: () => widget.myOntap(_textEditController.text),
            child: Container(
              padding: EdgeInsets.only(left: 12),
              child: Text(
                'Search',
                style: TextStyle(
                  color: Color(0xFF17191A),
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
