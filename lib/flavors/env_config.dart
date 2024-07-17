class EnvConfig {
  final String appsName;
  final String baseUrl;
  final bool shouldCollectCrashLog;

  // late final Logger logger;

  const EnvConfig({
    required this.appsName,
    required this.baseUrl,
    this.shouldCollectCrashLog = false,
  });
}