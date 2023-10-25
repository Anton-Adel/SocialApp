class SocialUserModel{

  String? name;
  String? email;
  String? phone;
  String? uId;
  String? profile;
  String? cover;
  String? bio;
  bool? IsVerified;

  SocialUserModel({
    this.name,
    this.email,
    this.phone,
    this.uId,
    this.cover,
    this.bio,
    this.profile,
    this.IsVerified
});

  SocialUserModel.fromjson(Map<String,dynamic> json){
    name=json['name'];
    email=json['email'];
    phone=json['phone'];
    cover=json['cover'];
    profile=json['profile'];
    bio=json['bio'];
    uId=json['uId'];
    IsVerified=json['IsVerified'];
  }

  Map<String,dynamic> ToMap(){
    return {
      'name':name,
      'email':email,
       'phone':phone,
      'uId':uId,
      'IsVerified':IsVerified,
      'profile':profile,
      'bio':bio,
      'cover':cover,

    };
  }


}