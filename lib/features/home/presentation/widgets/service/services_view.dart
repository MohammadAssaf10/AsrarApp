import 'package:asrar_app/config/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/strings_manager.dart';
import '../../blocs/services_bloc/bloc/services_bloc.dart';
import '../general/empty_list_view.dart';
import '../general/error_view.dart';
import '../general/loading_view.dart';
import 'service_widget.dart';

class ServicesView extends StatelessWidget {
  const ServicesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServicesBloc, ServicesState>(
      builder: (context, state) {
        if (state is LoadingServicesState)
          return LoadingView(
            height: MediaQuery.of(context).size.height / 1.5,
            width: MediaQuery.of(context).size.width,
          );
        else if (state is ErrorServicesState)
          return ErrorView(
            errorMessage: state.errorMessage.tr(context),
            height: MediaQuery.of(context).size.height / 1.5,
            width: MediaQuery.of(context).size.width,
          );
        else if (state is LoadedServicesState) {
          if (state.services.isNotEmpty) {
            return ListView.builder(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              itemCount: state.services.length,
              itemBuilder: (BuildContext context, int index) {
                return ServiceWidget(
                  service: state.services[index],
                );
              },
            );
          } else
            return EmptyListView(
              emptyListMessage: AppStrings.noServices.tr(context),
              height: MediaQuery.of(context).size.height / 1.5,
              width: MediaQuery.of(context).size.width,
            );
        }
        return SizedBox();
      },
    );
  }
}
