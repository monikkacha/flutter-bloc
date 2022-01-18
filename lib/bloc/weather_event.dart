import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {}

class WeatherFetch extends WeatherEvent {
  String cityName;
  WeatherFetch(this.cityName);

  @override
  List<Object?> get props => [cityName];
}

class WeatherClean extends WeatherEvent {
  @override
  List<Object?> get props => [];
}



