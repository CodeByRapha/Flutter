import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/products_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/schedule_screen.dart';
import 'providers/auth_provider.dart';

class FarmaciApp extends StatelessWidget {
  const FarmaciApp({super.key});

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF0B8E7C);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "FarmaTech",
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: primary),
        scaffoldBackgroundColor: const Color(0xFFF5FFFD),
      ),
      home: const RootNavigation(),
    );
  }
}

class RootNavigation extends StatefulWidget {
  const RootNavigation({super.key});

  @override
  State<RootNavigation> createState() => _RootNavigationState();
}

class _RootNavigationState extends State<RootNavigation> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    if (!auth.isLogged) return const LoginScreen();

    final pages = [
      const HomeScreen(),
      const ProductsScreen(),
      const CartScreen(),
      const ScheduleScreen(),
    ];

    return Scaffold(
      body: pages[pageIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: pageIndex,
        onDestinationSelected: (i) => setState(() => pageIndex = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: "Início"),
          NavigationDestination(icon: Icon(Icons.medication), label: "Produtos"),
          NavigationDestination(icon: Icon(Icons.shopping_cart), label: "Carrinho"),
          NavigationDestination(icon: Icon(Icons.schedule), label: "Agendas"),
        ],
      ),
    );
  }
}
