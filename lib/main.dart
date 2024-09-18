import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:konsi_test/app/app_module.dart';
import 'package:konsi_test/app/app_widget.dart';
import 'package:konsi_test/app/core/shared/services/database/database_service.dart';

/// Tempo de desenvolvimento [14 Horas]
///
/// Vai ser optado não aplicar [Testes Unitarios e Integração] pois não dará
/// tempo para fazer uma cobertura boa de testes, ai ficaria só por fazer mesmo.
///

/// [flutter_modular]
/// foi a opção mais simples para este projeto pequeno,
/// ele me oferece uma boa abordagem de modularização deste app,
/// possibilitando uma navegação mais simples e não tão complexa, e me dando ja a opção
/// de injeção de dependências;
///
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await DatabaseService().initialize();

  runApp(
    ModularApp(
      module: AppModule(),
      child: const AppWidget(),
    ),
  );
}
