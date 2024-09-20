import 'package:flutter/material.dart';
import 'package:projeto_nextplay/pages/Login.dart'; 


class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final _formKey = GlobalKey<FormState>();
  bool _showPassword = false;
  bool _showConfirmPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),    
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
          child: Container(
            height: 650,
            padding: const EdgeInsets.all(30),
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color.fromARGB(106, 255, 255, 255),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Form(
              key: _formKey, // Adiciona a chave do formulário
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    autofocus: true,
                    decoration: InputDecoration(
                      icon: Icon(Icons.person),
                      hintText: "Informe seu Nome",
                    ),
                    validator: (String? name) {
                      if (name == null || name.isEmpty) {
                        return "O nome não pode ser vazio";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    autofocus: true,
                    decoration: InputDecoration(
                      icon: Icon(Icons.security_sharp),
                      hintText: "Informe seu CPF",
                    ),
                    validator: (String? cpf) {
                      if (cpf == null || cpf.isEmpty) {
                        return "O CPF não pode ser vazio";
                      }
                      if (cpf.length < 11) {
                        return "O CPF deve ter 11 dígitos";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    autofocus: true,
                    decoration: InputDecoration(
                      icon: Icon(Icons.phone),
                      hintText: "Informe seu Telefone",
                    ),
                    validator: (String? number) {
                      if (number == null || number.isEmpty) {
                        return "O número não pode ser vazio";
                      }
                      if (number.length < 11) {
                        return "O número deve ter pelo menos 11 dígitos";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    autofocus: true,
                    decoration: InputDecoration(
                      icon: Icon(Icons.email),
                      hintText: "Informe seu E-mail",
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
                   SizedBox(height: 10),
                TextFormField(
                  obscureText: _showPassword == false ? true : false,
                  autofocus: true,

                  decoration: InputDecoration(
                    icon: const Icon(Icons.lock),
                    suffixIcon: GestureDetector(child: Icon(
                    _showPassword == false ? Icons.visibility_off : Icons.visibility,
                    ),
                    
                    onTap:(){
                      setState(() {
                        _showPassword = !_showPassword;
                      });

                    }),
                    hintText: "informe a Senha",
        
                  ),
                  validator: (String? password) {
                    if(password == "" || password == null){
                      return "A senha não pode ser vazia";
                    }  
                    return null;
                  },
                ),

                SizedBox(height: 10),
                TextFormField(
                  obscureText: _showConfirmPassword == false ? true : false,
                  autofocus: true,

                  decoration: InputDecoration(
                    icon: const Icon(Icons.lock),
                    suffixIcon: GestureDetector(child: Icon(
                    _showConfirmPassword == false ? Icons.visibility_off : Icons.visibility,
                    ),
                    
                    onTap:(){
                      setState(() {
                        _showConfirmPassword = !_showConfirmPassword;
                      });

                    }),
                    hintText: "Comfirme a Senha",
        
                  ),
                  validator: (String? confirmPassword) {
                    if(confirmPassword == "" || confirmPassword == null){
                      return "A senha não pode ser vazia";
                    }  
                     
                    return null;
                  },
                ),
                  SizedBox(height: 10),
                  Center(
                    child: ElevatedButton(
                      onPressed: buttonEnterClick,
                      child: Text("Cadastrar"),
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(200, 50),
                        backgroundColor: const Color.fromARGB(255, 33, 82, 243),
                        foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                    ),
                  ),
                  const Divider(),
                  GestureDetector(
                    onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                        },
                    child: const Text(
                      "Fazer Login",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  const Text("Já tem uma conta? Clique no link acima."),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void buttonEnterClick() {
    if (_formKey.currentState!.validate()) {
      print("Formulário válido");
      // Você pode continuar o processo de cadastro aqui
    } else {
      print("Erro no formulário");
    }
  }
}
