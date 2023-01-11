import 'package:dartz/dartz.dart';

import '../../../../core/data/failure.dart';
import '../entities/file_entities.dart';
import '../repositories/file_repository.dart';

class GetFileUseCase {
  final FileRepository fileRepository;

  GetFileUseCase(this.fileRepository);

  Future<Either<Failure, List<FileEntities>>> call(String folderName) async {
    return await fileRepository.getFile(folderName);
  }
}
