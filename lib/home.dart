import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_cinema/consultMovie.dart';
import 'package:flutter_project_cinema/consultProduct.dart';
import 'package:flutter_project_cinema/main.dart';
import 'package:flutter_project_cinema/newMovie.dart';
import 'package:flutter_project_cinema/newProduct.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HOME')),
      body: bodyWidget(context),
    );
  }

  Widget bodyWidget(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  "https://media.admagazine.com/photos/618a65f958ac69e38abb60ba/3:4/w_1125,h_1500,c_limit/73368.jpg"),
              fit: BoxFit.cover)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          titulo("<<< Peliculas >>>"),
          const SizedBox(width: 5),
          imagenPelicula(context),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              registrarPelicula(context),
              const SizedBox(width: 10),
              consultarPelicula(context),
            ],
          ),
          const SizedBox(height: 60),
          titulo("<<< Productos >>>"),
          imagenProducto(context),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              registrarProducto(context),
              const SizedBox(width: 10),
              consultarProducto(context),
            ],
          ),
          const SizedBox(height: 60),
          cerrarSesion(context)
        ],
      ),
    );
  }

  Widget imagenProducto(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: double.infinity,
      height: (screenWidth - 80.0) * 2.0 / 4.0,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
      child: Image.network(
          'https://cdn-icons-png.flaticon.com/512/4221/4221407.png'),
    );
  }

  Widget imagenPelicula(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: double.infinity,
      height: (screenWidth - 80.0) * 2.0 / 4.0,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
      child: Image.network(
          'https://cdn-icons-png.flaticon.com/512/2503/2503529.png'),
    );
  }

  Widget registrarPelicula(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 150,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: ((context) => const NewMovie())));
        },
        style: TextButton.styleFrom(backgroundColor: Colors.lightBlue),
        child: const Text(
          "Registrar",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  Widget consultarPelicula(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 150,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: ((context) => ConsultMovie())));
        },
        style: TextButton.styleFrom(backgroundColor: Colors.amber),
        child: const Text(
          "Consultar",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  Widget titulo(String titulo) {
    return Text(
      titulo,
      style: const TextStyle(
          color: Colors.black,
          fontSize: 25,
          fontWeight: FontWeight.bold,
          backgroundColor: Colors.white),
    );
  }

  Widget registrarProducto(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 150,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: ((context) => const NewProduct())));
        },
        style: TextButton.styleFrom(backgroundColor: Colors.lightBlue),
        child: const Text(
          "Registrar",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Widget consultarProducto(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 150,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: ((context) => ConsultProduct())));
        },
        style: TextButton.styleFrom(backgroundColor: Colors.amber),
        child: const Text(
          "Consultar",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  Widget cerrarSesion(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 250,
      child: ElevatedButton(
        onPressed: () {
          FirebaseAuth.instance.signOut().then((value) => Navigator.push(
              context,
              MaterialPageRoute(builder: ((context) => const MyApp()))));
        },
        style: TextButton.styleFrom(backgroundColor: Colors.redAccent),
        child: const Text(
          "Cerrar Sesion",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
