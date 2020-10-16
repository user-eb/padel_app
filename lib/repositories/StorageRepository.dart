import 'dart:io';

import 'package:padel_app/providers/StorageProvider.dart';
import 'package:padel_app/repositories/BaseRepository.dart';

class StorageRepository extends BaseRepository{
  StorageProvider storageProvider = StorageProvider();
  Future<String> uploadFile(File file, String path) => storageProvider.uploadFile(file, path);

  @override
  void dispose() {
    storageProvider.dispose();
  }
}