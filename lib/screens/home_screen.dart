import 'package:flutter/material.dart';
import 'package:wallsy/models/pexels_api.dart';
import 'package:wallsy/screens/search_screen.dart';
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
    PexelsData.getImages(PexelsData.homeUrl).then((value) => setState(() {
          isLoading = false;
        }));

    super.initState();
  }

  void loadData() async {
    if (!isScrollLoading) {
      setState(() {
        isScrollLoading = true;
      });
      await PexelsData.getImages(PexelsData.homeUrl);
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
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
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
                  getPhoto: PexelsData.getHomePhoto,
                ),
          isScrollLoading ? CircularProgressIndicator() : SizedBox.shrink(),
        ],
      ),
    );
  }
}

class CustomListViewCategory extends StatelessWidget {
  final int index;
  const CustomListViewCategory({
    Key key,
    @required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return SearchScreen(
              isCategory: true,
              searchString: PexelsData.categoryList[index].categoryName,
            );
          },
        ));
      },
      child: Container(
        margin: EdgeInsets.only(right: 10),
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                PexelsData.categoryList[index].categoryImageUrl,
                fit: BoxFit.cover,
                width: 110,
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: 110,
              decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.circular(10)),
              child: Text(
                PexelsData.categoryList[index].categoryName,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.white70),
              ),
            )
          ],
        ),
      ),
    );
  }
}
