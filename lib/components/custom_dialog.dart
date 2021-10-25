import 'package:flutter/material.dart';

///Dialog
class CustomDialog extends StatefulWidget {
  //------------------no img dialog------------------------
  final String? title; //title
  final TextStyle? titleStyle;
  final Widget? content;
  final String? confirmContent;
  final String? cancelContent;
  final Color? confirmTextColor;
  final bool? isCancel;
  final Color? confirmColor;
  final Color? cancelColor;
  final Color? cancelTextColor;
  final bool? outsideDismiss;
  final Function? confirmCallback;
  final Function? dismissCallback;

  //------------------with img dialog------------------------
  final String? image; //dialog img
  final String? imageHintText; //Text tips below the image

  const CustomDialog({
    Key? key,
    this.title,
    this.content,
    this.confirmContent,
    this.confirmTextColor,
    this.isCancel = true,
    this.confirmColor,
    this.cancelColor,
    this.outsideDismiss = true,
    this.confirmCallback,
    this.dismissCallback,
    this.image,
    this.imageHintText,
    this.titleStyle,
    this.cancelContent,
    this.cancelTextColor,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CustomDialogState();
  }
}

class _CustomDialogState extends State<CustomDialog> {
  _confirmDialog() {
    Navigator.of(context).pop(1);
    Future.delayed(Duration(milliseconds: 250), () {
      if (widget.confirmCallback != null) {
        widget.confirmCallback!();
      }
    });
  }

  _dismissDialog() {
    Navigator.of(context).pop(0);
    Future.delayed(Duration(milliseconds: 250), () {
      if (widget.dismissCallback != null) {
        widget.dismissCallback!();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;

    Column _columnText = Column(
      children: <Widget>[
        SizedBox(height: widget.title == null ? 0 : 15.0),
        // title
        Container(
          height: 60,
          child: Text(
            widget.title ?? '',
            style: widget.titleStyle,
          ),
        ),
        // Content
        Container(
          height: 100,
          child: Center(
            child: widget.content,
          ),
        ),
        SizedBox(height: 0.5, child: Container(color: Color(0xDBDBDBDB))),
        // Bottom button
        Container(
          height: 55,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: widget.isCancel ?? true
                    ? Container(
                        height: 55,
                        decoration: BoxDecoration(
                            color: widget.cancelColor == null ? Color(0xFFFFFFFF) : widget.cancelColor,
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16.0))),
                        child: FlatButton(
                          child: Text(widget.cancelContent ?? 'Cancel',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w400,
                                color: widget.cancelColor == null
                                    ? (widget.cancelTextColor == null ? Colors.black87 : widget.cancelTextColor)
                                    : Color(0xFFFFFFFF),
                              )),
                          onPressed: _dismissDialog,
                          splashColor: widget.cancelColor == null ? Color(0xFFFFFFFF) : widget.cancelColor,
                          highlightColor: widget.cancelColor == null ? Color(0xFFFFFFFF) : widget.cancelColor,
                        ),
                      )
                    : Text(''),
                flex: widget.isCancel ?? true ? 1 : 0,
              ),
              SizedBox(width: widget.isCancel ?? true ? 1.0 : 0, child: Container(color: Color(0xDBDBDBDB))),
              Expanded(
                  child: Container(
                    height: 55,
                    decoration: BoxDecoration(
                      color: widget.confirmColor == null ? Color(0xFFFFFFFF) : widget.confirmColor,
                      borderRadius: widget.isCancel ?? true
                          ? BorderRadius.only(bottomRight: Radius.circular(16.0))
                          : BorderRadius.only(bottomLeft: Radius.circular(16.0), bottomRight: Radius.circular(16.0)),
                    ),
                    child: FlatButton(
                      onPressed: _confirmDialog,
                      child: Text(widget.confirmContent ?? 'Enter',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                            color: widget.confirmColor == null
                                ? (widget.confirmTextColor == null ? Colors.black87 : widget.confirmTextColor)
                                : Color(0xFFFFFFFF),
                          )),
                      splashColor: widget.confirmColor == null ? Color(0xFFFFFFFF) : widget.confirmColor,
                      highlightColor: widget.confirmColor == null ? Color(0xFFFFFFFF) : widget.confirmColor,
                    ),
                  ),
                  flex: 1),
            ],
          ),
        )
      ],
    );

    Column _columnImage = Column(
      children: <Widget>[
        SizedBox(
          height: widget.imageHintText == null ? 35.0 : 23.0,
        ),
        Image(image: AssetImage(widget.image ?? ''), width: 72.0, height: 72.0),
        SizedBox(height: 10.0),
        Text(widget.imageHintText ?? '', style: TextStyle(fontSize: 16.0)),
      ],
    );

    /// Route Interception
    return WillPopScope(
        child: GestureDetector(
          onTap: () => {widget.outsideDismiss ?? true ? _dismissDialog() : null},
          child: Material(
            type: MaterialType.transparency,
            child: Center(
              child: Container(
                width: widget.image == null ? width - 100.0 : width - 150.0,
                height: 231.0,
                alignment: Alignment.center,
                child: widget.image == null ? _columnText : _columnImage,
                decoration: BoxDecoration(color: Color(0xFFFFFFFF), borderRadius: BorderRadius.circular(16.0)),
              ),
            ),
          ),
        ),
        onWillPop: () async {
          return widget.outsideDismiss ?? true;
        });
  }
}
