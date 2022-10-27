import 'package:flutter/material.dart';

class BottomButtom extends StatefulWidget {
  const BottomButtom(
      {super.key,
      this.isLoading,
      this.isButtonActive,
      required this.onPress,
      required this.title});

  final String title;
  final bool? isButtonActive;
  final bool? isLoading;
  final Function onPress;

  @override
  State<BottomButtom> createState() => _BottomButtomState();
}

class _BottomButtomState extends State<BottomButtom> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        margin: const EdgeInsets.all(20),
        child: widget.isLoading != true
            ? ElevatedButton(
                onPressed: widget.isButtonActive != false
                    ? () {
                        widget.onPress();
                      }
                    : null,
                child: Text(widget.title))
            : ElevatedButton(
                onPressed: null,
                style: ElevatedButton.styleFrom(
                  disabledBackgroundColor: Colors.black,
                  foregroundColor: Colors.white,
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
