class Irrigacao {
  int data;
  dynamic irrigacao;
  dynamic deficit;
  dynamic rain;
  bool? irrigated;
  int position;
  dynamic available_water;
  Irrigacao(
      {required this.data,
      required this.irrigacao,
      required this.deficit,
      required this.rain,
      this.irrigated,
      required this.position,
      this.available_water});
}
