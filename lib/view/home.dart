import 'package:algo/view/reusable_ui/reusable_glass_button.dart';
import 'package:algo/viewmodel/controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({Key? key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final algo = Provider.of<CounterModel>(context); // Access the model

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('${algo.getTitle()}'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: height * 0.65,
            // color: Color.fromARGB(82, 135, 18, 212),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: algo.buildBars(context),
            ),
          ),
          Container(
            // color: Color.fromARGB(94, 18, 201, 125),
            // height: height * 0.34,
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: height * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Sorting Time- ${algo.milliseconds} ms",
                      style: TextStyle(fontSize: height * 0.022),
                    ),
                    SizedBox(
                      width: width * 0.05,
                    ),
                    IconButton(
                        onPressed: () {
                          algo.reset();
                        },
                        icon: Icon(
                          Icons.replay,
                          size: height * 0.035,
                          color: Color.fromARGB(255, 182, 75, 56),
                        )),
                    SizedBox(
                      width: width * 0.05,
                    ),
                    IconButton(
                        onPressed: () {
                          if (algo.isSorteda == false) {
                            algo.sort(context);
                          } else {
                            algo.reset();
                          }
                        },
                        icon: Icon(
                          algo.isSorteda ? Icons.pause : Icons.play_arrow,
                          size: height * 0.035,
                        )),
                  ],
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                //   children: [
                //     // GlassmorphicButton(
                //     //   key: UniqueKey(), // or any other key you prefer
                //     //   text: 'Reset',
                //     //   width: width * 0.3,
                //     //   height: height * 0.06,
                //     //   gradientColor1: Color(0xFFE0FFFF), // Light blue color
                //     //   gradientColor2:
                //     //       Color(0xFF7FFFD4), // Another light blue color
                //     //   onPressed: () {
                //     //     // Add your onPressed functionality here
                //     //     algo.reset();
                //     //   },
                //     // ),
                // IconButton(
                //     onPressed: () {
                //       if (algo.isSorteda == false) {
                //         algo.sort(context);
                //       } else {
                //         algo.reset();
                //       }
                //     },
                //     icon: Icon(
                //       algo.isSorteda ? Icons.pause : Icons.play_arrow,
                //       size: height * 0.035,
                //     )),

                //   ],
                // ),

                GlassmorphicButton(
                  key: UniqueKey(), // or any other key you prefer
                  text: 'Choose algo',
                  width: width * 0.9, // Adjusted the width
                  height: height * 0.06,
                  gradientColor1:
                      Color.fromARGB(255, 243, 255, 224), // Light blue color
                  gradientColor2: Color.fromARGB(
                      255, 234, 127, 255), // Another light blue color
                  onPressed: () {
                    // Add your onPressed functionality here
                    algo.listOfalog(context);
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
