import 'package:dartz/dartz.dart';

import '../../../../core/data/failure.dart';
import '../entities/ad_image_entities.dart';
import '../entities/company_entities.dart';
import '../entities/course_entities.dart';
import '../entities/job_entities.dart';
import '../entities/news_entities.dart';
import '../entities/service_entities.dart';
import '../entities/subscription_entities.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<AdImageEntities>>> getAdImages();
  Future<Either<Failure, List<CompanyEntities>>> getCompanies();
  Future<Either<Failure, List<CourseEntities>>> getCourses();
  Future<Either<Failure, List<NewsEntities>>> getNews();
  Future<Either<Failure, List<ServiceEntities>>> getServices(
      String companyName);
  Future<Either<Failure, List<JobEntities>>> getJobs();
  Future<Either<Failure, List<SubscriptionEntities>>> getSubscriptions();
}
