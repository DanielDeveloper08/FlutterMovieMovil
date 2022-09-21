import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_project_cinema/services/moviesService.dart';

class ConsultMovie extends StatelessWidget {
  ConsultMovie({super.key});
  MoviesService moviesService=MoviesService(); 

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
              snapshot.data[index].title,
              snapshot.data[index].imgUrl,
              snapshot.data[index].gender,
              snapshot.data[index].classification,
              snapshot.data[index].sinopsis);
              },
            );
          }
        }
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
