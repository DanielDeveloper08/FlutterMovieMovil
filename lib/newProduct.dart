import 'package:flutter/material.dart';
import 'package:flutter_project_cinema/home.dart';

class NewProduct extends StatelessWidget {
  const NewProduct({super.key});

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
        newProducto(),
        imagen(context),
        nombreProducto(),
        descripcionProducto(),
        precioProducto(),
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

  Widget newProducto() {
    return const Padding(
      padding: EdgeInsets.only(top: 15, bottom: 15),
      child: Text(
        "Nuevos Productos",
        style: TextStyle(color: Colors.black54, fontSize: 25),
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
          'https://cdn-icons-png.flaticon.com/512/4221/4221407.png'),
    );
  }

  Widget nombreProducto() {
    return TextFormField(
        decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            labelText: 'Nombre del producto',
            fillColor: Colors.white70));
  }

  Widget descripcionProducto() {
    return TextFormField(
      decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Descripcion',
          fillColor: Colors.blue),
    );
  }

  Widget precioProducto() {
    return TextFormField(
      decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Precio',
          fillColor: Colors.blue),
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
