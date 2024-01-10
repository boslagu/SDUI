class RequiredFields {
  String? fieldDisplay;
  int? fieldMaxLen;
  int? fieldMinLen;
  String? fieldName;
  String? fieldType;
  int? id;
  bool? isRequired;

  RequiredFields({
    this.fieldDisplay,
    this.fieldMaxLen,
    this.fieldMinLen,
    this.fieldName,
    this.fieldType,
    this.id,
    this.isRequired,
  });

  RequiredFields.fromJson(Map<String, dynamic> json) {
    fieldDisplay = json['field_display'];
    fieldMaxLen = json['field_max_len'];
    fieldMinLen = json['field_min_len'];
    fieldName = json['field_name'];
    fieldType = json['field_type'];
    id = json['id'];
    isRequired = json['is_required'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['field_display'] = this.fieldDisplay;
    data['field_max_len'] = this.fieldMaxLen;
    data['field_min_len'] = this.fieldMinLen;
    data['field_name'] = this.fieldName;
    data['field_type'] = this.fieldType;
    data['id'] = this.id;
    data['is_required'] = this.isRequired;
    return data;
  }
}
