import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:pie_chart/pie_chart.dart' as pc;

class Statistics extends StatefulWidget {
  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  double _mediaHeight;
  double _mediaWidth;
  final Color barBackgroundColor = const Color(0xffff0000);

  int page = 0;

  List<Slider> slides = new List();

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = Colors.red,
    double width = 35,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: isTouched ? y + 1 : y,
          colors: isTouched ? [Colors.black] : [barColor],
          width: width,
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  BarChartData mainBarData() {
    return BarChartData(
      alignment: BarChartAlignment.spaceAround,
      maxY: 100,
      barTouchData: BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: const EdgeInsets.all(0),
          tooltipBottomMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.y.round().toString(),
              TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
              color: Color(0xff7589a2),
              fontWeight: FontWeight.bold,
              fontSize: 14),
          margin: 20,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                return 'Mn';
              case 1:
                return 'Te';
              case 2:
                return 'Wd';
              case 3:
                return 'Tu';
              case 4:
                return 'Fr';
              case 5:
                return 'St';
              case 6:
                return 'Sn';
              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(showTitles: false),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: [
        BarChartGroupData(
          x: 0,
          barRods: [
            BarChartRodData(
                y: 38,
                width: 25,
                colors: [Colors.lightBlueAccent, Colors.greenAccent])
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(
                y: 60,
                width: 25,
                colors: [Colors.lightBlueAccent, Colors.greenAccent])
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 2,
          barRods: [
            BarChartRodData(
                y: 52,
                width: 25,
                colors: [Colors.lightBlueAccent, Colors.greenAccent])
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 3,
          barRods: [
            BarChartRodData(
                y: 65,
                width: 25,
                colors: [Colors.lightBlueAccent, Colors.greenAccent])
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 3,
          barRods: [
            BarChartRodData(
                y: 73,
                width: 25,
                colors: [Colors.lightBlueAccent, Colors.greenAccent])
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 3,
          barRods: [
            BarChartRodData(
                y: 60,
                width: 25,
                colors: [Colors.lightBlueAccent, Colors.greenAccent])
          ],
          showingTooltipIndicators: [0],
        ),
      ],
    );
  }

  Widget barChart() {
    return Column(children: [
      Row(
        children: [
          SizedBox(width: 13),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 45, vertical: _mediaHeight * 0.03),
            child: BarChart(mainBarData()),
          )
        ],
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: _mediaWidth * 0.3 + 5,
              height: _mediaWidth * 0.3 + 5,
              child: Padding(
                padding: EdgeInsets.all(7),
                child: Container(
                    child: Center(
                        child: Text(
                      "23 \nTotal",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          height: 1.3, fontSize: 24, color: Colors.grey[800]),
                    )),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      shape: BoxShape.circle,
                    )),
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.lightBlueAccent, Colors.greenAccent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: _mediaWidth * 0.3 + 5,
              height: _mediaWidth * 0.3 + 5,
              child: Padding(
                padding: EdgeInsets.all(7),
                child: Container(
                    child: Center(
                        child: Text(
                      "4 \n Average",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          height: 1.2, fontSize: 24, color: Colors.grey[800]),
                    )),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      shape: BoxShape.circle,
                    )),
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.lightBlueAccent, Colors.greenAccent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 30),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: _mediaWidth * 0.3 + 5,
              height: _mediaWidth * 0.3 + 5,
              child: Padding(
                padding: EdgeInsets.all(7),
                child: Container(
                    child: Center(
                        child: Text(
                      "2 \nFailed",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          height: 1.3, fontSize: 24, color: Colors.grey[800]),
                    )),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      shape: BoxShape.circle,
                    )),
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.lightBlueAccent, Colors.greenAccent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: _mediaWidth * 0.3 + 5,
              height: _mediaWidth * 0.3 + 5,
              child: Padding(
                padding: EdgeInsets.all(7),
                child: Container(
                    child: Center(
                        child: Text(
                      "20% \n Increase",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          height: 1.2, fontSize: 22, color: Colors.grey[800]),
                    )),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      shape: BoxShape.circle,
                    )),
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.lightBlueAccent, Colors.greenAccent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      )
    ]);
  }

  Widget pieChartW() {
    Map<String, double> dataMap = {
      "Water": 10,
      "Walk": 8,
      "Pills": 3,
      "Sleep": 2,
    };
    List<String> toDos = ["Water", "Walk", "Pills", "Sleep"];
    List<Color> clrs = [
      Colors.lightGreen,
      Colors.lightBlueAccent,
      Colors.redAccent,
      Colors.indigo
    ];
    return Column(children: [
      pc.PieChart(
        dataMap: dataMap,
        animationDuration: Duration(milliseconds: 300),
        chartRadius: 160,
        colorList: clrs,
        chartType: pc.ChartType.ring,
        ringStrokeWidth: 48,
        centerText: "Tasks",
        legendOptions: pc.LegendOptions(showLegends: false),
        chartValuesOptions: pc.ChartValuesOptions(
          showChartValueBackground: true,
          showChartValues: true,
          showChartValuesInPercentage: false,
          showChartValuesOutside: false,
        ),
      ),
      SizedBox(height: 30),
      Text(
        "Total tasks:23",
        style: TextStyle(fontSize: 25),
      ),
      for (int i = 0; i < clrs.length; i++) ...{
        SizedBox(height: 20),
        Row(children: [
          SizedBox(width: 10),
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(color: clrs[i]),
          ),
          SizedBox(width: 10),
          Text(toDos[i], style: TextStyle(fontSize: 20)),
          Spacer(),
          Text("${dataMap[toDos[i]]}", style: TextStyle(fontSize: 20)),
          SizedBox(width: 10),
        ])
      },
    ]);
  }

  @override
  build(BuildContext context) {
    _mediaHeight = MediaQuery.of(context).size.height;
    _mediaWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrangeAccent,
          title: Text('Analytics'),
          centerTitle: true,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          child: Column(children: [
            Padding(
              padding: EdgeInsets.only(top: 25),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      page += 1;
                    });
                  },
                  child: Icon(Icons.arrow_back_ios_sharp),
                ),
                SizedBox(width: 3),
                Text(
                  "Weekly Statistics",
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(width: 3),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      page += 1;
                    });
                  },
                  child: Icon(
                    Icons.arrow_forward_ios_sharp,
                  ),
                )
              ]),
            ),
            SizedBox(height: 30),
            (page % 2 == 0) ? barChart() : pieChartW()
          ]),
        ));
  }
}
