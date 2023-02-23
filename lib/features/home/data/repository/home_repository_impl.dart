import 'package:asrar_app/features/home/domain/entities/subscription_entities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/app/constants.dart';
import '../../../../core/data/exception_handler.dart';
import '../../../../core/data/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/ad_image_entities.dart';
import '../../domain/entities/company_entities.dart';
import '../../domain/entities/course_entities.dart';
import '../../domain/entities/job_entities.dart';
import '../../domain/entities/news_entities.dart';
import '../../domain/entities/service_entities.dart';
import '../../domain/repository/home_repository.dart';

class HomeRepositoryImpl extends HomeRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final NetworkInfo networkInfo;
  HomeRepositoryImpl({
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<AdImageEntities>>> getAdImages() async {
    if (await networkInfo.isConnected) {
      try {
        List<AdImageEntities> adImagesList = [];
        final adImages =
            await firestore.collection(FireBaseConstants.adImages).get();
        for (var doc in adImages.docs) {
          adImagesList.add(AdImageEntities.fromMap(doc.data()));
        }
        return Right(adImagesList);
      } catch (e) {
        return Left(ExceptionHandler.handle(e).failure);
      }
    } else {
      return Left(DataSourceExceptions.noInternetConnections.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<CompanyEntities>>> getCompanies() async {
    if (await networkInfo.isConnected) {
      try {
        List<CompanyEntities> companiesList = [];
        final companies =
            await firestore.collection(FireBaseConstants.companies).get();
        for (var doc in companies.docs) {
          companiesList.add(CompanyEntities.fromMap(doc.data()));
        }
        companiesList
            .sort((a, b) => a.companyRanking.compareTo(b.companyRanking));
        return Right(companiesList);
      } catch (e) {
        return Left(ExceptionHandler.handle(e).failure);
      }
    } else {
      return Left(DataSourceExceptions.noInternetConnections.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<CourseEntities>>> getCourses() async {
    if (await networkInfo.isConnected) {
      try {
        List<CourseEntities> coursesList = [];
        final courses =
            await firestore.collection(FireBaseConstants.courses).get();
        for (var doc in courses.docs) {
          coursesList.add(CourseEntities.fromMap(doc.data()));
        }
        coursesList.sort((a, b) => a.timestamp.compareTo(b.timestamp));
        return Right(coursesList);
      } catch (e) {
        return Left(ExceptionHandler.handle(e).failure);
      }
    } else {
      return Left(DataSourceExceptions.noInternetConnections.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<NewsEntities>>> getNews() async {
    if (await networkInfo.isConnected) {
      try {
        List<NewsEntities> newsList = [];
        final news = await firestore.collection(FireBaseConstants.news).get();
        for (var doc in news.docs) {
          newsList.add(NewsEntities.fromMap(doc.data()));
        }
        newsList.sort((a, b) => a.timestamp.compareTo(b.timestamp));
        return Right(newsList);
      } catch (e) {
        return Left(ExceptionHandler.handle(e).failure);
      }
    } else {
      return Left(DataSourceExceptions.noInternetConnections.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<ServiceEntities>>> getServices(
      String companyName) async {
    if (await networkInfo.isConnected) {
      try {
        final List<ServiceEntities> servicesList = [];
        final services =
            await firestore.collection(FireBaseConstants.services).get();
        for (var doc in services.docs) {
          if (doc["companyName"] == companyName) {
            servicesList.add(ServiceEntities.fromMap(doc.data()));
          }
        }
        return Right(servicesList);
      } catch (e) {
        return Left(ExceptionHandler.handle(e).failure);
      }
    } else {
      return Left(DataSourceExceptions.noInternetConnections.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<JobEntities>>> getJobs() async {
    if (await networkInfo.isConnected) {
      try {
        List<JobEntities> jobsList = [];
        final jobs = await firestore.collection(FireBaseConstants.jobs).get();
        for (var doc in jobs.docs) {
          jobsList.add(JobEntities.fromMap(doc.data()));
        }
        jobsList.sort((a, b) => a.timestamp.compareTo(b.timestamp));
        return Right(jobsList);
      } catch (e) {
        return Left(ExceptionHandler.handle(e).failure);
      }
    } else {
      return Left(DataSourceExceptions.noInternetConnections.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<SubscriptionEntities>>> getSubscriptions() async {
    if (await networkInfo.isConnected) {
      try {
        List<SubscriptionEntities> subscriptionsList = [];
        final subscriptions =
            await firestore.collection(FireBaseConstants.subscriptions).get();
        for (var doc in subscriptions.docs) {
          subscriptionsList.add(SubscriptionEntities.fromMap(doc.data()));
        }
        return Right(subscriptionsList);
      } catch (e) {
        return Left(ExceptionHandler.handle(e).failure);
      }
    } else {
      return Left(DataSourceExceptions.noInternetConnections.getFailure());
    }
  }
}
