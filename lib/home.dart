import 'package:flutter/material.dart';
import 'package:flutter_project_cinema/consultMovie.dart';
import 'package:flutter_project_cinema/consultProduct.dart';
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
      child: ListView(
        children: [
          movieTittle(),
          Row(
            children: [
              registrarPelicula(context),
              const SizedBox(width: 5),
              consultarPelicula(context),
            ],
          ),
          productTittle(),
          Row(
            children: [
              registrarProducto(context),
              const SizedBox(width: 5),
              consultarProducto(context),
            ],
          ),
        ],
      ),
    );
  }

  Widget movieTittle() {
    return const Text(
      "Peliculas",
      style: TextStyle(color: Colors.white, fontSize: 20),
    );
  }

  Widget registrarPelicula(BuildContext context) {
    return SizedBox(
      height: 30,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: ((context) => const NewMovie())));
        },
        style: TextButton.styleFrom(backgroundColor: Colors.lightBlue),
        child: const Text("Registrar"),
      ),
    );
  }

  Widget consultarPelicula(BuildContext context) {
    return SizedBox(
      height: 30,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: ((context) => ConsultMovie())));
        },
        style: TextButton.styleFrom(backgroundColor: Colors.amber),
        child: const Text("Consultar"),
      ),
    );
  }

  Widget productTittle() {
    return const Text(
      "Productos",
      style: TextStyle(color: Colors.white, fontSize: 20),
    );
  }

  Widget registrarProducto(BuildContext context) {
    return SizedBox(
      height: 30,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: ((context) => const NewProduct())));
        },
        style: TextButton.styleFrom(backgroundColor: Colors.lightBlue),
        child: const Text("Registrar"),
      ),
    );
  }

  Widget consultarProducto(BuildContext context) {
    return SizedBox(
      height: 30,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: ((context) => ConsultProduct())));
        },
        style: TextButton.styleFrom(backgroundColor: Colors.amber),
        child: const Text("Consultar"),
      ),
    );
  }
}
