class InvitationBonusModel {
  dynamic bonusId;
  dynamic noOfUser;
  dynamic amount;
  dynamic claimAmount;
  dynamic status;
  dynamic noOfInvitees;
  dynamic referInvitees;

  InvitationBonusModel(
      {this.bonusId,
        this.noOfUser,
        this.amount,
        this.claimAmount,
        this.status,
        this.noOfInvitees,
        this.referInvitees});

  InvitationBonusModel.fromJson(Map<String, dynamic> json) {
    bonusId = json['bonus_id'];
    noOfUser = json['no_of_user'];
    amount = json['amount'];
    claimAmount = json['claim_amount'];
    status = json['status'];
    noOfInvitees = json['no_of_invitees'];
    referInvitees = json['refer_invitees'];
  }
}
