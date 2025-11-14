class QTabHeader {
  List<Results> results = [];

  QTabHeader.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      json['results'].forEach((v) {
        results.add(Results.fromJson(v));
      });
    }
  }
}

class Results {
  String gp = '';
  String name = '';
  String shift = '';

  Results.fromJson(Map<String, dynamic> json) {
    gp = json['REMARKS'];
    name = json['EMP_NAME'];
    shift = json['SHIFT_NAME'];
  }
}
