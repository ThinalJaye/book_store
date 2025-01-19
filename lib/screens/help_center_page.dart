import 'package:flutter/material.dart';

class HelpCenterPage extends StatelessWidget {
  const HelpCenterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help Center'),
      ),
      body: ListView(
        children: const [
          ExpansionTile(
            title: Text('Frequently Asked Questions'),
            children: [
              ListTile(
                title: Text('How do I place an order?'),
                subtitle: Text('Select your books and proceed to checkout.'),
              ),
            ],
          ),
          ExpansionTile(
            title: Text('Contact Support'),
            children: [
              ListTile(
                title: Text('Email'),
                subtitle: Text('ThinalJayamanna@gmail.com'),
              ),
              ListTile(
                title: Text('Phone'),
                subtitle: Text('071-8731798'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
