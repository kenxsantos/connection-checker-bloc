import 'package:connectivity_plus/connectivity_plus.dart';

sealed class ConnectivityEvent {}

final class CheckConnectivity extends ConnectivityEvent {}

final class ConnectivityChanged extends ConnectivityEvent {
  final ConnectivityResult connectionStatus;
  ConnectivityChanged(this.connectionStatus);
}
