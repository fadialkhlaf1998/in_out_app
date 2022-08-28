import 'package:get/get.dart';
import 'package:in_out_app/helper/api.dart';
import 'package:geolocator/geolocator.dart';
import 'package:in_out_app/helper/app.dart';
import 'package:in_out_app/helper/global.dart';
import 'package:in_out_app/view/login.dart';


class CheckInController extends GetxController{
  var loading = false.obs;

  checkIn(int state)async{
    if(Global.employee !=null){
      loading.value = true;
      var location = await _determinePosition();
      if(location!=null){
        bool succ = await Api.checkIn(state, "https://www.google.com/maps/search/?api=1&query=${location.latitude},${location.longitude}");
        if(succ){
          Global.state = state;
          loading.value = false;
          App.succMsg("Successfully", "Thanks For Using Our Service");
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