import 'package:flutter/material.dart';

import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/products_screen.dart';
import 'screens/schedule_screen.dart';
import 'screens/admin_screen.dart';
import 'screens/product_detail_screen.dart';
import 'screens/cart_screen.dart';

class FarmaTechApp extends StatelessWidget {
  const FarmaTechApp({super.key});

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF0B8E7C);

    return MaterialApp(
      title: 'FarmaTech',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: primary),
        scaffoldBackgroundColor: const Color(0xFFF4FFFD),
      ),
      // rotas nomeadas para navegação consistente (web + mobile)
      initialRoute: '/',
      routes: {
        '/': (ctx) => const LoginScreen(),
        '/home': (ctx) => const HomeScreen(),
        '/products': (ctx) => const ProductsScreen(),
        '/schedule': (ctx) => const ScheduleScreen(),
        '/admin': (ctx) => const AdminScreen(),
        // product detail usa push com argumento (não por rota nomeada)
        '/cart': (ctx) => const CartScreen(),
      },
    );
  }
}
