import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:thor_coffee_donut/providers/food_drink_provider.dart';

class Coffee extends StatelessWidget {
  const Coffee({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder<List<Map<String, dynamic>>>(
      future:
          Provider.of<FoodDrinkProvider>(context, listen: false).fetchDrinks(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!.isEmpty) {
          return Text("no");
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 200,
              // crossAxisSpacing: 10.0,
              // mainAxisSpacing: 10.0,
            ),
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                // height: 400,
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  // color: Colors.amberAccent,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    // color: Colors.blue,
                    width: 1,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(snapshot.data![index]['drink_name']),
                    Text(snapshot.data![index]['item'].toString()),
                    Text(snapshot.data![index]['type']),
                    TextButton(
                      onPressed: () =>
                          Provider.of<FoodDrinkProvider>(context, listen: false)
                              .addItem(
                        snapshot.data![index]['drink_name'].toString(),
                        double.parse(snapshot.data![index]['price'].toString()),
                      ),
                      child: Text("Add to Cart"),
                    )
                  ],
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
