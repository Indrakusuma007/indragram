import 'package:get/get.dart';
import 'package:indragram/model/model.data_content.dart';
import 'package:indragram/my_widget/my_widget.snackbar.dart';
import 'package:indragram/services/service.data_content.dart';

class HomeController extends GetxController {
  final ServiceDataContent serviceDataContent = ServiceDataContent();
  final RxBool loading = false.obs;
  final Rx<List<ModelDataContent>> dataContent = Rx([]);

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    getData();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future getData() async {
    try {
      if (loading.value) return;
      loading.value = true;
      final result = await serviceDataContent.getData();
      if (result.isEmpty) throw 'Data masih kosong';
      dataContent.value = result;
    } catch (e) {
      print(e.toString());
      MyWidgetSnackbar.myTemplateSnackBarError(message: e.toString(), title: 'Peringatan!!');
    }

    loading.value = false;
  }
}
