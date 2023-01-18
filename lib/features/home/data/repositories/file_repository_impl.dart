import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../../core/data/exception_handler.dart';
import '../../../../core/data/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/file_entities.dart';
import '../../domain/repositories/file_repository.dart';

class FileRepositoryImpl implements FileRepository {
  final FirebaseStorage storage;
  final NetworkInfo networkInfo;

  FileRepositoryImpl({required this.storage, required this.networkInfo});

  Future<List<String>> downloadUrlFile(List<Reference> refs) async =>
      Future.wait(refs.map((ref) => ref.getDownloadURL()).toList());

  @override
  Future<Either<Failure, List<FileEntities>>> getFile(String folderName) async {
    if (await networkInfo.isConnected) {
      try {
        final Reference ref = storage.ref(folderName);
        final ListResult result = await ref.listAll();
        final List<String> urls = await downloadUrlFile(result.items);
        final List<FileEntities> files = urls
            .asMap()
            .map((key, value) {
              final ref = result.items[key];
              final fileName = ref.name;
              final FileEntities file =
                  FileEntities(name: fileName, url: value);
              return MapEntry(key, file);
            })
            .values
            .toList();
        return Right(files);
      } catch (e) {
        return Left(ExceptionHandler.handle(e).failure);
      }
    } else
      return Left(DataSourceExceptions.noInternetConnections.getFailure());
  }
}
