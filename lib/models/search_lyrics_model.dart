class SearchLyricsModel {
  String? artistName;
  String? songTitle;
  String? lyrics;

  SearchLyricsModel({
    this.artistName,
    this.songTitle,
    this.lyrics,
  });

  /*factory SearchLyricsModel.fromJson(Map<String, String> json) {
    return SearchLyricsModel(lyrics: json['lyrics']);
  }*/
}
