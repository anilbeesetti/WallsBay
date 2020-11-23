import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallsy/helpers/pexels_api.dart';
import 'package:wallsy/models/pexels_data.dart';
import 'package:wallsy/screens/search_screen.dart';
import 'package:wallsy/widgets/app_title.dart';
import 'package:wallsy/widgets/custom_listview_category.dart';
import 'package:wallsy/widgets/gridview_photos_builder.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var isLoading = false;
  var isScrollLoading = false;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    setState(() {
      isLoading = true;
    });
    PexelsApi.getHomeImages(PexelsApi.homeUrl).then((value) => setState(() {
          isLoading = false;
        }));

    super.initState();
  }

  void loadData() async {
    if (!isScrollLoading) {
      setState(() {
        isScrollLoading = true;
      });
      await PexelsApi.updataHomeImges(PexelsApi.homeUrl);

      setState(() {
        isScrollLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.position.pixels) {
        loadData();
      }
    });

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: AppTitle(),
        actions: [
          IconButton(
            splashRadius: 28,
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => SearchScreen(),
                  ));
            },
          )
        ],
      ),
      body: Column(
        children: [
          Container(
              height: 90,
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                scrollDirection: Axis.horizontal,
                itemCount: PexelsData.categoryList.length,
                itemBuilder: (context, index) => CustomListViewCategory(
                  index: index,
                ),
              )),
          isLoading
              ? Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : GridViewPhotosBuilder(
                  scrollController: _scrollController,
                  itemCount: PexelsData.pexelsPhotosData.length,
                  data: PexelsData.pexelsPhotosData,
                  getPhoto: PexelsApi.getHomePhoto,
                ),
          isScrollLoading ? CircularProgressIndicator() : SizedBox.shrink(),
        ],
      ),
    );
  }
}
