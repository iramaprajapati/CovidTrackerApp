import 'package:flutter/material.dart';
import 'package:flutter_covid_tracker_app/Services/states_services.dart';
import 'package:flutter_covid_tracker_app/View/details_page.dart';
import 'package:shimmer/shimmer.dart';

class CountriesListPage extends StatefulWidget {
  const CountriesListPage({Key? key}) : super(key: key);

  @override
  State<CountriesListPage> createState() => _CountriesListPageState();
}

class _CountriesListPageState extends State<CountriesListPage> {
  TextEditingController searchController = TextEditingController();
  StatesServices statesServices = StatesServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: searchController,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  hintText: "Search with Country Name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0))),
            ),
          ),
          Expanded(
              child: FutureBuilder(
            future: statesServices.countriesListApi(),
            builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    String countryName = snapshot.data![index]["country"];
                    if (searchController.text.isEmpty) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailsPage(
                                    countryName: snapshot.data![index]
                                        ["country"],
                                    flagImage: snapshot.data![index]
                                        ["countryInfo"]["flag"],
                                    totalCases: snapshot.data![index]["cases"],
                                    totalRecovered: snapshot.data![index]
                                        ["recovered"],
                                    totalDeaths: snapshot.data![index]
                                        ["deaths"],
                                    totalCritical: snapshot.data![index]
                                        ["critical"],
                                    totalActive: snapshot.data![index]
                                        ["active"],
                                    todayCases: snapshot.data![index]
                                        ["todayCases"],
                                    todayRecovered: snapshot.data![index]
                                        ["todayRecovered"],
                                    todayDeaths: snapshot.data![index]
                                        ["todayDeaths"],
                                  ),
                                ),
                              );
                            },
                            child: ListTile(
                              title: Text(snapshot.data![index]["country"]),
                              subtitle: Text(
                                  "Total Covid Cases : ${snapshot.data![index]["cases"].toString()}"),
                              leading: Image(
                                height: 50,
                                width: 50,
                                image: NetworkImage(
                                  snapshot.data![index]["countryInfo"]["flag"],
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                    } else if (countryName
                        .toLowerCase()
                        .contains(searchController.text.toLowerCase())) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailsPage(
                                    countryName: snapshot.data![index]
                                        ["country"],
                                    flagImage: snapshot.data![index]
                                        ["countryInfo"]["flag"],
                                    totalCases: snapshot.data![index]["cases"],
                                    totalRecovered: snapshot.data![index]
                                        ["recovered"],
                                    totalDeaths: snapshot.data![index]
                                        ["deaths"],
                                    totalCritical: snapshot.data![index]
                                        ["critical"],
                                    totalActive: snapshot.data![index]
                                        ["active"],
                                    todayCases: snapshot.data![index]
                                        ["todayCases"],
                                    todayRecovered: snapshot.data![index]
                                        ["todayRecovered"],
                                    todayDeaths: snapshot.data![index]
                                        ["todayDeaths"],
                                  ),
                                ),
                              );
                            },
                            child: ListTile(
                              title: Text(snapshot.data![index]["country"]),
                              subtitle: Text(
                                  "Total Covid Cases : ${snapshot.data![index]["cases"].toString()}"),
                              leading: Image(
                                height: 50,
                                width: 50,
                                image: NetworkImage(
                                  snapshot.data![index]["countryInfo"]["flag"],
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                    } else {
                      return Container();
                    }
                  },
                );
              } else {
                return ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey.shade700,
                      highlightColor: Colors.grey.shade100,
                      child: Column(
                        children: [
                          ListTile(
                            title: Container(
                                height: 10, width: 80, color: Colors.white),
                            subtitle: Container(
                                height: 10, width: 80, color: Colors.white),
                            leading: Container(
                                height: 50, width: 50, color: Colors.white),
                          )
                        ],
                      ),
                    );
                  },
                );
              }
            },
          ))
        ],
      )),
    );
  }
}
