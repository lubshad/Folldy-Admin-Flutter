import 'package:basic_template/basic_template.dart';
import 'package:flutter/cupertino.dart';
import 'package:folldy_utils/data/core/api_constants.dart';
import 'package:folldy_admin/utils/extensions.dart';
import 'package:folldy_utils/data/models/area_list_response.dart';
import 'package:folldy_utils/domain/usecase/add_new_area.dart';

class AddEditAreaController extends ChangeNotifier {
  final Area? area;
  AddEditAreaController({this.area, required this.getAreas}) {
    if (area != null) {
      areaNameController.text = area!.name;
    }
  }

  AddNewArea addNewArea = AddNewArea(Get.find());

  final VoidCallback getAreas;

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

  void addEditArea({Area? area}) async {
    if (!validate()) return;
    List<MultipartFile> images = pickedImage == null
        ? []
        : [
            MultipartFile("image", getFileStream(pickedImage!.bytes!),
                pickedImage!.bytes!.length,
                filename: pickedImage!.name,
                contentType: MediaType("image", "jpeg"))
          ];
    Map<String, dynamic> metadata = {"name": areaNameController.text};
    if (area != null) {
      metadata["id"] = area.id;
    }
    UploadFileParams uploadFileParams =
        UploadFileParams(metadata, images, ApiConstants.addNewArea);
    final response = await addNewArea(uploadFileParams);
    if (Get.isDialogOpen == true) Get.back();
    response.fold((l) => l.handleError(), (r) => getAreas());
  }

  void pickImage() async {
    final image = await FilePicker.platform
        .pickFiles(allowMultiple: false, type: FileType.image);
    if (image == null || image.files.isEmpty) return;
    pickedImage = image.files.first;
    notifyListeners();
  }
}
