import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_flutter/views/utils/ImageUtils.dart';
import '../../controller/SearchController.dart';
import '../routes/AppRoutes.dart';

class SearchPage extends StatefulWidget {
  SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final SearchPageController controller = Get.put(SearchPageController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    controller.fetchLatestPlaylists();
    return Scaffold(
      body: SafeArea(
        child: GetBuilder(
          builder: (SearchPageController controller) {
            return Column(
              children: [
                // Search header
                Container(
                  height: h * 0.2,
                  width: double.infinity,
                  padding: EdgeInsets.all(h * 0.01),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        ImageUtils.ImagePath + ImageUtils.SearchHeader,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Search",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: h * 0.026,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: h * 0.02,
                ),

                // Search box
                Container(
                  height: h * 0.06,
                  width: double.infinity,
                  margin: EdgeInsets.only(
                    left: h * 0.02,
                    right: h * 0.02,
                  ),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        offset: Offset(0, 0),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(h * 0.03),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: h * 0.02),
                        child: Icon(
                          Icons.search,
                          color: Colors.black.withOpacity(0.6),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: controller.searchController,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            hintText: "Search Above Flutter",
                            hintStyle: TextStyle(
                              color: Colors.black.withOpacity(0.6),
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: h * 0.02,
                              vertical: h * 0.012,
                            ),
                          ),
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.8),
                          ),
                          cursorColor: Colors.black.withOpacity(0.6),
                          onSubmitted: (value) => controller.search(), // Trigger search on submission
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: h * 0.02,
                ),

                // Display search results or latest playlists
                Obx(() {
                  if (controller.latestPlayListIsLoading.value) {
                    return CircularProgressIndicator();
                  }
                  if (controller.searchModel?.data == null ||
                      controller.searchModel!.data.isEmpty) {
                    return Flexible(
                      flex: 8,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: h * 0.02,
                            right: h * 0.02,
                            bottom: h * 0.02,
                          ),
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: controller.latestPlayListModel!.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              var item = controller.latestPlayListModel!.data[index];
                              return GestureDetector(
                                onTap: () {
                                  Get.toNamed(AppRoutes.VIDEODETAILPAGE);
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                    bottom: h * 0.02,
                                  ),
                                  height: h * 0.28,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(h * 0.01),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.25),
                                        offset: Offset(0, 0),
                                        blurRadius: 10,
                                        spreadRadius: 2,
                                      ),
                                    ],
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        "https://customize.hkdigiverse.com/hrcodeexpert/storage/app/public/${item.thumbnail}",
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Container(
                                      height: h * 0.08,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(h * 0.01),
                                      ),
                                      padding: EdgeInsets.symmetric(horizontal: h * 0.01),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              item.title,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: h * 0.02,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                              Icons.favorite_border,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  }

                  return Flexible(
                    flex: 8,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: h * 0.02,
                          right: h * 0.02,
                          bottom: h * 0.02,
                        ),
                        child: controller.searchModel!.data.isEmpty
                            ? Center(child: Text("No results found"))
                            : ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.searchModel!.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            var item = controller.searchModel!.data[index];
                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed(AppRoutes.VIDEODETAILPAGE);
                                  },
                                  child: Container(
                                    height: h * 0.28,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(h * 0.01),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.25),
                                          offset: Offset(0, 0),
                                          blurRadius: 10,
                                          spreadRadius: 2,
                                        ),
                                      ],
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          "https://customize.hkdigiverse.com/hrcodeexpert/storage/app/public/${item.thumbnail}",
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Container(
                                        height: h * 0.08,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(h * 0.01),
                                        ),
                                        padding: EdgeInsets.symmetric(horizontal: h * 0.01),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                item.title,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: h * 0.02,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                Icons.favorite_border,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: h * 0.02),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  );
                })
              ],
            );
          },
        ),
      ),
    );
  }
}
