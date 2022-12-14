import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_project_cinema/services/productService.dart';
class ConsultProduct extends StatelessWidget {
  ConsultProduct({super.key});
  ProductService moviesService=ProductService(); 

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
      child:FutureBuilder(
        future:moviesService.fetchMovies(),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          print(snapshot);
          if(snapshot.connectionState==ConnectionState.waiting){
            return const Center(child:CircularProgressIndicator());
          }
          else{
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index){
                return _item(
              snapshot.data[index].name,
              snapshot.data[index].description,
              snapshot.data[index].price,
              snapshot.data[index].imgUrl);
              },
            );
          }
        }
      ), 
      
    );
  }

  Widget consultProduct() {
    return const Padding(
      padding: EdgeInsets.only(top: 15, bottom: 15),
      child: Text(
        "Productos en bar",
        style: TextStyle(color: Colors.white70, fontSize: 25),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _item(
      String nombre, String descripcion, double precio, String imagen) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      margin:const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.black54),
          left: BorderSide(color: Colors.black54),
          right: BorderSide(color: Colors.black54),
          bottom: BorderSide(color: Colors.black54),
        ),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Color(0xffff9900),
            blurRadius: 4,
            offset: Offset(4, 8), // Shadow position
          ),
        ],
        color: Colors.white70,
      ),
      child: IntrinsicHeight(
          child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  nombre,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      fontSize: 28),
                ),
                const SizedBox(height: 30),
                Text(
                  descripcion,
                  style: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Text(
                  '\$ $precio',
                  style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 130.0,
            height: 150.0,
            child: Image(
              image: NetworkImage(imagen),
              fit: BoxFit.cover,
            ),
          )
        ],
      )),
    );
  }
}
