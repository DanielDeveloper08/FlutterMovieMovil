import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_cinema/home.dart';
import 'package:flutter_project_cinema/reset_password.dart';
import 'package:flutter_project_cinema/signup_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(title: 'Project Cinema',restorationId:'main'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, this.restorationId});
  final String? restorationId;
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();

  /*FirebaseAuth auth = FirebaseAuth.instance;
  String email = '', contrasena = '';*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          textAlign: TextAlign.center,
        ),
      ),
      body: cuerpo(),
    );
  }

  Widget cuerpo() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  "https://media.admagazine.com/photos/618a65f958ac69e38abb60ba/3:4/w_1125,h_1500,c_limit/73368.jpg"),
              fit: BoxFit.cover)),
      child: Center(
        child: ListView(
          children: [
            const SizedBox(height: 20),
            nombre(),
            const SizedBox(height: 20),
            imagen(),
            const SizedBox(height: 20),
            campoUsuario(),
            const SizedBox(height: 10),
            campoPassword(),
            const SizedBox(height: 30),
            botonIniciarSesion(),
            const SizedBox(height: 10),
            /*recuperarContrasena()*/ forgetPassword(),
            const SizedBox(height: 90),
            botonRegistrarse()
          ],
        ),
      ),
    );
  }

  Widget imagen() {
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: double.infinity,
      height: (screenWidth - 80.0) * 2.0 / 4.0,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
      child: Image.network(
          'https://cdn-icons-png.flaticon.com/512/2809/2809590.png'),
    );
  }

  Widget nombre() {
    return const Text(
      "Sign in",
      style: TextStyle(
          color: Colors.white, fontSize: 35.0, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    );
  }

  Widget campoUsuario() {
    return reusableTextField(
        "Enter UserName", Icons.person_outline, false, _emailTextController);
  }

  Widget campoPassword() {
    return reusableTextField(
        "Enter Password", Icons.lock_outline, true, _passwordTextController);
  }

  Widget botonIniciarSesion() {
    return SizedBox(
      height: 40,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: ((context) => const Home())));
        },
        style: TextButton.styleFrom(backgroundColor: Colors.red),
        child: const Text("Iniciar Sesion"),
      ),
    );
  }

  Widget recuperarContrasena() {
    return const Text(
      "¿Olvidaste tu contraseña?",
      style: TextStyle(
          color: Colors.white, fontSize: 12.0, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    );
  }

  Widget botonRegistrarse() {
    return SizedBox(
      height: 40,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: ((context) => const SignUpScreen())));
        },
        style: TextButton.styleFrom(backgroundColor: Colors.yellow),
        child: const Text(
          "Registrarse",
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  TextField reusableTextField(String text, IconData icon, bool isPasswordType,
      TextEditingController controller) {
    return TextField(
      controller: controller,
      obscureText: isPasswordType,
      enableSuggestions: !isPasswordType,
      autocorrect: !isPasswordType,
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.black87.withOpacity(0.9)),
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: Colors.black87,
        ),
        labelText: text,
        labelStyle: TextStyle(color: Colors.black45.withOpacity(0.9)),
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: Colors.white.withOpacity(0.8),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
      ),
      keyboardType: isPasswordType
          ? TextInputType.visiblePassword
          : TextInputType.emailAddress,
    );
  }

  Widget forgetPassword() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 35,
      alignment: Alignment.bottomRight,
      child: TextButton(
        child: const Text(
          "Forgot Password?",
          style: TextStyle(color: Colors.white70),
          textAlign: TextAlign.right,
        ),
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ResetPassword())),
      ),
    );
  }
}
