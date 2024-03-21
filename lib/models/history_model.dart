class HistoryModel {
  String? hID;
  String? accID;
  String? carID;
  String? hStartDate;
  String? hEndtDate;
  String? hStartTime;
  String? hEndTime;
  String? hProject;
  String? hMileageStart;
  String? hMileageEnd;
  String? hPicFront;
  String? hPicBack;
  String? hPicLeft;
  String? hPicRight;
  String? hPicHood;
  String? hPicMileageEnd;
  String? hPicMileageStart;
  String? hStatus;

  HistoryModel(
      {this.hID,
      this.accID,
      this.carID,
      this.hStartDate,
      this.hEndtDate,
      this.hStartTime,
      this.hEndTime,
      this.hProject,
      this.hMileageStart,
      this.hMileageEnd,
      this.hPicFront,
      this.hPicBack,
      this.hPicLeft,
      this.hPicRight,
      this.hPicHood,
      this.hPicMileageEnd,
      this.hPicMileageStart,
      this.hStatus});

  HistoryModel.fromJson(Map<String, dynamic> json) {
    hID = json['H_ID'];
    accID = json['Acc_ID'];
    carID = json['Car_ID'];
    hStartDate = json['H_StartDate'];
    hEndtDate = json['H_EndtDate'];
    hStartTime = json['H_StartTime'];
    hEndTime = json['H_EndTime'];
    hProject = json['H_Project'];
    hMileageStart = json['H_MileageStart'];
    hMileageEnd = json['H_MileageEnd'];
    hPicFront = json['H_PicFront'];
    hPicBack = json['H_PicBack'];
    hPicLeft = json['H_PicLeft'];
    hPicRight = json['H_PicRight'];
    hPicHood = json['H_PicHood'];
    hPicMileageEnd = json['H_PicMileageEnd'];
    hPicMileageStart = json['H_PicMileageStart'];
    hStatus = json['H_Status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['H_ID'] = this.hID;
    data['Acc_ID'] = this.accID;
    data['Car_ID'] = this.carID;
    data['H_StartDate'] = this.hStartDate;
    data['H_EndtDate'] = this.hEndtDate;
    data['H_StartTime'] = this.hStartTime;
    data['H_EndTime'] = this.hEndTime;
    data['H_Project'] = this.hProject;
    data['H_MileageStart'] = this.hMileageStart;
    data['H_MileageEnd'] = this.hMileageEnd;
    data['H_PicFront'] = this.hPicFront;
    data['H_PicBack'] = this.hPicBack;
    data['H_PicLeft'] = this.hPicLeft;
    data['H_PicRight'] = this.hPicRight;
    data['H_PicHood'] = this.hPicHood;
    data['H_PicMileageEnd'] = this.hPicMileageEnd;
    data['H_PicMileageStart'] = this.hPicMileageStart;
    data['H_Status'] = this.hStatus;
    return data;
  }
}
