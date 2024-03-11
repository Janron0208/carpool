class DetailModel {
  String? carBrand;
  String? carModel;
  String? carNumber;
  String? mileLastUpdate;
  String? dateLastUpdate;
  String? stName;

  DetailModel(
      {this.carBrand,
      this.carModel,
      this.carNumber,
      this.mileLastUpdate,
      this.dateLastUpdate,
      this.stName});

  DetailModel.fromJson(Map<String, dynamic> json) {
    carBrand = json['Car_Brand'];
    carModel = json['Car_Model'];
    carNumber = json['Car_Number'];
    mileLastUpdate = json['Mile_LastUpdate'];
    dateLastUpdate = json['Date_LastUpdate'];
    stName = json['St_Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Car_Brand'] = this.carBrand;
    data['Car_Model'] = this.carModel;
    data['Car_Number'] = this.carNumber;
    data['Mile_LastUpdate'] = this.mileLastUpdate;
    data['Date_LastUpdate'] = this.dateLastUpdate;
    data['St_Name'] = this.stName;
    return data;
  }
}
