import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_project/bloc/weather_event.dart';
import 'package:weather_project/bloc/weather_state.dart';
import 'package:weather_project/utils/api_service.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc(WeatherState initialState) : super(initialState);

  @override
  WeatherState get initialState => WeatherEmpty();

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent weatherEvent) async*{
    if (weatherEvent is WeatherFetch) {
      yield* _getWeather(weatherEvent.cityName);
    } else if  (weatherEvent is WeatherClean) {
      yield WeatherEmpty();
    }
  }

  Stream<WeatherState> _getWeather (String cityName) async*{
    yield WeatherLoading();
    var response = await ApiService.getCityInfo(cityName: cityName);
    if (response[0]) {
      yield WeatherResult(responseMap: response[1]);
    } else {
      yield WeatherError();
    }
  }
}
