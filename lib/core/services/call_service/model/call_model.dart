class Call {
  String? callerId;
  String? callerName;
  String? callerPic;
  String? recieverId;
  String? recieverName;
  String? recieverPic;
  String? channelId;
  bool? hasDialled;

  Call(
      {this.callerId,
      this.callerName,
      this.callerPic,
      this.recieverId,
      this.recieverName,
      this.recieverPic,
      this.channelId,
      this.hasDialled});
  Map<String, dynamic> toMap(Call call) {
    Map<String, dynamic> callMap = {};
    callMap["caller_id"] = call.callerId;
    callMap["caller_name"] = call.callerName;
    callMap["caller_pic"] = call.callerPic;
    callMap["receiver_id"] = call.recieverId;

    callMap["receiver_name"] = call.recieverName;
    callMap["receiver_pic"] = call.recieverPic;
    callMap["channel_id"] = call.channelId;
    callMap["has_dialled"] = call.hasDialled;
    return callMap;
  }

  Call.fromMap(Map callMap) {
    callerId = callMap["caller_id"];
    callerName = callMap["caller_name"];
    callerPic = callMap["caller_pic"];
    recieverId = callMap["receiver_id"];

    recieverName = callMap["receiver_name"];
    recieverPic = callMap["receiver_pic"];
    channelId = callMap["channel_id"];
    hasDialled = callMap["has_dialled"];
  }
}
