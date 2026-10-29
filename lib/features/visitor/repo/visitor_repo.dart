import 'package:sumadhura/constants/visitors_list.dart';
import 'package:sumadhura/model/visitors_model.dart';

class VisitorsRepo {
  Map<int, Visitors> visitorsMap = {};
  Future<List<Visitors>> getVisitors() async {
    try {
      if (visitorsMap.isEmpty) {
        for (final visitor in VisitorsList.visitors) {
          final key = visitor.id ?? 1;

          if (key != null) {
            visitorsMap[key] = visitor;
          }
        }
      }
      return visitorsMap.values.toList();
    } on Exception catch (e) {
      print('Error fetching visitors: $e');
      return [];
    }
  }

  Future<Visitors> getVisitorDetails(int visitorId) async {
    try {
      final visitor = visitorsMap[visitorId];
      if (visitor == null) {
        throw Exception('Visitor not found');
      }
      return visitor;
    } catch (e) {
      print('Error while fetching visitor details: $e');
      throw Exception('Error while fetching visitor details: $e');
    }
  }

  Future<Visitors> deleteVisitorDetails(int? visitorId) async {
    try {
      final visitor = visitorsMap[visitorId];
      if (visitor == null) {
        throw Exception('Visitor not found');
      }
      return visitorsMap.remove(visitorId) as Visitors;
    } catch (e) {
      print('Error while deleting visitor details: $e');
      throw Exception('Error while deleting visitor details: $e');
    }
  }

  Future<Visitors> registerVisitors(Visitors visitor) async {
    try {
      final key = visitor.id ?? visitorsMap.length + 1;

      if (visitorsMap.containsKey(key)) {
        throw Exception('Visitor ID already exists');
      }

      final registeredVisitor = visitor.copyWith(id: key);

      visitorsMap[key] = registeredVisitor;

      return registeredVisitor;
    } on Exception catch (e) {
      print('Error registering visitor: $e');
      throw Exception('Error registering visitor: $e');
    }
  }

  Future<Visitors> editVisitors(Visitors visitor) async {
    try {
      final int? visitorId = visitor.id;
      if (!(visitorId != null && visitorsMap.containsKey(visitorId))) {
        throw Exception('Visitor not found');
      }
      visitorsMap[visitorId] = visitor;
      return visitor;
    } catch (e) {
      print('Error editing visitor: $e');
      throw Exception('Error editing visitor: $e');
    }
  }
}
