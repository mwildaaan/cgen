import 'package:cgen/flavors/env_config.dart';

enum ENV {
  DEV(
    EnvConfig(
      appsName: "",
      baseUrl: "https://0c9e-103-3-220-213.ngrok-free.app/api/v1/",
    ),
  ),
  STAG(
    EnvConfig(
      appsName: "",
      baseUrl: "https://kubik-staging.codelite.id/api/v1/",
    ),
  ),
  PROD(
    EnvConfig(
      appsName: "",
      baseUrl: "https://kubik-new.codelite.id/api/v1/",
    ),
  );

  const ENV(this.config);

  final EnvConfig config;
}
