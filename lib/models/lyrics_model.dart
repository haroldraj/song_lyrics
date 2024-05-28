class LyricsModel {
  String? artistName;
  String? songTitle;
  String? lyrics;

  LyricsModel({
    this.artistName,
    this.songTitle,
    this.lyrics,
  });

  factory LyricsModel.fromJson(Map<String, dynamic> json) {
    return LyricsModel(
        artistName: json['artistName'],
        songTitle: json['songTitle'],
        lyrics: json['lyrics']);
  }

  Map<String, dynamic> toJson() {
    return {
      'artistName': artistName,
      'songTitle': songTitle,
      'lyrics': lyrics,
    };
  }
}
