import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/food_drink_provider.dart';

class Donut extends StatelessWidget {
  const Donut({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future:
          Provider.of<FoodDrinkProvider>(context, listen: false).fetchDonuts(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!.isEmpty) {
          return Text("no");
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              // crossAxisSpacing: 10.0,
              // mainAxisSpacing: 10.0,
            ),
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                color: Colors.blue,
                child: Center(
                  child: Text(snapshot.data![index]['food_name']),
                ),
              );
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}
