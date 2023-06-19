import 'package:flutter/material.dart';
import 'package:flutter_covid_tracker_app/Model/WorldStatesModel.dart';
import 'package:flutter_covid_tracker_app/Services/states_services.dart';
import 'package:flutter_covid_tracker_app/View/countries_list.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class WorldStatesPage extends StatefulWidget {
  const WorldStatesPage({Key? key}) : super(key: key);

  @override
  State<WorldStatesPage> createState() => _WorldStatesPageState();
}

class _WorldStatesPageState extends State<WorldStatesPage>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color>[
    Colors.blue,
    Colors.green,
    Colors.red,
  ];

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            FutureBuilder(
              future: statesServices.fetchWorldStatesRecords(),
              builder: (context, AsyncSnapshot<WorldStatesModel> snapshot) {
                if (!snapshot.hasData) {
                  return Expanded(
                    flex: 1,
                    child: SpinKitFadingCircle(
                      color: Colors.white,
                      size: 50.0,
                      controller: _controller,
                    ),
                  );
                } else {
                  return Column(
                    children: [
                      PieChart(
                        dataMap: {
                          "Total":
                              double.parse(snapshot.data!.cases.toString()),
                          "Recovered":
                              double.parse(snapshot.data!.recovered.toString()),
                          "Deaths":
                              double.parse(snapshot.data!.deaths.toString()),
                        },
                        chartValuesOptions: const ChartValuesOptions(
                            showChartValuesInPercentage: true),
                        animationDuration: const Duration(seconds: 2),
                        chartType: ChartType.ring,
                        colorList: colorList,
                        chartRadius: MediaQuery.of(context).size.width / 3.2,
                        legendOptions: const LegendOptions(
                            legendPosition: LegendPosition.left),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                          //MediaQuery.of(context).size.height * 0.06
                        ),
                        child: SingleChildScrollView(
                          child: Card(
                            child: Column(
                              children: [
                                ReusableRow(
                                    title: "Total Cases:",
                                    value: snapshot.data!.cases.toString()),
                                ReusableRow(
                                    title: "Total Recovered :",
                                    value: snapshot.data!.recovered.toString()),
                                ReusableRow(
                                    title: "Total Deaths :",
                                    value: snapshot.data!.deaths.toString()),
                                ReusableRow(
                                    title: "Today Cases :",
                                    value:
                                        snapshot.data!.todayCases.toString()),
                                ReusableRow(
                                    title: "Today Recovered :",
                                    value: snapshot.data!.todayRecovered
                                        .toString()),
                                ReusableRow(
                                    title: "Today Deaths :",
                                    value:
                                        snapshot.data!.todayDeaths.toString()),
                                ReusableRow(
                                    title: "Total Active :",
                                    value: snapshot.data!.active.toString()),
                                ReusableRow(
                                    title: "Total Critical :",
                                    value: snapshot.data!.critical.toString()),
                              ],
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CountriesListPage(),
                              ));
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.pink[300],
                              borderRadius: BorderRadius.circular(10)),
                          child: const Center(
                            child: Text("Track Countries",
                                style: TextStyle(fontWeight: FontWeight.bold),
                                textScaleFactor: 1.5),
                          ),
                        ),
                      )
                    ],
                  );
                }
              },
            ),
          ],
        ),
      )),
    );
  }
}

class ReusableRow extends StatelessWidget {
  String title, value;

  ReusableRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(title), Text(value)],
          ),
          const SizedBox(
            height: 2,
          ),
          const Divider(),
        ],
      ),
    );
  }
}
