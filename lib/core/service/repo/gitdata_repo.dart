import '../api_handler.dart';
import '../api_routes.dart';

class GitDataRepo {
  static Future getData({required int page}) async {
    final response = await API.apiHandler(
        showLoader: false,
        showToast: false,
        url: APIRoutes.fetchDataList + "?page=1&per_page=$page",
        requestType: RequestApiType.get);
    if (response != null) {
      return response;
    }
  }
}
