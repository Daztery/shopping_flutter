import 'package:flutter/material.dart';

class PurchasesContent extends StatelessWidget {
  const PurchasesContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Text(
            "Total: S/ 1000.00",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          ListView(
            children: <Widget>[
              Container(
                height: 50,
                color: Colors.amber[600],
                child: const Center(child: Text('Entry A')),
              ),
              Container(
                height: 50,
                color: Colors.amber[500],
                child: const Center(child: Text('Entry B')),
              ),
              Container(
                height: 50,
                color: Colors.amber[100],
                child: const Center(child: Text('Entry C')),
              ),
            ],
          ),
          TextFormField(
            decoration: InputDecoration(
              icon: Icon(Icons.person),
              hintText: 'Nombre',
              labelText: 'Nombre*',
            ),
          )
        ],
      ),
    );
  }
}
