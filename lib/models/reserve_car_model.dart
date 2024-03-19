class ReserveCarModel {
  String? resID;
  String? resProject;
  String? resStartDate;
  String? resEndDate;
  String? carID;
  String? accID;
  String? carBrand;
  String? carModel;
  String? carNumber;
  String? carMileage;
  String? carStatus;

  ReserveCarModel(
      {this.resID,
      this.resProject,
      this.resStartDate,
      this.resEndDate,
      this.carID,
      this.accID,
      this.carBrand,
      this.carModel,
      this.carNumber,
      this.carMileage,
      this.carStatus});

  ReserveCarModel.fromJson(Map<String, dynamic> json) {
    resID = json['Res_ID'];
    resProject = json['Res_Project'];
    resStartDate = json['Res_StartDate'];
    resEndDate = json['Res_EndDate'];
    carID = json['Car_ID'];
    accID = json['Acc_ID'];
    carBrand = json['Car_Brand'];
    carModel = json['Car_Model'];
    carNumber = json['Car_Number'];
    carMileage = json['Car_Mileage'];
    carStatus = json['Car_Status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Res_ID'] = this.resID;
    data['Res_Project'] = this.resProject;
    data['Res_StartDate'] = this.resStartDate;
    data['Res_EndDate'] = this.resEndDate;
    data['Car_ID'] = this.carID;
    data['Acc_ID'] = this.accID;
    data['Car_Brand'] = this.carBrand;
    data['Car_Model'] = this.carModel;
    data['Car_Number'] = this.carNumber;
    data['Car_Mileage'] = this.carMileage;
    data['Car_Status'] = this.carStatus;
    return data;
  }
}
