class UserModel {
  String? accID;
  String? accType;
  String? accCode;
  String? accFullname;
  String? accNickname;
  String? accTel;
  String? accLine;
  String? accPassword;
  String? accStatus;

  UserModel(
      {this.accID,
      this.accType,
      this.accCode,
      this.accFullname,
      this.accNickname,
      this.accTel,
      this.accLine,
      this.accPassword,
      this.accStatus});

  UserModel.fromJson(Map<String, dynamic> json) {
    accID = json['Acc_ID'];
    accType = json['Acc_Type'];
    accCode = json['Acc_Code'];
    accFullname = json['Acc_Fullname'];
    accNickname = json['Acc_Nickname'];
    accTel = json['Acc_Tel'];
    accLine = json['Acc_Line'];
    accPassword = json['Acc_Password'];
    accStatus = json['Acc_Status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Acc_ID'] = this.accID;
    data['Acc_Type'] = this.accType;
    data['Acc_Code'] = this.accCode;
    data['Acc_Fullname'] = this.accFullname;
    data['Acc_Nickname'] = this.accNickname;
    data['Acc_Tel'] = this.accTel;
    data['Acc_Line'] = this.accLine;
    data['Acc_Password'] = this.accPassword;
    data['Acc_Status'] = this.accStatus;
    return data;
  }
}
