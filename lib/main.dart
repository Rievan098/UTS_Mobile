import 'package:flutter/material.dart';
import 'transaksi.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Warnet App',
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/transaksi': (context) => TransaksiPage(),
        '/about': (context) => AboutUsPage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      drawer: Drawer(
        child: Container(
          color: Colors.blueAccent, 
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue, 
                ),
                child: Text(
                  'Menu Drawer',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.computer, color: Colors.white), 
                title: Text(
                  'Transaksi Warnet',
                  style: TextStyle(color: Colors.white), 
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/transaksi');
                },
              ),
              Divider(color: Colors.white), 
              ListTile(
                leading: Icon(Icons.info, color: Colors.white), 
                title: Text(
                  'About Us',
                  style: TextStyle(color: Colors.white), 
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/about'); 
                },
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: Text('Selamat Datang di Van Warnet'),
      ),
    );
  }
}


class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
      ),
      body: Center(
        child: Text(
          'Ini adalah halaman About Us untuk aplikasi Van Warnet.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
