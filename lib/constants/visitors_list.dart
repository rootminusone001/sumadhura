import 'package:sumadhura/constants/visitor_essential_choices.dart';
import 'package:sumadhura/model/visitors_model.dart';

class VisitorsList {
  static List<Visitors> visitors = [
    Visitors(
      id: 1,
      name: 'John Doe',
      mobile: '1234567890',
      email: 'eample1@gmail.com',
      visitorType: VisitorEssentialChoices.visitorType[0],
      project: VisitorEssentialChoices.project[0],
      createdAt: '2026-10-29 12:45:16.966',
      purpose: 'Business Meeting',
    ),
    Visitors(
      id: 2,
      name: 'Robert Smith',
      mobile: '1233212332',
      email: 'eample2@gmail.com',
      visitorType: VisitorEssentialChoices.visitorType[1],
      project: VisitorEssentialChoices.project[1],
      createdAt: '2026-10-29 12:45:16.966',
      purpose: 'Causal Visit',
    ),
    Visitors(
      id: 3,
      name: 'Zack Taylor',
      mobile: '1234567890',
      email: 'eample3@gmail.com',
      visitorType: VisitorEssentialChoices.visitorType[2],
      project: VisitorEssentialChoices.project[2],
      createdAt: '2026-10-29 12:45:16.966',
      purpose: 'Money Collection',
    ),
    Visitors(
      id: 4,
      name: 'Chris Johnson',
      mobile: '1234567812',
      email: 'eample4@gmail.com',
      visitorType: VisitorEssentialChoices.visitorType[3],
      project: VisitorEssentialChoices.project[3],
      createdAt: '2026-10-29 12:45:16.966',
      purpose: 'Inspection',
    ),
  ];
}
