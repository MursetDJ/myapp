import 'package:myapp/ui/beneficios/backend/beneficios.dart';

abstract class BeneficiosRepository {
  Future<List<Beneficios>> getBeneficios();
  Future<bool> addBeneficio(Beneficios beneficio);
  Future<bool> editBeneficio(Beneficios beneficio);
  Future<bool> deleteBeneficio(Beneficios beneficio);
}
