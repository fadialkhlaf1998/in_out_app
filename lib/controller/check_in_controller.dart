import 'package:get/get.dart';
import 'package:in_out_app/helper/api.dart';
import 'package:geolocator/geolocator.dart';
import 'package:in_out_app/helper/app.dart';
import 'package:in_out_app/helper/global.dart';
import 'package:in_out_app/model/day_person.dart';
import 'package:in_out_app/view/login.dart';


class CheckInController extends GetxController{
  var loading = false.obs;
  var afterLoading = false.obs;
  var fake = false.obs;
  var bottomSheetOpened = false.obs;

  List<DayPerson> persons = <DayPerson>[];
  var bottomSheetLoading = false.obs;

  alwaysUpdateScreen()async{
    while(true){
      await Future.delayed(Duration(milliseconds: 1000));
      fake.value = !fake.value;
    }
  }

  checkIn(int state)async{

    if(Global.employee !=null){
      loading.value = true;
      var location = await _determinePosition();
      if(location!=null){
        DateTime now = DateTime.now();
        Global.employee!.time = now.hour.toString()+":"+now.minute.toString();
        Global.employee!.date = now.year.toString()+"-"+now.month.toString()+"-"+now.day.toString()+"T"+"00:00:00.000Z";
        bool succ = await Api.checkIn(state, "https://www.google.com/maps/search/?api=1&query=${location.latitude},${location.longitude}",now);
        if(succ){
          Global.state = state;
          Global.myDate = Global.employee!.getMyDate();
          afterLoading.value = true;
          loading.value = false;
          //App.succMsg("Successfully", "Thanks For Using Our Service");

          await Future.delayed(Duration(milliseconds: 780));
          afterLoading.value = false;
        }else{
          loading.value = false;
          App.errMsg("Failed", "Oops Please Try Again");
        }
      }else{
        loading.value = false;
      }
    }else{
      Get.offAll(()=>Login());
    }
  }

  Future<bool> checkInWithDate(int state,DateTime dateTime)async{
    if(Global.employee !=null){
      loading.value = true;
      var location = await _determinePosition();
      if(location!=null){
        bool succ = await Api.checkIn(state, "https://www.google.com/maps/search/?api=1&query=${location.latitude},${location.longitude}",dateTime);
        if(succ){
          Global.state = state;
          loading.value = false;
          // App.succMsg("Successfully", "Thanks For Using Our Service");
          return true;
        }else{
          loading.value = false;
          return await checkInWithDate(state,dateTime);
          // App.errMsg("Failed", "Oops Please Try Again");
        }
      }else{
        loading.value = false;
        return await checkInWithDate(state,dateTime);
      }
    }else{
      Get.offAll(()=>Login());
      return false;
    }
  }


  getApplist()async{
    bottomSheetLoading.value = true;
    persons = await Api.getAppList();
    bottomSheetLoading.value = false;
  }
  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position?> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      loading.value = false;
      App.errMsg("Location", "Please Ture Location On");
      return null;
      // return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied||permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        loading.value = false;
        App.errMsg("Location", "Please Allow App To Access Location");
        return null;
        // return Future.error('Location permissions are denied');
      }
    }


    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}