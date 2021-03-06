import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart' show Cart;
import './cart_item.dart';
import '../providers/orders.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {},
              child: Text(
                "Your ",
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
            Text(
              "Cart",
              style: TextStyle(
                fontSize: 30,
                color: Colors.teal,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Basic',
                    ),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      '₹ ${cart.totalAmount}',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    backgroundColor: Theme.of(context).accentColor,
                  ),
                  FlatButton(
                    onPressed: () {
                      Provider.of<Orders>(
                        context,
                        listen: false,
                      ).addOrder(
                        cart.items.values.toList(),
                        cart.totalAmount,
                      );
                      cart.clear();
                    },
                    // color: Colors.white,
                    child: Text(
                      'Order Now',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          //adding products below the 'total' bar:
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cart.itemCount,
              itemBuilder: (ctx, index) => CartItem(
                cart.items.values.toList()[index].id,
                cart.items.values.toList()[index].price,
                cart.items.values.toList()[index].quantity,
                cart.items.values.toList()[index].title,
                cart.items.keys.toList()[index],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
