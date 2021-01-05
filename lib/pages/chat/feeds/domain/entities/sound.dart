class SoundModel {
  final int soundId;
  final String title;
  final String url;
  final int userId;
  final String tags;
  final String imageUrl;
  final String category;
  final String catId;
  final String album;
  final String createdAt;
  int duration;
  int usedTimes;
  int fav;
  SoundModel({
    this.soundId,
    this.title,
    this.url,
    this.userId,
    this.tags,
    this.imageUrl,
    this.duration,
    this.fav,
    this.category,
    this.album,
    this.catId,
    this.usedTimes,
    this.createdAt,
  });

  factory SoundModel.fromJson(Map<String, dynamic> json) {
    return SoundModel(
        soundId: json["sound_id"],
        userId: json['user_id'],
        title: json['title'],
        url: json['sound_url'],
        tags: json['tags'],
        fav: json['fav'],
        duration: json['duration'],
        category: json['category'],
        catId: json['cat_id'],
        album: json['album'],
        usedTimes: json['used_times'],
        imageUrl: json['image_url'],
        createdAt: json['created_at']);
  }
}

class SoundModelList {
  final String status;
  final List<SoundModel> data;

  SoundModelList({
    this.status,
    this.data,
  });
  factory SoundModelList.fromJson(Map<String, dynamic> json) {
    return new SoundModelList(
      status: json["status"] == null ? null : json["status"],
      data: json["data"] == null
          ? null
          : new List<SoundModel>.from(
              json["data"].map((x) => SoundModel.fromJson(x)),
            ),
    );
  }
}
