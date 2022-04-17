class MassegeModel{

  String? Text;
  String? SenderuId;
  String? ReseveruId;
  String? Date;
  String? image;


  MassegeModel({
    this.Text,
    this.SenderuId,
    this.ReseveruId,
    this.Date,
    this.image,

  });

  MassegeModel.fromjson(Map<String,dynamic> json){

    Text=json['Text'];
    SenderuId=json['SenderuId'];
    ReseveruId=json['ReseveruId'];
    Date=json['Date'];
    image=json['image'];

  }

  Map<String,dynamic> ToMap(){
    return {
      'Text':Text,
      'SenderuId':SenderuId,
      'ReseveruId':ReseveruId,
      'Date':Date,
      'image':image,


    };
  }


}