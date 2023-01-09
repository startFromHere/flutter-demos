import 'package:flutter/material.dart';

class RowsAndColumnsWidget extends StatelessWidget {
  const RowsAndColumnsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("rows and columns test"),
      ),
      body: Center(
          child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Text("A"),
                      Spacer(
                        flex: 1,
                      ),
                      Text("B"),
                      Spacer(
                        flex: 2,
                      ),
                      Text("C")
                    ],
                  ),
                  Container(
                    height: 20,
                    color: Colors.orange,
                  ),
                  Row(
                    children: [
                      Text("1"),
                      Spacer(
                        flex: 2,
                      ),
                      Text("2"),
                      Spacer(
                        flex: 1,
                      ),
                      Text("3")
                    ],
                  ),
                ],
              ))),
    );
  }
}
