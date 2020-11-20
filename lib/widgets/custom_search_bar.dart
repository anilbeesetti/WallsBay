import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    Key key,
    @required TextEditingController textController,
    this.onPressed,
  })  : _textController = textController,
        super(key: key);

  final TextEditingController _textController;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: EdgeInsets.only(left: 15),
      decoration: BoxDecoration(
          color: Colors.grey[300], borderRadius: BorderRadius.circular(30)),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              autofocus: false,
              decoration: InputDecoration(
                hintText: 'Search for wallpapers',
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.search_rounded),
            onPressed: onPressed,
          )
        ],
      ),
    );
  }
}
