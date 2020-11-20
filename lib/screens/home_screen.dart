import 'package:flutter/material.dart';
import 'package:wallsy/models/pexels_api.dart';
import 'package:wallsy/widgets/image_tile.dart';

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
    PexelsData.getImages(PexelsData.url).then((value) => setState(() {
          isLoading = false;
        }));

    super.initState();
  }

  void loadData() async {
    if (!isScrollLoading) {
      setState(() {
        isScrollLoading = true;
      });
      print(PexelsData.url);
      await PexelsData.getImages(PexelsData.url);
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
        title: RichText(
          text: TextSpan(
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
            children: [
              TextSpan(
                text: 'Wall',
                style: TextStyle(color: Colors.black87),
              ),
              TextSpan(
                text: 'Sy',
                style: TextStyle(color: Colors.blue),
              ),
            ],
          ),
        ),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    controller: _scrollController,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    itemCount: PexelsData.pexelsPhotosData.length == 0
                        ? 0
                        : PexelsData.pexelsPhotosData.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.6,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                    ),
                    itemBuilder: (context, index) {
                      return ImageTile(
                          imgUrlPortrait:
                              PexelsData.pexelsPhotosData[index].image.portrait,
                          key: ValueKey(
                              PexelsData.pexelsPhotosData[index].imageId),
                          imgUrl:
                              PexelsData.pexelsPhotosData[index].image.large);
                    },
                  ),
                ),
                isScrollLoading
                    ? CircularProgressIndicator()
                    : SizedBox.shrink(),
              ],
            ),
    );
  }
}
