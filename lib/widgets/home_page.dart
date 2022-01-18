import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_project/bloc/weather_bloc.dart';
import 'package:weather_project/bloc/weather_event.dart';
import 'package:weather_project/bloc/weather_state.dart';
import 'package:weather_project/utils/snack_bar_helper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TextEditingController textEditingController = TextEditingController();
  late WeatherBloc weatherBloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("SFL Weather"),
        ),
        body: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is WeatherEmpty) {
              return inputData();
            }
            if (state is WeatherResult) {
              return resultData(state);
            }
            if (state is WeatherError) {
              return Text("Something went wrong please try again later");
            }
            return Center(child: CircularProgressIndicator());
          },
        ));
  }

  Widget resultData(WeatherResult weatherResult) {
    return Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20.0,),
            Text("dayTempe : ${weatherResult.responseMap["dayTempe"]}"),
            SizedBox(height: 20.0,),
            Text("nightTemp : ${weatherResult.responseMap["nightTemp"]}"),
            SizedBox(height: 20.0,),
            ElevatedButton(
                onPressed: () => cleanState(),
                child: Text("CHECK CITY WEATHER"))
          ],));
  }

  Widget inputData() {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery
              .of(context)
              .size
              .width * 0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 20.0,
          ),
          TextField(
            controller: textEditingController,
            decoration: InputDecoration(
              hintText: "Type City name here...",
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          ElevatedButton(onPressed: () => fetchData(), child: Text("FETCH")),
          SizedBox(
            height: 20.0,
          ),
          ElevatedButton(
              onPressed: () => textEditingController.text = "",
              child: Text("CLEAR"))
        ],
      ),
    );
  }

  @override
  void initState() {
    weatherBloc = BlocProvider.of<WeatherBloc>(context);
  }

  @override
  void dispose() {
    if (!weatherBloc.isClosed) {
      weatherBloc.close();
    }
    textEditingController.dispose();
  }

  void cleanState () {
    weatherBloc.add(WeatherClean());
  }

  void fetchData() async {
    if (textEditingController.value.text.isEmpty) {
      SnackBarHelper.showTextMsg(context: context, msg: "Please provide city!");
      return;
    }
    weatherBloc.add(WeatherFetch(textEditingController.value.text));
    textEditingController.text = "";
  }
}
