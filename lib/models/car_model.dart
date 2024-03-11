class CarModel {
  String? carID;
  String? carBrand;
  String? carModel;
  String? carNumber;
  String? carStatus;

  CarModel(
      {this.carID,
      this.carBrand,
      this.carModel,
      this.carNumber,
      this.carStatus});

  CarModel.fromJson(Map<String, dynamic> json) {
    carID = json['Car_ID'];
    carBrand = json['Car_Brand'];
    carModel = json['Car_Model'];
    carNumber = json['Car_Number'];
    carStatus = json['Car_Status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Car_ID'] = this.carID;
    data['Car_Brand'] = this.carBrand;
    data['Car_Model'] = this.carModel;
    data['Car_Number'] = this.carNumber;
    data['Car_Status'] = this.carStatus;
    return data;
  }
}
