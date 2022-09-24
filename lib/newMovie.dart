import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter_project_cinema/home.dart';
import 'package:flutter_project_cinema/models/movie.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_project_cinema/services/moviesService.dart';

class NewMovie extends StatefulWidget{
  const NewMovie({super.key, this.restorationId});
  final String? restorationId;
  @override
  State<NewMovie> createState() => _NewMovieState();
}
class _NewMovieState extends State<NewMovie>with RestorationMixin {
  @override
  String? get restorationId => widget.restorationId;
  MoviesService moviesService = MoviesService();
  late final Future? getCategories = moviesService.fetchCategories();
  late final Future? getGenders = moviesService.fetchGenders();
  List<dynamic> categories = [];

  var movie = <String, String>{
    "movie_id": "1",
    "title": "",
    "sinopsis":
        "",
    "gender_id": "",
    "category_id": "",
    "image_url": "",
    "release_date": "2022-07-6",
    "status": "A"
  };

  //XFile? imageFile=null; //variable for choosed file
  String? baseImage;

  Future<void> chooseImage() async {
    var choosedimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
        setState(() {
          baseImage = choosedimage!.path;
        });
  }

  final RestorableDateTime _selectedDate =
      RestorableDateTime(DateTime(2021, 7, 25));
  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
      RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  static Route<DateTime> _datePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime(2021),
          lastDate: DateTime(2022),
        );
      },
    );
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        dateEditing.text='${_selectedDate.value.year}-${_selectedDate.value.month}-${_selectedDate.value.day}';
      });
    }
  }
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
      child: ListView(children: [
        newMovie(),
        imagen(context),
        botonImagen(context),
        titulo(),
        clasificacion(),
        genero(),
        sinopsis(),
        releaseDate(),
        Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                botonGuardar(),
                const SizedBox(
                  width: 15,
                  height: 50,
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
      child: image());
  }
  Widget image(){
    if(baseImage!=null && !baseImage!.isEmpty)
    return Image.file(File(baseImage!));
    else
    return Image.network(
          'https://cdn-icons-png.flaticon.com/512/2503/2503529.png');
  }

  Widget titulo() {
    return TextFormField(
      onChanged: (value) => movie['title']=value,
        validator: (value) {
          if (value != null && value.isEmpty) {
            return "Debe ingresar un título.";
          }
          return null;
        },
        decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            labelText: 'Titulo',
            fillColor: Colors.white70));
  }
  String? clasificacionValue='1';
  Widget clasificacion() {
    return FutureBuilder(
        future: getCategories,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text("Cargando..."));
          } else {if(snapshot.data.length>0)movie['category_id']=snapshot.data.first.id;
            return DropdownButton<String>(
              value: clasificacionValue,
              elevation: 16,
              style: const TextStyle(color: Colors.blueGrey),
              underline: Container(
                height: 2,
                color: Colors.blueGrey,
              ),
              onChanged: (String? value) {
                setState(() {
                  if(value!=null){
                  clasificacionValue=value;
                  movie['category_id']=value;
                }
                });
                
              },
              items: snapshot.data.map<DropdownMenuItem<String>>((value) {
                return DropdownMenuItem<String>(
                  value: value.id,
                  child: Text(value.name),
                );
              }).toList(),
            );
          }
        });
  }
  String? dropdownValue='1';
  StatefulWidget genero() {
    return FutureBuilder(
        future: getGenders,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text("Cargando..."));
          } else {
            if(snapshot.data.length>0)movie['gender_id']=snapshot.data.first.id;
            return DropdownButton<String>(
              value: dropdownValue,
              elevation: 16,
              style: const TextStyle(color: Colors.blueGrey),
              underline: Container(
                height: 2,
                color: Colors.blueGrey,
              ),
              onChanged: (value) {
                setState(() {
                  if(value!=null){
                  dropdownValue=value;
                  movie['gender_id']=value;
                }
                });
              },
              items: snapshot.data.map<DropdownMenuItem<String>>((Gender value) {
                return DropdownMenuItem<String>(
                  value: value.id,
                  child: Text(value.name),
                );
              }).toList(),
            );
          }
        });
  }
  
  Widget sinopsis() {
    return TextFormField(
      onChanged: (value) => movie['sinopsis']=value,
      /*validator: (value) {
        if (value != null && value.isEmpty) {
          return "Debe ingresar una sinopsis.";
        }
        return null;
      },*/
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
  String _selectedDateShow="";
  TextEditingController dateEditing=TextEditingController();
  Widget releaseDate(){
    return Row(children: [
      Expanded(child: TextFormField(
        readOnly: true,
        controller: dateEditing,
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Fecha de Salida',
          fillColor: Colors.blue),
      )),
      SizedBox(
      width: 100,
      height: 40,
      child: ElevatedButton(
        onPressed: () {
          _restorableDatePickerRouteFuture.present();
        },
        style: TextButton.styleFrom(backgroundColor: Colors.grey),
        child: const Text("Fecha"),
      ),
    )
    ],);
  }
  Widget botonGuardar() {
    return SizedBox(
      width: 100,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          if (baseImage != null) {
            movie['release_date']=dateEditing.text;
            moviesService.saveMovie(baseImage!, json.encode(movie).toString());
            
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
      height: 50,
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
