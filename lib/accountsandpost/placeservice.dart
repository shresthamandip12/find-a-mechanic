import 'package:http/http.dart' as http;
import 'dart:convert';
class NeededData{
  static Future<List<String>> getSuggestions(String query) async {
    List<String> matches = List();
    var data = await WeatherModel().getCities(query);

    try {
      String dataCity = data['results'][0]['formatted_address'];
      String dataCity1 = data['results'][1]['formatted_address'];
      String dataCity2 = data['results'][2]['formatted_address'];
      List<String> citiesMatching = [dataCity,dataCity1,dataCity2];
      matches.addAll(citiesMatching);
    } catch(e){
      if(e.toString() == 'RangeError (index): Invalid value: Only valid value is 0: 1'){
        String dataCity = data['_embedded']['city:search-results'][0]['matching_full_name'];
        List<String> citiesMatching = [dataCity];
        matches.addAll(citiesMatching);
      }
      else if(e.toString() == 'RangeError (length): Invalid value: Only valid value is 0: 1'){
        String dataCity = data['_embedded']['city:search-results'][0]['matching_full_name'];
        List<String> citiesMatching = [dataCity];
        matches.addAll(citiesMatching);
      }
    }



    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase())); //compares with the entered items
    return matches; //returns the most favorable city name
  }

}


class WeatherModel {

  Future<dynamic> getCities(String nameCity)async{
    NetworkHelper HelperNetwork = await NetworkHelper('https://maps.googleapis.com/maps/api/place/textsearch/json?query=$nameCity&key=AIzaSyDDZcscrAvTyTwUYjaxFsGE4uZBXp8QSZw');
    var holdData = await HelperNetwork.getdata();
    return holdData;
  }
}



class NetworkHelper{
  NetworkHelper(this.url);
  final String url;

  Future getdata() async{

    http.Response response = await http.get(url);
    try {
      String data = response.body;
      var decodedData = jsonDecode(data);
      return decodedData;
    }
    catch(e){
      print(e.toString());
    }
  }
}