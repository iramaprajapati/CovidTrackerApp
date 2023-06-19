import 'package:flutter/material.dart';
import 'package:flutter_covid_tracker_app/View/world_states.dart';

class DetailsPage extends StatefulWidget {
 final String countryName, flagImage;
 final int totalCases,
      totalDeaths,
      totalRecovered,
      todayCases,
      todayRecovered,
      todayDeaths,
      totalActive,
      totalCritical;

   DetailsPage({
    Key? key,
    required this.countryName,
    required this.flagImage,
    required this.totalCases,
    required this.totalRecovered,
    required this.totalDeaths,
    required this.totalCritical,
    required this.totalActive,
    required this.todayCases,
    required this.todayRecovered,
    required this.todayDeaths,
  }) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.countryName),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.067),
                    child: Card(
                      child: Column(
                        children: [
                          SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                          ReusableRow(
                              title: "Total Cases:",
                              value: widget.totalCases.toString()),
                          ReusableRow(
                              title: "Total Recovered :",
                              value: widget.totalRecovered.toString()),
                          ReusableRow(
                              title: "Total Deaths :",
                              value: widget.totalDeaths.toString()),
                          ReusableRow(
                              title: "Today Cases :",
                              value: widget.todayCases.toString()),
                          ReusableRow(
                              title: "Today Recovered :",
                              value:
                              widget.todayRecovered.toString()),
                          ReusableRow(
                              title: "Today Deaths :",
                              value: widget.todayDeaths.toString()),
                          ReusableRow(
                              title: "Total Active :",
                              value: widget.totalActive.toString()),
                          ReusableRow(
                              title: "Total Critical :",
                              value: widget.totalCritical.toString()),
                        ],
                      ),
                    ),
                  ),
                  CircleAvatar(radius: 50,
                  backgroundImage: NetworkImage(widget.flagImage)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
