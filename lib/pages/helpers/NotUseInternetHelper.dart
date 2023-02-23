import 'package:http/http.dart' as http;
import 'dart:convert';


class InternetHelper {

  String account = '4106030323';
  String password = '42100615';

  // String account = '4107056003';
  // String password = '03401014';


  List decodedData;
  Future getSid() async{
    final String getSidUrl = 'http://140.120.80.35/APPAPI/DeviceAuth.aspx?account=appNchu&password=NchuApp_89798198&restype=json';
    await http.get(getSidUrl).then((response){
      decodedData = jsonDecode(response.body);
    });
    //print('getSid : ${decodedData[0]['resdata']}');  //[{sid: 1914242c71314c0ea6ba, expire: 2021/02/25 00:22:41}]
    print('getSid : ${decodedData[0]['resdata'][0]['sid']}');
    return decodedData[0]['resdata'][0]['sid'];
  }


  Future getAuthid(String sid) async{
    final String getAuthidUrl = 'http://140.120.80.35/APPAPI/UserAuth.aspx?sid=$sid&account=$account&password=$password&lang=zh-tw&restype=json';
    await http.get(getAuthidUrl).then((response){
      decodedData = jsonDecode(response.body);
    });
    //print('getSid : ${decodedData[0]['resdata']}');  //[{sid: 1914242c71314c0ea6ba, expire: 2021/02/25 00:22:41}]
    print('getAuthid : ${decodedData[0]['resdata'][0]['authid']}');
    return decodedData[0]['resdata'][0]['authid'];
  }


}
