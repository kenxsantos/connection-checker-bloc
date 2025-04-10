import 'package:check_connectivity/bloc/connection_state.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class ConnectionHelper {
  handleResult(ConnectivityResult result, Emitter<ConnectivityState> emit) {
    final connectionStatus = _mapConnectivityToMessage(result);
    final icon = _mapConnectivityToIcon(result);
    emit(ConnectivityUpdated(connectionStatus, icon));
  }

  Future<String> checkInternetConnection() async {
    try {
      final hasInternet = await InternetConnection().hasInternetAccess;
      if (hasInternet) {
        return "Internet Access Available";
      }
      return "No Internet Access";
    } catch (e) {
      return "Error Checking Internet";
    }
  }
}

String _mapConnectivityToMessage(ConnectivityResult result) {
  switch (result) {
    case ConnectivityResult.mobile:
      return "Mobile Network";
    case ConnectivityResult.wifi:
      return "WiFi Network";
    case ConnectivityResult.none:
      return "No Connection";
    default:
      return "Unknown Status";
  }
}

Icon _mapConnectivityToIcon(ConnectivityResult result) {
  switch (result) {
    case ConnectivityResult.mobile:
      return const Icon(Icons.signal_cellular_alt, size: 80);
    case ConnectivityResult.wifi:
      return const Icon(Icons.wifi, size: 80);
    case ConnectivityResult.none:
      return const Icon(Icons.wifi_off, size: 80);
    default:
      return const Icon(Icons.help_outline, size: 80);
  }
}
