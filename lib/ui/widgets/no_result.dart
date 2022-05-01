import 'package:flutter/material.dart';
import 'package:tv_shows/ui/utils/util.dart';

class NoResult extends StatelessWidget {
  final VoidCallback onTap;
  NoResult({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.search,
            color: Style.primaryColor,
            size: 100,
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            'No tv show found.',
            style: Style.titleTextStyle.copyWith(
                color: Style.primaryColor, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 12,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: Style.outlineCardDecoration.copyWith(
                color: Colors.transparent,
                border: Border.all(color: Style.primaryColor, width: 1.3)),
            child: FlatButton(
                padding: const EdgeInsets.symmetric(vertical: 0),
                child: Text(
                  'Init',
                  style: Style.defaultTextStyle
                      .copyWith(fontSize: 14, color: Style.primaryColor),
                ),
                onPressed: onTap),
          ),
        ],
      ),
    );
  }
}
