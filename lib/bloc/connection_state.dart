import 'package:flutter/material.dart';

abstract class ConnectivityState {}

class ConnectivityInitial extends ConnectivityState {
  String initialMessage = "Checking connectivity...";
  ConnectivityInitial(this.initialMessage);
}

class ConnectivityUpdated extends ConnectivityState {
  final String connectionStatus;
  final String hasConnection;
  final Icon icon;
  ConnectivityUpdated(this.connectionStatus, this.hasConnection, this.icon);
}

class ConnectivityError extends ConnectivityState {
  final String errorMessage;
  ConnectivityError(this.errorMessage);
}

class ConnectivityLoading extends ConnectivityState {
  final String loadingMessage;
  ConnectivityLoading(this.loadingMessage);
}
