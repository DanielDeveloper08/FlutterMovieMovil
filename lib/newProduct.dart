import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter_project_cinema/home.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_project_cinema/services/productService.dart';

class NewProduct extends StatefulWidget{
  const NewProduct({super.key});
  @override
  State<NewProduct> createState() => _NewProduct();
}
class _NewProduct extends State<NewProduct> {


  ProductService moviesService = ProductService();
  var product = <String, String>{
    "name": "",
    "price": "",
    "image_url": "",
    "type_id": "1",
    "description": "",
    "status": "A"
  };

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
        botonImagen(context),
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

  String? baseImage;

  Future<void> chooseImage() async {
    var choosedimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
        setState(() {
          baseImage = choosedimage!.path;
        });
          
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
      child: image()
      );
  }

  Widget image(){
    if(baseImage!=null && !baseImage!.isEmpty)
    return Image.file(File(baseImage!));
    else
    return Image.network(
          'https://cdn-icons-png.flaticon.com/512/4221/4221407.png');
  }

  Widget nombreProducto() {
    return TextFormField(
      onChanged: (value) => product['name']=value,
        decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            labelText: 'Nombre del producto',
            fillColor: Colors.white70));
  }

  Widget descripcionProducto() {
    return TextFormField(
      onChanged: (value) => product['description']=value,
      decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Descripcion',
          fillColor: Colors.blue),
    );
  }

  Widget precioProducto() {
    return TextFormField(
      onChanged: (value) => product['price']=value,
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
        onPressed: () {
          if (baseImage != null) {
            moviesService.saveMovie(baseImage!, json.encode(product).toString());
            
          }
        },
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
  Widget botonImagen(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 100),
        child: SizedBox(
          width: 50,
          height: 30,
          child: ElevatedButton(
            onPressed: () {
              chooseImage();
            },
            style: TextButton.styleFrom(backgroundColor: Colors.grey),
            child: const Text("Subir Imágen"),
          ),
        ));
  }
}
