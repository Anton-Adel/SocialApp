class SocialPostModel{

  String? name;
  String? uId;
  String? profile;
  String?dateTime;
  String? postImage;
  String?text;

  SocialPostModel({
    this.name,
    this.uId,
    this.text,
    this.dateTime,
    this.profile,
    this.postImage
  });

  SocialPostModel.fromjson(Map<String,dynamic> json){

    name=json['name'];
    postImage=json['postImage'];
    profile=json['profile'];
    dateTime=json['dateTime'];
    uId=json['uId'];
    text=json['text'];
  }

  Map<String,dynamic> ToMap(){
    return {
      'name':name,
      'uId':uId,
      'text':text,
      'profile':profile,
      'dateTime':dateTime,
      'postImage':postImage,

    };
  }


}