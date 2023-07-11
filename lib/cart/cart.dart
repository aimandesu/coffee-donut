import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:thor_coffee_donut/providers/cart_provider.dart';
import 'package:thor_coffee_donut/thank_you/thank_you.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> orderID = [];
    // double price = 0.0;

    void addItemToList(String item) {
      if (orderID.contains(item)) {
        orderID.remove(item);
      }

      orderID.add(item);
    }

    void show(double valueTotal, List<String> orderID) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Payment"),
              content: Text(
                "Proceed to pay? total is RM$valueTotal",
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text("cancel"),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text("proceed"),
                ),
              ],
            );
          }).then((value) {
        if (value == true) {
          Provider.of<CartProvider>(context, listen: false).pay(orderID);
          Navigator.of(context).pushNamed(
            ThankYou.routeName,
          );
        } else {
          Fluttertoast.showToast(
            msg: " payment is cancelled",
            toastLength: Toast.LENGTH_SHORT, // or Toast.LENGTH_LONG
            gravity: ToastGravity.BOTTOM, // positioning of the toast
            timeInSecForIosWeb: 1, // duration of the toast on iOS and web
            backgroundColor: Colors.black, // background color of the toast
            textColor: Colors.white, // text color of the toast
            fontSize: 16.0, // font size of the toast message
          );
        }
      });
    }

    Size size = MediaQuery.of(context).size;
    return StreamBuilder<List<Map<String, dynamic>>>(
        stream: Provider.of<CartProvider>(context).readCart(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return Column(
              children: [
                SizedBox(
                  height: size.height * 0.7,
                  child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        addItemToList(
                            snapshot.data![index]['orderID'].toString());

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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image(
                                        width: 100,
                                        height: 100,
                                        image: NetworkImage(snapshot
                                            .data![index]['image']
                                            .toString())),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            snapshot.data![index]['name']
                                                .toString(),
                                            style: const TextStyle(
                                              fontStyle: FontStyle.italic,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                          Text(
                                            "RM${snapshot.data![index]['total']}",
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
                                      onPressed: () =>
                                          Provider.of<CartProvider>(context,
                                                  listen: false)
                                              .updateCart(
                                                  "add",
                                                  snapshot.data![index]
                                                      ['orderID'],
                                                  snapshot.data![index]
                                                      ['count'],
                                                  double.parse(snapshot
                                                      .data![index]['price']
                                                      .toString()),
                                                  double.parse(snapshot
                                                      .data![index]['total']
                                                      .toString())),
                                      icon: const Icon(Icons.add)),
                                  Text(snapshot.data![index]['count']
                                      .toString()),
                                  IconButton(
                                      onPressed: () =>
                                          Provider.of<CartProvider>(context,
                                                  listen: false)
                                              .updateCart(
                                            "minus",
                                            snapshot.data![index]['orderID'],
                                            snapshot.data![index]['count'],
                                            double.parse(snapshot.data![index]
                                                    ['price']
                                                .toString()),
                                            double.parse(snapshot.data![index]
                                                    ['total']
                                                .toString()),
                                          ),
                                      icon: const Icon(Icons.remove)),
                                  IconButton(
                                      onPressed: () {
                                        Provider.of<CartProvider>(context,
                                                listen: false)
                                            .deleteOrder(snapshot.data![index]
                                                ['orderID']);
                                      },
                                      icon: Icon(Icons.delete)),
                                ],
                              )
                            ],
                          ),
                        );
                      }),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  width: size.width * 1,
                  child: ElevatedButton(
                    onPressed: () async {
                      double valueTotal = await Provider.of<CartProvider>(
                              context,
                              listen: false)
                          .fetchTotalPrice(orderID);
                      show(valueTotal, orderID);
                      // print("bruh" + valueTotal.toString());
                    },
                    child: const Text("Pay"),
                  ),
                )
              ],
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  "Cart is empty",
                  style: TextStyle(
                    fontSize: 30,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                Lottie.network(
                    "https://assets5.lottiefiles.com/packages/lf20_mwjUMw.json"),
              ],
            ));
          }
        });
  }
}
