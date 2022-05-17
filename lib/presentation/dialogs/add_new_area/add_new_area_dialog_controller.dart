import 'package:basic_template/basic_template.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:folldy_admin/data/core/api_constants.dart';
import 'package:folldy_admin/presentation/screens/areas_listing/areas_listing_controller.dart';
import 'package:folldy_admin/utils/extensions.dart';
import 'package:http_parser/http_parser.dart';

import '../../../domain/usecase/add_new_area.dart';

class AddNewAreaController extends ChangeNotifier {
  AddNewArea addNewArea = AddNewArea(Get.find());
  AreasListingController areasListingController = Get.find();

  TextEditingController areaNameController = TextEditingController();

  bool buttonLoading = false;

  PlatformFile? pickedImage;
  makeButtonLoading() {
    buttonLoading = true;
    notifyListeners();
  }

  makeButtonNotLoading() {
    buttonLoading = false;
    notifyListeners();
  }

  final formKey = GlobalKey<FormState>(debugLabel: 'add_area_form_key');
  bool validate() {
    bool valid = false;
    if (formKey.currentState!.validate()) {
      valid = true;
    }
    return valid;
  }

  void addArea() async {
    if (!validate()) return;
    List<MultipartFile> images = pickedImage == null
        ? []
        : [
            MultipartFile("image", getFileStream(pickedImage!.bytes!),
                pickedImage!.bytes!.length,
                filename: pickedImage!.name,
                contentType: MediaType("image", "jpeg"))
          ];
    UploadFileParams uploadFileParams = UploadFileParams(
        {"name": areaNameController.text}, images, ApiConstants.addNewArea);
    final response = await addNewArea(uploadFileParams);
    if (Get.isDialogOpen == true) Get.back();
    response.fold(
        (l) => l.handleError(), (r) => areasListingController.getData());
  }

  void pickImage() async {
    final image = await FilePicker.platform
        .pickFiles(allowMultiple: false, type: FileType.image);
    if (image == null || image.files.isEmpty) return;
    pickedImage = image.files.first;
    notifyListeners();
  }
}
