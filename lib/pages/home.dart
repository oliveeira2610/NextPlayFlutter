import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(Home());
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '',
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Função simples para abrir o link
  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Não foi possível abrir $url';
    }
  }

  // Função para exibir a tela baseada no índice selecionado
  Widget _buildPage(int index) {
    return ListView(
      padding: const EdgeInsets.all(8.0),
      children: [
        buildYouTubeCard(
          context,
          'TSUNAMI AUTOMÁTICO - Minecraft Em busca da casa automática #308',
          'assets/farmDeAgua.png',
          'Viniccius13',
          '3,7 mi de visualizações',
          'https://www.youtube.com/watch?v=abc123',
        ),
        buildYouTubeCard(
          context,
          'Construímos um ESTÁDIO DE FUTEBOL no Minecraft - Em busca da casa automática #345',
          'assets/futebolAuto.png',
          'Viniccius13',
          '1.9 mi de visualizações',
          'https://www.youtube.com/watch?v=def456',
        ),
        buildYouTubeCard(
          context,
          'Farm de Madeira 100% Automática - Minecraft Em busca da casa automática #342',
          'https://i.imgur.com/407k9rD.jpg',
          'Viniccius13',
          '3,8 mi de visualizações',
          'https://www.youtube.com/watch?v=ghi789',
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu, size: 30),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        actions: [
          _buildInstagramStoryIcon('https://i.imgur.com/407k9rD.jpg'),
          _buildInstagramStoryIcon('https://i.imgur.com/V3p9L2w.png'),
          _buildInstagramStoryIcon('https://i.imgur.com/V3p9L2w.png'),
          _buildInstagramStoryIcon(null, icon: Icons.flight_takeoff),
          _buildInstagramStoryIcon(null, icon: Icons.flight_takeoff, backgroundColor: Colors.black),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            AppBar(
              backgroundColor: const Color.fromARGB(0, 0, 0, 0),
              elevation: 0,
              leading: IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Spacer(),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Conta'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.video_library),
              title: Text('Categorias'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Configurações'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
        selectedItemColor: Colors.lightBlue,
        unselectedItemColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
        ],
      ),
      body: _buildPage(_selectedIndex),
    );
  }

  Widget buildYouTubeCard(BuildContext context, String title, String imageUrl,
      String channelName, String videoInfo, String videoLink) {
    return Card(
      color: Colors.grey[900],
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Ink.image(
            image: NetworkImage(imageUrl),
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
            child: InkWell(
              onTap: () => _launchURL(videoLink),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage('https://placekitten.com/100/100'),
                  radius: 20,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '$channelName • $videoInfo',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.more_vert, color: Colors.white),
                  onPressed: () {
                    debugPrint('Opções clicadas');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstagramStoryIcon(String? imageUrl, {IconData? icon, Color iconColor = Colors.white, Color backgroundColor = Colors.lightBlue}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Container(
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [Colors.pink, Colors.orange, Colors.yellow],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: CircleAvatar(
          backgroundColor: backgroundColor,
          radius: 22,
          child: imageUrl != null
              ? CircleAvatar(
                  backgroundImage: NetworkImage(imageUrl),
                  radius: 20,
                )
              : Icon(icon, size: 24, color: iconColor),
        ),
      ),
    );
  }
}
