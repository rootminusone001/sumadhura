class Visitors {
  final int? id;
  final String name;
  final String mobile;
  final String? email;
  final String visitorType;
  final String project;
  final String purpose;
  final String status;
  final String? createdAt;
  final String? checkInTime;
  final String? checkOutTime;

  const Visitors({
    this.id,
    required this.name,
    required this.mobile,
    this.email,
    required this.visitorType,
    required this.project,
    required this.purpose,
    this.status = 'Registered',
    this.createdAt,
    this.checkInTime,
    this.checkOutTime,
  });

  // Convert JSON from API into a Visitors object.
  factory Visitors.fromJson(Map<String, dynamic> json) {
    return Visitors(
      id: json['id'] as int?,
      name: json['name'] as String? ?? '',
      mobile: json['mobile'] as String? ?? '',
      email: json['email'] as String?,
      visitorType: json['visitor_type'] as String? ?? 'Other',
      project: json['project'] as String? ?? 'Project A',
      purpose: json['purpose'] as String? ?? '',
      status: json['status'] as String? ?? 'Registered',
      createdAt: json['created_at'] as String?,
      checkInTime: json['check_in_time'] as String?,
      checkOutTime: json['check_out_time'] as String?,
    );
  }

  // Convert a Visitors object into JSON for the API.
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'mobile': mobile,
      'email': email,
      'visitor_type': visitorType,
      'project': project,
      'purpose': purpose,
      'status': status,
      'created_at': createdAt,
      'check_in_time': checkInTime,
      'check_out_time': checkOutTime,
    };
  }

  // Create a copy with selected fields updated.
  Visitors copyWith({
    int? id,
    String? name,
    String? mobile,
    String? email,
    String? visitorType,
    String? project,
    String? purpose,
    String? status,
    String? createdAt,
    String? checkInTime,
    String? checkOutTime,
  }) {
    return Visitors(
      id: id ?? this.id,
      name: name ?? this.name,
      mobile: mobile ?? this.mobile,
      email: email ?? this.email,
      visitorType: visitorType ?? this.visitorType,
      project: project ?? this.project,
      purpose: purpose ?? this.purpose,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      checkInTime: checkInTime ?? this.checkInTime,
      checkOutTime: checkOutTime ?? this.checkOutTime,
    );
  }
}
