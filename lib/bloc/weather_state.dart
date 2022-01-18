import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class WeatherState extends Equatable {
  @override
  List<Object> get props => [];
}

class WeatherEmpty extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherResult extends WeatherState {
  final Map responseMap;

  WeatherResult({required this.responseMap});

  @override
  List<Object> get props => [responseMap];
}

class WeatherError extends WeatherState {}
