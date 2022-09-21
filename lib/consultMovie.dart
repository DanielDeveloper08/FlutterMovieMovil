import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ConsultMovie extends StatelessWidget {
  const ConsultMovie({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "PROJECT CINEMA",
          textAlign: TextAlign.center,
        ),
      ),
      body: bodyWidget(context),
    );
  }

  Widget bodyWidget(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
              "https://media.admagazine.com/photos/618a65f958ac69e38abb60ba/3:4/w_1125,h_1500,c_limit/73368.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: ListView(
        children: [
          consultMovie(),
          _item(
              "La Monja",
              'https://www.cartelera.com.uy/imagenes_espectaculos/moviedetail13/24881.jpg',
              "Terror",
              "PG +18",
              "Cuando una joven monja en una abadía de clausura en Rumania se quita la vida, el Vaticano envía a un sacerdote con un pasado atormentado."),
          const SizedBox(height: 20),
          _item(
              "La Huerfana",
              'https://www.supercines.com/MovieImages/20220901Mov001/xxhdpi.jpg',
              "Terror",
              "PG +18",
              "EL ORIGEN narra la historia de Leena Klammer, quien orquesta un escape brillante de un manicomio Ruso y viaja a Estados Unidos."),
          const SizedBox(height: 20),
          _item(
              "Spider-man: Sin Camino a Casa",
              'https://www.supercines.com/MovieImages/20211126Mov001/xxhdpi.jpg',
              "Ciencia Ficcion",
              "PG",
              "Por primera vez en la historia cinematográfica de Spider-Man, nuestro héroe, vecino y amigo es desenmascarado."),
          const SizedBox(height: 20),
          _item(
              "Mi Dulce Monstruo",
              'https://www.supercines.com/MovieImages/20220818Mov002/xxhdpi.jpg',
              "Animacion",
              "PG",
              "La princesa Bárbara está secretamente enamorada del príncipe Edward. Cuando el astuto empleado de correos Joyce pide al rey que lo case con Bárbara, ella huye."),
        ],
      ),
    );
  }

  Widget consultMovie() {
    return const Padding(
      padding: EdgeInsets.only(top: 15, bottom: 15),
      child: Text(
        "Peliculas En Cartelera",
        style: TextStyle(color: Colors.white70, fontSize: 25),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _item(String nombre, String imageName, String genero, String edades,
      String sinopsis) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.red),
          left: BorderSide(color: Colors.red),
          right: BorderSide(color: Colors.red),
          bottom: BorderSide(color: Colors.red),
        ),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.redAccent,
            blurRadius: 4,
            offset: Offset(4, 8), // Shadow position
          ),
        ],
        color: Colors.black,
      ),
      child: IntrinsicHeight(
          child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  nombre,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white70),
                ),
                Text(
                  genero,
                  style: const TextStyle(color: Colors.white70),
                ),
                Text(
                  edades,
                  style: const TextStyle(color: Colors.white70),
                ),
                Text(
                  sinopsis,
                  style: const TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 100.0,
            height: 150.0,
            child: Image(
              image: NetworkImage(imageName),
              fit: BoxFit.cover,
            ),
          )
        ],
      )),
    );
  }
}
