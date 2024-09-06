import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:weather/widgets/custom_app_bar.dart';

dynamic selectedCity = 'Delhi';

class Cities extends StatefulWidget {
  const Cities({super.key});

  @override
  State<Cities> createState() => _CitiesState();
}

class _CitiesState extends State<Cities> {
  List cities = [];

  final searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readJson();
  }

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/city_list.json');
    final data = json.decode(response);
    setState(() {
      cities = data["cities"];
      print(cities.length);
      print(cities);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: const Text("Cities"),
        useCustomIcon: false,
        isCenter: false,
        onClick: () {},
        imagePath: '',
        icon: Icons.public,
        onThemeButtonClicked: () {},
        showRefreshIndicator: false,
        showGlobeIcon: false,
      ),
      body: Column(
        children: [
          cities.isNotEmpty
              ? Expanded(
                  child: ListView.builder(
                    itemCount: cities.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: GestureDetector(
                          onTap: () {
                            selectedCity = cities[index]['name'];
                            print(selectedCity);
                            Navigator.pop(context, "refresh");
                          },
                          child: ListTile(
                            hoverColor: Colors.red,
                            subtitle: Text(
                              cities[index]['state'],
                            ),
                            title: Text(
                              cities[index]['name'],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              : const CircularProgressIndicator(),
        ],
      ),
    );
  }
}
