import 'package:get/get.dart';
import 'package:red_zone/features/personalization/models/user_model.dart';
import 'package:red_zone/utils/constants/loaders.dart';
import '../../../../data/repositories/admin_panel/all_registred_user/all_registered_user_repository.dart';

class RegisteredUsersController extends GetxController {
  static RegisteredUsersController get instance => Get.find();

  final isLoading = false.obs;
  final AllRegisteredUserRepository userRepository = Get.put(AllRegisteredUserRepository());
  final RxList<UserModel> userList = <UserModel>[].obs;

  @override
  void onInit() {
    fetchUserList();
    super.onInit();
  }

  Future<void> fetchUserList() async {
    try {
      isLoading.value = true;
      final List<UserModel> users = await userRepository.getUserList();
      userList.assignAll(users);
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap', message: 'Something went wrong! Please try again!(controller)');
      print('Error fetching user list: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteUser(String userId) async {
    try {
      isLoading.value = true;
      await userRepository.deleteUser(userId);
      userList.removeWhere((user) => user.id == userId);
      TLoaders.successSnackBar(title: 'Success', message: 'User deleted successfully');
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap', message: 'Failed to delete user. Please try again!');
      print('Error deleting user: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
