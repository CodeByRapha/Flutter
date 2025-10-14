import 'package:flutter/material.dart';

void main() {
  runApp(const MeuPortfolioApp());
}

class MeuPortfolioApp extends StatelessWidget {
  const MeuPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portfólio - Raphaela Tavares',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4498E6)),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/sobre': (context) => const SobrePage(),
      },
    );
  }
}

//
// =================== TELA 1: HOME ===================
//
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        title: const Text('Meu Portfólio'),
        centerTitle: true,
        backgroundColor: const Color(0xFF63B1E6),
        foregroundColor: Colors.white, // cor do texto e ícones
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage('assets/rapha.jpeg'),
              ),
              const SizedBox(height: 20),
              const Text(
                'Raphaela Tavares',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF576FF5),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '19 anos',
                style: TextStyle(fontSize: 18, color: Colors.black54),
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                icon: const Icon(Icons.person),
                label: const Text('Sobre Mim'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 76, 131, 235),
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/sobre');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//
// =================== TELA 2: SOBRE ===================
//
class SobrePage extends StatelessWidget {
  const SobrePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        title: const Text('Sobre Mim'),
        centerTitle: true,
        backgroundColor: const Color(0xFF63B1E6),
        foregroundColor: Colors.white, // cor do texto e ícones
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Sobre Raphaela Tavares',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Color(0xFF272727),
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Sou uma estudante de tecnologia apaixonada por desenvolvimento mobile. '
              'Gosto de aprender novas linguagens, criar interfaces bonitas e funcionais, '
              'e estou sempre buscando evoluir como desenvolvedora.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),

            // ======== Cards das ferramentas =========
            const Text(
              'Minhas Habilidades',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF272727),
              ),
            ),
            const SizedBox(height: 20),

            SkillCard(
              titulo: 'Front-end',
              icones: [
                'assets/html.png',
                'assets/css.png',
                'assets/js.png',
              ],
            ),
            const SizedBox(height: 20),

            SkillCard(
              titulo: 'Back-end',
              icones: [
                'assets/java.png',
                'assets/python.png',
                'assets/c++.png',
                'assets/csharp.png',
              ],
            ),
            const SizedBox(height: 20),

            SkillCard(
              titulo: 'Prototyping',
              icones: [
                'assets/figma.png',
                'assets/canva.png',
                'assets/krita.png',
              ],
            ),

            const SizedBox(height: 40),
            Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.home),
                label: const Text('Voltar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4C83EB),
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//
// =================== COMPONENTE: CARD DE SKILLS ===================
//
class SkillCard extends StatefulWidget {
  final String titulo;
  final List<String> icones;

  const SkillCard({super.key, required this.titulo, required this.icones});

  @override
  State<SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<SkillCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _scaleAnimation =
        Tween<double>(begin: 1.0, end: 1.05).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) => _controller.reverse(),
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 4,
          shadowColor: const Color(0xFF4C83EB).withValues(alpha: 0.4),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.titulo,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4C83EB),
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: widget.icones
                      .map((iconPath) => Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Image.asset(
                              iconPath,
                              height: 40,
                              width: 40,
                            ),
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
