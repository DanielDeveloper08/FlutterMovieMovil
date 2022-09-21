import 'package:flutter/material.dart';
import 'package:flutter_project_cinema/home.dart';

const List<String> list = <String>[
  'Seleccione el genero ',
  'Terror',
  'Comedia',
  'Documental',
  'Accion',
  'Drama',
  'Romantica'
];

class NewMovie extends StatelessWidget {
  const NewMovie({super.key});

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
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
      /*decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
              "https://media.admagazine.com/photos/618a65f958ac69e38abb60ba/3:4/w_1125,h_1500,c_limit/73368.jpg"),
          fit: BoxFit.cover,
        ),
      ),*/
      child: ListView(children: [
        newMovie(),
        imagen(context),
        titulo(),
        clasificacion(),
        genero(),
        sinopsis(),
        Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                botonGuardar(),
                const SizedBox(
                  width: 15,
                ),
                botonCancelar(context),
              ],
            )),
      ]),
    );
  }

  Widget newMovie() {
    return const Padding(
      padding: EdgeInsets.only(top: 15, bottom: 15),
      child: Text(
        "Nueva Pelicula",
        style: TextStyle(color: Colors.white70, fontSize: 25),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget imagen(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: double.infinity,
      height: (screenWidth - 80.0) * 2.0 / 4.0,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
      child: Image.network(
          'https://cdn-icons-png.flaticon.com/512/2503/2503529.png'),
    );
  }

  Widget titulo() {
    return TextFormField(
        decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            labelText: 'Titulo',
            fillColor: Colors.white70));
  }

  Widget clasificacion() {
    return TextFormField(
      decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Clasificacion',
          fillColor: Colors.blue),
    );
  }

  Widget genero() {
    String dropdownValue = list.first;
    return DropdownButton<String>(
      value: dropdownValue,
      elevation: 16,
      style: const TextStyle(color: Colors.blueGrey),
      underline: Container(
        height: 2,
        color: Colors.blueGrey,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        /* setState(() {
          dropdownValue = value!;
        });*/
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget sinopsis() {
    return TextFormField(
      decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Sinopsis',
          fillColor: Colors.blue),
      minLines:
          3, // any number you need (It works as the rows for the textarea)
      keyboardType: TextInputType.multiline,
      maxLines: null,
    );
  }

  Widget botonGuardar() {
    return SizedBox(
      width: 100,
      height: 30,
      child: ElevatedButton(
        onPressed: () {},
        style: TextButton.styleFrom(backgroundColor: Colors.amber),
        child: const Text("Guardar"),
      ),
    );
  }

  Widget botonCancelar(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 30,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: ((context) => const Home())));
        },
        style: TextButton.styleFrom(backgroundColor: Colors.red),
        child: const Text("Cancelar"),
      ),
    );
  }
}
