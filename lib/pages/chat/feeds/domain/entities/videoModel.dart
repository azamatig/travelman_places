class VideoModel {
  final int videoId;
  final int soundId;
  final String title;
  final String soundTitle;
  final String url;
  final String videoGif;
  final String videoThumbnail;
  final int userId;
  final String userDP;
  final String soundImageUrl;
  final String tags;
  final String username;
  final String fname;
  final String lname;
  final String description;
  final int duration;
  final String createdAt;
  final String updatedAt;
  String totalLikes;
  String totalComments;
  String totalViews;
  int likeId;
  String followText;
  int isFollowing;
  VideoModel({
    this.videoId,
    this.soundId,
    this.title,
    this.url,
    this.videoGif,
    this.videoThumbnail,
    this.soundTitle,
    this.userId,
    this.tags,
    this.username,
    this.fname,
    this.lname,
    this.description,
    this.duration,
    this.createdAt,
    this.updatedAt,
    this.totalLikes,
    this.totalComments,
    this.totalViews,
    this.likeId,
    this.userDP,
    this.soundImageUrl,
    this.followText,
    this.isFollowing,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
        videoId: json["video_id"],
        soundId: json["sound_id"],
        soundTitle: json["sound_title"],
        title: json['title'],
        url: json['video'],
        videoGif: json['gif'],
        videoThumbnail: json['thumb'],
        userId: json['user_id'],
        username: json['username'],
        fname: json['fname'],
        lname: json['lname'],
        description: json['description'],
        duration: json['duration'],
        tags: json['tags'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
        totalLikes: json['total_likes'].toString(),
        totalViews: json['total_views'].toString(),
        totalComments: json['total_comments'].toString(),
        likeId: json['like_id'],
        userDP: json['user_dp'],
        soundImageUrl: json['sound_image_url'],
        followText: json['followText'] == null ? 'Follow' : json['followText'],
        isFollowing: json['isFollowing'] == null ? 0 : json['isFollowing']);
  }
}

class VideoModelList {
  final int currentPage;
  final List<VideoModel> data;
  final int lastPage;
  final int total;

  VideoModelList({
    this.currentPage,
    this.data,
    this.lastPage,
    this.total,
  });
  factory VideoModelList.fromJson(Map<String, dynamic> json) {
    return new VideoModelList(
      currentPage: json["current_page"] == null ? 1 : json["current_page"],
      data: json["data"] == null
          ? null
          : new List<VideoModel>.from(
              json["data"].map((x) => VideoModel.fromJson(x)),
            ),
      lastPage: json["last_page"] == null ? 1 : json["last_page"],
      total: json["total"] == null ? 1 : json["total"],
    );
  }
}

class VideoModelPageList {
  final String status;
  final String largePic;
  final String smallPic;
  final data;

  VideoModelPageList({
    this.status,
    this.largePic,
    this.smallPic,
    this.data,
  });
  factory VideoModelPageList.fromJson(Map<String, dynamic> json) {
    return new VideoModelPageList(
        status: json["status"] == null ? null : json["status"],
        largePic: json["large_pic"] == null ? null : json["large_pic"],
        smallPic: json["small_pic"] == null ? null : json["small_pic"],
        data: json["data"]);
  }
}
