import 'dart:math';
import 'package:http/http.dart' as http;
import 'dart:convert';
const placesAPI = 'Your API KEY';
class NeedsData{
  static Future<List<String>> getSuggestions(String nameCity) async {
    Random random = new Random();
    int randomNumber = random.nextInt(1000);
    String url = 'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$nameCity&components=country:np&key=$placesAPI&sessiontoken=$randomNumber';
    var response = await http.get(url);
    List<String > data = List();
    var extractdata = jsonDecode(response.body);
    var datas = extractdata["predictions"];
    try{
      String dataCity =  datas[0]["description"];
      String dataCity1 = datas[1]["description"];
      String dataCity2 = datas[2]["description"];
      String dataCity3 =  datas[3]["description"];
      String dataCity4 = datas[2]["description"];
      List<String> citiesMatching = [dataCity,dataCity1,dataCity2,dataCity3,dataCity4];
      data.addAll(citiesMatching);
    }catch(e){
      print("Error");
    }
    data.retainWhere((s) => s.toLowerCase().contains(nameCity.toLowerCase()));

    return data;
  }


}