import 'package:http/http.dart' as http;
import 'dart:convert';


class InternetHelper {

  String account = '4106030323';
  String password = '42100615';

  // String account = '4107056003';
  // String password = '03401014';


  String sid ;
  String authid;

  static InternetHelper _instance;
  factory InternetHelper() => _getInstance();
  static InternetHelper get instance => _getInstance();
  static InternetHelper _getInstance(){
    if(_instance == null){
      _instance = InternetHelper._internal();
    }
    return _instance;
  }

  InternetHelper._internal(){ //初始化
    Future(getSid).then((value) => getAuthid(sid));
  }



  Future getSid() async{
    //print('getSid Called');
    List decodedData;
    final String getSidUrl = 'http://140.120.80.35/APPAPI/DeviceAuth.aspx?account=appNchu&password=NchuApp_89798198&restype=json';
    await http.get(getSidUrl).then((response){
      decodedData = jsonDecode(response.body);
    });
    //print('getSid : ${decodedData[0]['resdata']}');  //[{sid: 1914242c71314c0ea6ba, expire: 2021/02/25 00:22:41}]
    print('getSid : ${decodedData[0]['resdata'][0]['sid']}');
    sid = await decodedData[0]['resdata'][0]['sid'];
  }


  Future getAuthid(String sid) async{
    //print('getAuthid Called');
    List decodedData;
    final String getAuthidUrl = 'http://140.120.80.35/APPAPI/UserAuth.aspx?sid=$sid&account=$account&password=$password&lang=zh-tw&restype=json';
    await http.get(getAuthidUrl).then((response){
      decodedData = jsonDecode(response.body);
    });
    //print('getSid : ${decodedData[0]['resdata']}');  //[{sid: 1914242c71314c0ea6ba, expire: 2021/02/25 00:22:41}]
    print('getAuthid : ${decodedData[0]['resdata'][0]['authid']}');
    authid = await decodedData[0]['resdata'][0]['authid'];
  }

  List _bookInfoList;
  getBookedInfoList() async {
    if(_bookInfoList==null){
      List decodedData;
      final String host =
          'http://140.120.80.35/APPAPI/GetBookInfo.aspx?sid=$sid&authid=$authid&restype=json';
      //print('http://140.120.80.35/APPAPI/GetBookInfo.aspx?sid=${temp[0]}&authid=${temp[1]}&restype=json');
      await http.get(host).then((response) {
        decodedData = jsonDecode(response.body);
      });
      print('getBookedInfoList : $decodedData');
      _bookInfoList = decodedData;
      return _bookInfoList;
    }else{
      return _bookInfoList;
    }
  }

  List _demeritList;
  getDemeritList() async{
    if(_demeritList == null){
      List decodedData;
      final String host = 'http://140.120.80.35/APPAPI/GetDemeritList.aspx?sid=$sid&authid=$authid&restype=json';
      await http.get(host).then((response){
        decodedData = jsonDecode(response.body);
      });
      print('getDemeritList : $decodedData');
      _demeritList = decodedData;
      return _demeritList;
    }else{
      return _demeritList;
    }
  }

  List _remainSpace;
  Future getRemainSpace() async {
    if(_remainSpace == null){
      final String host = 'http://140.120.80.35/APPAPI/GetRemainderSpace.aspx?sid=$sid&authid=$authid&restype=json';
      List decodedData;
      await http.get(host).then((response) {
        decodedData = jsonDecode(response.body);
      });
      print('findSpaceType : called');
      _remainSpace = decodedData;
      return _remainSpace;
    }else{
      return _remainSpace;
    }
  }

  Map _canBookSpaceMap;
  Future getCanBookSpaceType() async{
    print('getCanBookSpaceType : Called');
    if(_canBookSpaceMap == null){
      _canBookSpaceMap = Map();
      List decodedData;
      final String host = 'http://140.120.80.35/APPAPI/GetCanBookSpaceType.aspx?sid=$sid&authid=$authid&restype=json';
      await http.get(host).then((response){
        decodedData = jsonDecode(response.body);
      });
      //print('getCanBookSpaceMap : $decodedData');
      List tempKey = [];
      List tempValue = [];

      for(int i=0;i < decodedData[0]['resdata'].length;i++){
        //print('${decodedData[0]['resdata'][i]['spacetypename']}');
        //print('${decodedData[0]['resdata'][i]['spacetype']}');
        tempKey.add(await decodedData[0]['resdata'][i]['spacetypename']);
        tempValue.add(await decodedData[0]['resdata'][i]['spacetype']);
      }
      // print(' tempKey : $tempKey');
      //print('_canBookSpaceMap : $_canBookSpaceMap');
      _canBookSpaceMap = Map.fromIterables(tempKey, tempValue);
      return _canBookSpaceMap;
    }else{
      //print('_canBookSpaceMap : $_canBookSpaceMap');
      return _canBookSpaceMap;
    }
  }

  Future getZoneInfo(String spaceType) async{
    Map _zoneInfoMap = Map();
    print('getZoneInfo : Called');
    List decodedData;
    final String host = 'http://140.120.80.35/APPAPI/GetZoneInfo.aspx?sid=$sid&authid=$authid&spacetype=$spaceType&restype=json';
    await http.get(host).then((response){
      decodedData = jsonDecode(response.body);
    });
    //print('getZoneInfo : $decodedData');
    List tempKey = [];
    List tempValue = [];

    for(int i=0;i < decodedData[0]['resdata'].length;i++){
      tempKey.add(await decodedData[0]['resdata'][i]['zonename']);
      tempValue.add(await decodedData[0]['resdata'][i]['zoneid']);
    }
    // print(' tempKey : $tempKey');
    _zoneInfoMap = Map.fromIterables(tempKey, tempValue);
    //print('_zoneInfoMap : $_zoneInfoMap');
    return _zoneInfoMap;
  }

  getBookDel(String bookid) async{
    List decodedData;
    final String host = 'http://140.120.80.35/APPAPI/BookDel.aspx?sid=$sid&authid=$authid&bookid=$bookid&restype=json';
    await http.get(host).then((response) {
      decodedData = jsonDecode(response.body);
    });
    print('getBookDel : $decodedData');
    return decodedData;
  }


}
