
import 'package:get/get.dart';
import 'package:task_trial/services/project_services.dart';
class ProjectController extends GetxController {
  var isLoading = false.obs;
  Future<void> updateProjectData({
    required String teamId,
    required String projectId,
    required Map<String, dynamic> data,
  }) async {
   ProjectServices.updateProjectData(teamId: teamId, projectId: projectId, data: data, isLoading: isLoading);
  }
  Future<void> deleteProjectData({required String teamId,
    required String projectId,})async{
    ProjectServices.deleteProjectData(teamId: teamId, projectId: projectId);
  }

}
