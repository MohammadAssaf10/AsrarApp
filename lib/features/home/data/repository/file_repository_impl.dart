import 'package:asrar_app/core/app/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/app/functions.dart';
import '../../../../core/data/exception_handler.dart';
import '../../../../core/data/failure.dart';
import '../../domain/entities/file_entities.dart';
import '../../domain/repository/file_repository.dart';

class FileRepositoryImpl extends FileRepository {


  @override
  Future<Either<Failure, Unit>> updateUserImage(
      XFile image, String email) async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      final path = "${FireBaseConstants.user}/$email";
      final user = await firestore.collection("Users").doc(email).get();
      if (user['imageURL'] == "" && user['imageName'] == "") {
        final FileEntities file =
            await uploadFile("$path/${image.name}", image);
        await firestore.collection("Users").doc(email).update({
          "imageURL": file.url,
          "imageName": file.name,
        });
      } else {
        await deleteFile("$path/${user['imageName']}");
        final FileEntities file =
            await uploadFile("$path/${image.name}", image);
        await firestore.collection("Users").doc(email).update({
          "imageURL": file.url,
          "imageName": file.name,
        });
      }
      return const Right(unit);
    } catch (e) {
      return Left(ExceptionHandler.handle(e).failure);
    }
  }
}
