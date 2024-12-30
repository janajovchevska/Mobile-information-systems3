class Joke {

  int id;
  String type;
  String setup;
  String punchline;
  bool isFavorite;

  Joke({required this.id, required this.type,required this.setup, required this.punchline, this.isFavorite = false});

  Joke.fromJson(Map<String, dynamic> data)
      : id = data['id'],
        type = data['type'],
        setup = data['setup'],
        punchline = data['punchline'],
        isFavorite=false;

}
