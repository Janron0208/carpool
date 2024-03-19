class ReserveAccountModel {
  String? resID;
  String? resProject;
  String? resStartDate;
  String? resEndDate;
  String? carID;
  String? accID;
  String? accType;
  String? accCode;
  String? accFullname;
  String? accNickname;
  String? accTel;
  String? accLine;
  String? accPassword;
  String? accStatus;

  ReserveAccountModel(
      {this.resID,
      this.resProject,
      this.resStartDate,
      this.resEndDate,
      this.carID,
      this.accID,
      this.accType,
      this.accCode,
      this.accFullname,
      this.accNickname,
      this.accTel,
      this.accLine,
      this.accPassword,
      this.accStatus});

  ReserveAccountModel.fromJson(Map<String, dynamic> json) {
    resID = json['Res_ID'];
    resProject = json['Res_Project'];
    resStartDate = json['Res_StartDate'];
    resEndDate = json['Res_EndDate'];
    carID = json['Car_ID'];
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
    data['Res_ID'] = this.resID;
    data['Res_Project'] = this.resProject;
    data['Res_StartDate'] = this.resStartDate;
    data['Res_EndDate'] = this.resEndDate;
    data['Car_ID'] = this.carID;
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
