class TabHeader {
  List<Results> results = [];

  TabHeader.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      json['results'].forEach((v) {
        results.add(new Results.fromJson(v));
      });
    }
  }
}

class Results {
  String? routeid;
  String? stopid;
  String? empno;
  String? createby;
  String? createdate;
  String? updateby;
  String? updatedate;
  String? shiftgroup;
  String? shiftid;
  String? shiftdate;
  String? shifttime;
  String? cellno;
  String? processby;
  String? gp;
  String? name;
  String? category;
  String? shift;

  Results.fromJson(Map<String, dynamic> json) {
    routeid = json['ROUTE_ID'];
    stopid = json['STOP_ID'];
    empno = json['EMP_NO'];
    createby = json['CREATE_BY'];
    createdate = json['CREATE_DATE'];
    updateby = json['UPDATE_BY'];
    updatedate = json['UPDATE_DATE'];
    shiftgroup = json['SHIFT_GROUP'];
    shiftid = json['SHIFT_ID'];
    shiftdate = json['SHIFT_DATE'];
    shifttime = json['SHIFT_TIME'];
    cellno = json['CELL_NO'];
    processby = json['PROCESS_BY'];
    gp = json['REMARKS'];
    name = json['EMP_NAME'];
    category = json['AREA_CATEGORY'];
    shift = json['SHIFT_NAME'];
  }
}
