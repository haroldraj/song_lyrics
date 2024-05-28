class LyricsModel {
  String? artistName;
  String? songTitle;
  String? lyrics;

  LyricsModel({
    this.artistName,
    this.songTitle,
    this.lyrics,
  });

  /*factory SearchLyricsModel.fromJson(Map<String, String> json) {
    return SearchLyricsModel(lyrics: json['lyrics']);
  }*/
}
