import 'package:myapp/ui/manage_asistencias/backend/conferencias.dart';

abstract class ConferenciaRepository {
  Future<List<Conferencia>> getConferencias();
  Future<bool> addConferencias(Conferencia conferencia);
  Future<bool> editConferencia(Conferencia conferencia);
  Future<bool> deleteConferencia(Conferencia conferencia);
}
