import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mystore/cart_view.dart';
import 'package:mystore/product_view.dart';
import 'package:mystore/repository/product_repository.dart';
import 'package:mystore/state/cart_cubit.dart';
import 'package:mystore/state/product_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Store',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: RepositoryProvider<ProductRepository>(
        create: (context) => ProductRepository(),
        child: MultiBlocProvider(
          providers: [
            BlocProvider<ProductStateCubit>(
            create: (BuildContext context) => ProductStateCubit(productRepository: ProductRepository()),
            ),
            BlocProvider<CartStateCubit>(
            create: (BuildContext context) => CartStateCubit(),
            ),
          ],
          child: const MyHomePage(),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Widget> _pages = [ProductView(), CartView()];
  int _selectedTab = 1;


  void _changeTab(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Store'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        onTap: (index) => _changeTab(index),
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: "Cart"),
        ],
      ),
      body: _pages[_selectedTab],
    );
  }
}
