import 'package:dartz/dartz.dart';

import '../../../../core/data/failure.dart';
import '../entities/file_entities.dart';

abstract class FileRepository {
  Future<Either<Failure, List<FileEntities>>> getFile(String folderName);
}
