import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

Future<void> globalVerbInit() async {
  late String path;
  Directory appDocDirectory = await getApplicationDocumentsDirectory();
  await Directory(appDocDirectory.path)
      .create(recursive: true)
      .then((Directory directory) => path = directory.path);
  Hive.init(path);
  //create box for data store
  await Hive.openBox("gitData");
}
