import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thor_coffee_donut/providers/cart_provider.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder<List<Map<String, dynamic>>>(
        stream: Provider.of<CartProvider>(context).readCart(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                    width: size.width * 1,
                    height: 120,
                    decoration: BoxDecoration(
                      // color: Colors.amberAccent,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        // color: Colors.blue,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: size.width * 0.5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image(
                                  width: 100,
                                  height: 100,
                                  image: NetworkImage(snapshot.data![index]
                                          ['image']
                                      .toString())),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshot.data![index]['name'].toString(),
                                      style: const TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(
                                      "RM${snapshot.data![index]['price']}",
                                      style: const TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontSize: 20,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () => Provider.of<CartProvider>(
                                            context,
                                            listen: false)
                                        .updateCart(
                                      "add",
                                      snapshot.data![index]['orderID'],
                                      snapshot.data![index]['count'],
                                    ),
                                icon: const Icon(Icons.add)),
                            Text(snapshot.data![index]['count'].toString()),
                            IconButton(
                                onPressed: () => Provider.of<CartProvider>(
                                            context,
                                            listen: false)
                                        .updateCart(
                                      "minus",
                                      snapshot.data![index]['orderID'],
                                      snapshot.data![index]['count'],
                                    ),
                                icon: const Icon(Icons.remove))
                          ],
                        )
                      ],
                    ),
                  );
                });
          } else if (snapshot.hasError) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return const Center(
              child: Text("No post has been made so far"),
            );
          }
        });
  }
}
