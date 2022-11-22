import 'package:flutter/material.dart';

class BottomButtom extends StatefulWidget {
  const BottomButtom(
      {super.key,
      this.loading,
      this.enabled,
      required this.onPress,
      required this.title,
      this.color});

  final String title;
  final bool? enabled;
  final bool? loading;
  final Function onPress;
  final Color? color;

  @override
  State<BottomButtom> createState() => _BottomButtomState();
}

class _BottomButtomState extends State<BottomButtom> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: widget.loading != true
            ? ElevatedButton(
                onPressed: widget.enabled != false
                    ? () {
                        widget.onPress();
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.color,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(widget.title),
              )
            : ElevatedButton(
                onPressed: null,
                style: ElevatedButton.styleFrom(
                  disabledBackgroundColor: widget.color ?? Colors.black,
                  foregroundColor: Colors.white,
                  shadowColor: Colors.transparent,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const SizedBox(
                  width: 25,
                  height: 25,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              ));
  }
}
