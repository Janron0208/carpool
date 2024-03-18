class ReserveModel {
  String? resID;
  String? resProject;
  String? resStartDate;
  String? resEndDate;
  String? carID;
  String? accID;

  ReserveModel(
      {this.resID,
      this.resProject,
      this.resStartDate,
      this.resEndDate,
      this.carID,
      this.accID});

  ReserveModel.fromJson(Map<String, dynamic> json) {
    resID = json['Res_ID'];
    resProject = json['Res_Project'];
    resStartDate = json['Res_StartDate'];
    resEndDate = json['Res_EndDate'];
    carID = json['Car_ID'];
    accID = json['Acc_ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Res_ID'] = this.resID;
    data['Res_Project'] = this.resProject;
    data['Res_StartDate'] = this.resStartDate;
    data['Res_EndDate'] = this.resEndDate;
    data['Car_ID'] = this.carID;
    data['Acc_ID'] = this.accID;
    return data;
  }
}
