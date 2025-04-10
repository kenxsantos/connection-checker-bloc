import 'package:check_connectivity/utils/connection_helper.dart';
import 'package:check_connectivity/widgets/connectivity_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:check_connectivity/bloc/connection_bloc.dart';
import 'package:check_connectivity/bloc/connection_event.dart';
import 'package:check_connectivity/bloc/connection_state.dart';

class ConnectivityScreen extends StatelessWidget {
  ConnectivityScreen({super.key});
  final ConnectionHelper helper = ConnectionHelper();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ConnectivityBloc()..add(CheckConnectivity()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Connectivity Example'),
          centerTitle: true,
        ),
        body: BlocBuilder<ConnectivityBloc, ConnectivityState>(
          builder: (context, state) {
            if (state is ConnectivityInitial || state is ConnectivityLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ConnectivityUpdated) {
              return FutureBuilder<String>(
                future: helper.checkInternetConnection(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return ConnectivityCard(
                      icon: state.icon,
                      status: state.connectionStatus,
                      internetAccessText: "Checking Internet Access...",
                    );
                  } else if (snapshot.hasError) {
                    return ConnectivityCard(
                      icon: state.icon,
                      status: state.connectionStatus,
                      internetAccessText: "Error Checking Internet",
                    );
                  } else {
                    return ConnectivityCard(
                      icon: state.icon,
                      status: state.connectionStatus,
                      internetAccessText:
                          snapshot.data ?? "Unknown Internet Access",
                    );
                  }
                },
              );
            } else if (state is ConnectivityError) {
              return ConnectivityCard(
                icon: const Icon(Icons.error, color: Colors.red, size: 80),
                status: state.errorMessage,
              );
            }
            return const Center(child: SizedBox.shrink());
          },
        ),
      ),
    );
  }
}
