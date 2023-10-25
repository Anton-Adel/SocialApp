class MassegeModel{

  String? Text;
  String? SenderuId;
  String? ReseveruId;
  String? Date;


  MassegeModel({
    this.Text,
    this.SenderuId,
    this.ReseveruId,
    this.Date,

  });

  MassegeModel.fromjson(Map<String,dynamic> json){

    Text=json['Text'];
    SenderuId=json['SenderuId'];
    ReseveruId=json['ReseveruId'];
    Date=json['Date'];

  }

  Map<String,dynamic> ToMap(){
    return {
      'Text':Text,
      'SenderuId':SenderuId,
      'ReseveruId':ReseveruId,
      'Date':Date,


    };
  }


}