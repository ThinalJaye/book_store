import 'package:flutter/material.dart';

class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order History'),
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text('Order #${index + 1}'),
              subtitle: Text('Date: ${DateTime.now().toString().split(' ')[0]}'),
              trailing: const Text('\$XX.XX'),
              onTap: () {
                // Add order details navigation
              },
            ),
          );
        },
      ),
    );
  }
}
