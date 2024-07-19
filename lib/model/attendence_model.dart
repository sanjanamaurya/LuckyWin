// ignore_for_file: non_constant_identifier_names

class AttendanceModel {

  dynamic id;
  dynamic accumulatedAmount;
  dynamic attendanceBonus;
  dynamic status;
  dynamic createdAt;
  AttendanceModel(
      {this.id,
        this.accumulatedAmount,
        this.attendanceBonus,
        this.status,
        this.createdAt
      });
  AttendanceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    accumulatedAmount = json['accumulated_amount'];
    attendanceBonus = json['attendance_bonus'];
    status = json['status'];
    createdAt = json['created_at'];
  }
}