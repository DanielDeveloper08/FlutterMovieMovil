class Movie {
  final String title;
  final String gender;
  final String imgUrl;
  final String classification; 
  final String sinopsis; 

  const Movie({
    required this.title, 
    required this.gender, 
    required this.imgUrl,
    required this.classification,
    required this.sinopsis, 
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['title'],
      gender: json['gender_name'],
      imgUrl: "http://"+json['image_url'],
      classification: json['name'],
      sinopsis: json['sinopsis']
    ); 
  }
}