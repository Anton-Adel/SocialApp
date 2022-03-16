class UserModel{
  String? name;
  String?phone;
  String? uid;
  String?email;
  String? profile;
  String? cover;
  String? bio;
  String?date;
  String?gender;

  UserModel({
    this.uid,
    this.phone,
    this.name,
    this.profile,
    this.cover,
    this.bio,
    this.email,
    this.date,
    this.gender
});

  UserModel.fromjson(Map<String,dynamic> json){

    name=json['name'];
    email=json['email'];
    phone=json['phone'];
    cover=json['cover'];
    profile=json['profile'];
    bio=json['bio'];
    uid=json['uid'];
    date=json['date'];
    gender=json['gender'];

  }

  Map<String,dynamic> ToMap(){
    return {
      'name':name,
      'email':email,
      'phone':phone,
      'uid':uid,
      'date':date,
      'profile':profile,
      'bio':bio,
      'cover':cover,
      'gender':gender,

    };
  }


}