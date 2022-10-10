

import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:in_out_app/helper/api.dart';
import 'package:in_out_app/helper/global.dart';

class ProfileController extends GetxController{


  RxBool editImage = false.obs;
  final ImagePicker _picker = ImagePicker();
  RxList<File> imageList = <File>[].obs;
  RxBool existingPicture = false.obs;
  RxBool loading = false.obs;




  Future selectPhotoFromGallery() async {
    imageList.clear();
    existingPicture.value = false;
    _picker.pickImage(source: ImageSource.gallery).then((value){
      imageList.add(File(value!.path));
      if(imageList.isNotEmpty){
        existingPicture.value = true;
      }
    });
  }

  Future selectPhotoFromCamera() async {
    imageList.clear();
    existingPicture.value = false;
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    imageList.add(File(photo!.path));
    if(imageList.isNotEmpty){
      existingPicture.value = true;
    }
  }

  uploadImage() async {
    loading.value = true;
    Api.changeImage(imageList.first).then((value) async {
      loading.value = false;
      if(value){
        imageList.clear();
        editImage.value = false;
        Global.employee = await Api.login(Global.employee!.username, Global.employee!.password);
      }else{
        print('error');
      }
    });
  }

}