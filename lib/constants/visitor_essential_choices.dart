import 'package:sumadhura/utils/project_enums.dart';

class VisitorEssentialChoices {
  static const List<String> visitorType = [
    'Owner',
    'Tenant',
    'Contractor',
    'Delivery Person',
    'Other',
  ];
  static const List<String> project = [
    'Project A',
    'Project B',
    'Project C',
    'Project D',
  ];
  static const Map<VisitorStatus, String> visitorStatus = {
    VisitorStatus.REGISTERED: 'Registered',
    VisitorStatus.CHECKEDIN: 'Checked In',
    VisitorStatus.CHECKEDOUT: 'Checked Out',
  };
}
