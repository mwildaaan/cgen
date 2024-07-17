import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:recase/recase.dart';
import 'package:path/path.dart' as path;
import 'package:yaml/yaml.dart';
import 'generate.dart' as generate;

Future<void> main(List<String> args) async {
  var location = Platform.script.toString();
  var isNewFlutter = location.contains(".snapshot");
  if (isNewFlutter) {
    var sp = Platform.script.toFilePath();
    var sd = sp.split(Platform.pathSeparator);
    sd.removeLast();
    var scriptDir = sd.join(Platform.pathSeparator);
    var packageConfigPath = [scriptDir, '..', '..', '..', 'package_config.json'].join(Platform.pathSeparator);
    var jsonString = File(packageConfigPath).readAsStringSync();
    Map<String, dynamic> packages = jsonDecode(jsonString);
    var packageList = packages["packages"];
    String? cgenUri;
    for (var package in packageList) {
      if (package["name"] == "cgen") {
        cgenUri = package["rootUri"];
        break;
      }
    }
    if (cgenUri == null) {
      print("error uri");
      return;
    }
    if (cgenUri.contains("../../")) {
      cgenUri = cgenUri.replaceFirst("../", "");
      cgenUri = path.absolute(cgenUri, "");
    }
    if (cgenUri.contains("file:///")) {
      cgenUri = cgenUri.replaceFirst("file://", "");
      cgenUri = path.absolute(cgenUri, "");
    }
    location = cgenUri;
  }

  ReCase rc = ReCase("");
  String appRootFolder = path.absolute("", "");

  var pubFile = File("$appRootFolder/pubspec.yaml");
  var doc = loadYaml(pubFile.readAsStringSync());
  String appName = doc['name'];

  String libPath = "$location/lib";
  String appPath = "$appRootFolder/lib";
  var list = await dirContents(Directory(libPath));
  for(var element in list){
    if(!element.toString().contains("feature")){
      if(element.toString().contains("Directory")){
        var newFolder = "$appPath${element.path.replaceFirst(libPath, "")}";
        if (!Directory(newFolder).existsSync()) {
          print("CREATE FOLDER => $newFolder");
          Directory(newFolder).createSync(recursive: true);
        }
      }else{
        String fileContent = await createFile(element.path, rc, appName);
        var newFile = "$appPath${element.path.replaceFirst(libPath, "").replaceAll("example", rc.snakeCase).replaceFirst(".stub", "")}";
        print("CREATE FILE => $newFile");
        File(newFile).writeAsStringSync(fileContent);
      }
    }
  }

  // ADD FEATURE HOME
  print("add home feature ....");
  await generate.main(["Home"]);

  print("completed ....");
}

Future<List<FileSystemEntity>> dirContents(Directory dir) {
  var files = <FileSystemEntity>[];
  var completer = Completer<List<FileSystemEntity>>();
  var lister = dir.list(recursive: true);
  lister.listen((file) => files.add(file),
      // should also register onError
      onDone: () => completer.complete(files));
  return completer.future;
}

Future<String> createFile(String path, ReCase rc, String appName) async {
  String result = File(path).readAsStringSync();
  result = result.replaceAll("cgen", appName);
  result = result.replaceAll("Example", rc.pascalCase);
  result = result.replaceAll("example", rc.snakeCase);
  result = result.replaceAll("EXAMPLE", rc.constantCase);
  return result;
}