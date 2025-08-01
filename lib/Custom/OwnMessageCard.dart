import 'package:flutter/material.dart';

class OwnMessageCard extends StatelessWidget {
  const OwnMessageCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints:
        BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width -45,
        ),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: Color(0xffdcf8c6),
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  top: 60,
                  right: 5,
                  bottom: 20,
                ),
                child: Text(
                  "oishafeaeeeeeeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaehwifoe qwfhoieqwfheoi",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  ),
              ),
              Positioned(
                bottom: 4,
                right: 10,

                child: Row(
                  children: [
                    Text(
                      "20:58",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.done_all,
                      size: 20,
                      ),

                  ],
                ),
              ),
            ],
          ),
        ),
        ),
    );
  }
}