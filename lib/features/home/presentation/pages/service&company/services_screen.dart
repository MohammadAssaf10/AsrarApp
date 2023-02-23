import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../config/app_localizations.dart';
import '../../../../../config/strings_manager.dart';
import '../../../domain/entities/company_entities.dart';
import '../../blocs/services_bloc/services_bloc.dart';
import '../../widgets/general/empty_list_view.dart';
import '../../widgets/general/error_view.dart';
import '../../widgets/general/loading_view.dart';
import '../../widgets/service/services_view.dart';

class ServicesScreen extends StatelessWidget {
  final CompanyEntities company;
  const ServicesScreen(this.company, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(company.name)),
      body: BlocBuilder<ServicesBloc, ServicesState>(builder: (context, state) {
        if (state is LoadingServicesState) {
          return LoadingView(
            height: MediaQuery.of(context).size.height / 1.2,
            width: MediaQuery.of(context).size.width,
          );
        } else if (state is ErrorServicesState) {
          return ErrorView(
            errorMessage: state.errorMessage.tr(context),
            height: MediaQuery.of(context).size.height / 1.2,
            width: MediaQuery.of(context).size.width,
          );
        } else if (state is LoadedServicesState) {
          if (state.services.isNotEmpty) {
            return ServicesView(servicesList: state.services);
          } else {
            return EmptyListView(
              emptyListMessage: AppStrings.noServices.tr(context),
              height: MediaQuery.of(context).size.height / 1.2,
              width: MediaQuery.of(context).size.width,
            );
          }
        }
        return const SizedBox();
      }),
    );
  }
}