import 'dart:async';
import 'package:check_connectivity/bloc/connection_event.dart';
import 'package:check_connectivity/bloc/connection_state.dart';
import 'package:check_connectivity/utils/connection_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  final Connectivity _connectivity;
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  ConnectivityBloc()
    : _connectivity = Connectivity(),
      super(ConnectivityInitial("")) {
    on<CheckConnectivity>((event, emit) async {
      final result = await _connectivity.checkConnectivity();
      await Future.delayed(const Duration(seconds: 2));
      ConnectionHelper().handleResult(result.first, emit);
    });

    on<ConnectivityChanged>((event, emit) async {
      final ConnectionHelper helper = ConnectionHelper();
      emit(ConnectivityLoading("Checking connectivity..."));
      await Future.delayed(const Duration(seconds: 2));
      await helper.handleResult(event.connectionStatus, emit);
    });

    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((
      List<ConnectivityResult> results,
    ) {
      for (var result in results) {
        add(ConnectivityChanged(result));
      }
    });
  }

  @override
  Future<void> close() {
    _connectivitySubscription.cancel();
    return super.close();
  }
}
