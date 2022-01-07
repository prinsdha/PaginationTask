import 'package:demotask/core/service/repo/gitdata_repo.dart';
import 'package:demotask/ui/home_screen/model/git_data_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class HomeController extends GetxController {
  int page = 0;
  int lastFetchLength = 0;
  //all fetched data store in list
  List<GitDataModel> fetchAllData = [];
  //for data is more or not
  late bool _hasNext;
  bool get hasNext => _hasNext;

  //show loader at bottom when data is fetching
  bool _isFetching = false;

  bool get isFetching => _isFetching;

  set isFetching(bool value) {
    _isFetching = value;
    update();
  }

  //isLoaderForFullScreen is show loader on FullScreen while api connect to server
  bool isLoaderForFullScreen = true;

  // fetchData used one time in initialize page
  Future fetchData() async {
    page = 0;
    isFetching = false;

    fetchAllData.clear();
    await fetchNextData();
  }

  // fetchNextData call while user scroll for more data it's pagination
  Future fetchNextData() async {
    lastFetchLength = fetchAllData.length;

    if (isFetching) return;
    isFetching = true;
    page += 15;
    final request = await GitDataRepo.getData(page: page);
    if (request != null) {
      fetchAllData =
          List<GitDataModel>.from(request.map((x) => GitDataModel.fromJson(x)));
      //store data to local through hive library
      Hive.box("gitData").put("data", request);
      // hasNext check data is has more ya not
      _hasNext = fetchAllData.length != lastFetchLength;
      isFetching = false;
    } else {
      // if request is null means user internet connection is off so, we fetch data from local and show them
      final data = Hive.box("gitData").get("data");
      if (data != null) {
        if (data.isNotEmpty) {
          fetchAllData = List<GitDataModel>.from(
              data.map((x) => GitDataModel.fromJson(x)));
          _hasNext = true;
        }
      }
    }
    isLoaderForFullScreen = false;

    update();
  }

  final scrollController = ScrollController();

  @override
  void onInit() {
    scrollController.addListener(scrollListener);
    fetchData();
    super.onInit();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void scrollListener() async {
    //through scroll controller manage pagination (it's Custom pagination not library used)
    if (scrollController.offset >=
            scrollController.position.maxScrollExtent / 2 &&
        !scrollController.position.outOfRange) {
      if (hasNext) {
        fetchNextData();
      }
    }
  }
}
