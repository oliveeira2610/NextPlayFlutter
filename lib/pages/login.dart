import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:projeto_nextplay/pages/loadingpage.dart';
import 'package:projeto_nextplay/pages/cadastro.dart';
import 'package:projeto_nextplay/pages/home.dart';

void main() {
  runApp(NextPlayApp());
}

class NextPlayApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Login(),
      debugShowCheckedModeBanner: false, // Remover a faixa de debug
    );
  }
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  bool _showPassword = false;
  bool _rememberMe = false;
  String? _email;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserEmail();
  }

  // Função para carregar o e-mail salvo
  void _loadUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _rememberMe = prefs.getBool('remember_me') ?? false;
      if (_rememberMe) {
        _email = prefs.getString('user_email');
        _emailController.text = _email ?? '';
      }
    });
  }

  // Função para salvar o e-mail e o estado de lembrar-me
  void _saveUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('remember_me', _rememberMe);
    if (_rememberMe) {
      prefs.setString('user_email', _emailController.text);
    } else {
      prefs.remove('user_email');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color.fromARGB(255, 44, 138, 226),
                const Color.fromARGB(255, 6, 71, 114),
              ],
              stops: [0.0, 1.0],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        child: Center(
        
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 50), // Para ajustar o conteúdo mais para cima
                  // Ícone de controle
                  Image.asset("assets/logo.png"),
                  SizedBox(height: 10),
                  // Formulário de login
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(40, 255, 255, 255), // Fundo mais claro
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white, width: 4),
                    ),
                    child: Center(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            // Título "Login"
                            Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 20),
                            // Campo de e-mail
                            TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                labelText: 'E-Mail',
                                labelStyle: TextStyle(color: Colors.white),
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.2),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.white, width: 2), // Borda branca
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.white, width: 2), // Borda branca quando habilitado
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.white, width: 2), // Borda branca quando em foco
                                  ),
                              ),
                              validator: (String? email) {
                                if (email == null || email.isEmpty) {
                                  return "O e-mail não pode ser vazio";
                                }
                                if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(email)) {
                                  return "Informe um e-mail válido";
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),
                            // Campo de senha
                            TextFormField(
                              controller: _passwordController,
                              obscureText: !_showPassword,
                              decoration: InputDecoration(
                                labelText: 'Senha',
                                labelStyle: TextStyle(color: Colors.white),
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.2),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.white, width: 2), // Borda branca
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.white, width: 2), // Borda branca quando habilitado
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.white, width: 2), // Borda branca quando em foco
                                  ),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _showPassword = !_showPassword;
                                    });
                                  },
                                  child: Icon(
                                    _showPassword ? Icons.visibility : Icons.visibility_off,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              validator: (String? password) {
                                if (password == null || password.isEmpty) {
                                  return "A senha não pode ser vazia";
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 10),
                            // Opções de lembrar-me e esquecer senha
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                      value: _rememberMe,
                                      onChanged: (value) {
                                        setState(() {
                                          _rememberMe = value ?? false;
                                        });
                                      },
                                      activeColor: Colors.white,
                                    ),
                                    Text(
                                      'LEMBRAR',
                                      style: TextStyle(fontSize: 10, color: Colors.white),
                                    ),
                                  ],
                                ),
                                TextButton(
                                  onPressed: () {
                                    // Função de esqueci minha senha
                                  },
                                  child: Text(
                                    'ESQUECI MINHA SENHA',
                                    style: TextStyle(fontSize: 10, color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            // Botão de login
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _saveUserEmail(); // Salva o e-mail se "lembrar-me" for marcado
                                  buttonEnterClick();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 5,
                              ),
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            // Opção de registro
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Cadastro()));
                              },
                              child: const Text(
                                "Não tem uma conta? Registre-se",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Ícones das redes sociais
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Ícone do Google
                      GestureDetector(
                        onTap: () {},
                        child: CircleAvatar(
                          backgroundImage: AssetImage('assets/google_icon.png'),
                          backgroundColor: Colors.transparent,
                          radius: 20,
                        ),
                      ),
                      SizedBox(width: 20),
                      // Ícone do Instagram
                      GestureDetector(
                        onTap: () {},
                        child: CircleAvatar(
                          backgroundImage: AssetImage('assets/instagram_icon.png'),
                          backgroundColor: Colors.transparent,
                          radius: 20,
                        ),
                      ),
                      SizedBox(width: 20),
                      // Ícone do Facebook
                      GestureDetector(
                        onTap: () {},
                        child: CircleAvatar(
                          backgroundImage: AssetImage('assets/facebook_icon.png'),
                          backgroundColor: Colors.transparent,
                          radius: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void buttonEnterClick() {
    // Navega para a tela Home usando pushReplacement
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Home()),
    );
  }
}
