import 'package:flutter/material.dart';
import 'package:wallsy/models/pexels_api.dart';
import 'package:wallsy/widgets/app_title.dart';
import 'package:wallsy/widgets/custom_search_bar.dart';
import 'package:wallsy/widgets/gridview_photos_builder.dart';

class SearchScreen extends StatefulWidget {
  final bool isCategory;
  final String searchString;

  const SearchScreen({
    Key key,
    this.isCategory = false,
    this.searchString,
  }) : super(key: key);
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  ScrollController _scrollController = ScrollController();
  TextEditingController _textController = TextEditingController();
  bool isLoading = false;
  bool isScrollLoading = false;

  void loadData() async {
    if (!isScrollLoading) {
      setState(() {
        isScrollLoading = true;
      });
      await PexelsData.updateImages();
      setState(() {
        isScrollLoading = false;
      });
    }
  }

  @override
  void initState() {
    if (widget.searchString != null) {
      setState(() {
        isLoading = true;
      });
      PexelsData.searchImages(widget.searchString, PexelsData.defaultSearchUrl)
          .then((value) => setState(() {
                isLoading = false;
              }));
    } else {
      PexelsData.searchPhotosData = [];
    }
    super.initState();
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
      appBar: widget.isCategory
          ? AppBar(
              centerTitle: true,
              elevation: 0.0,
              title: AppTitle(),
            )
          : null,
      body: SafeArea(
        child: Column(
          children: [
            if (!widget.isCategory)
              Container(
                height: 70,
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Expanded(
                      child: CustomSearchBar(
                        textController: _textController,
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });
                          await PexelsData.searchImages(_textController.text,
                              PexelsData.defaultSearchUrl);
                          setState(() {
                            isLoading = false;
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
            isLoading
                ? Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : PexelsData.searchPhotosData.length == 0
                    ? Expanded(
                        child: Center(
                          child: Text(
                            'No Search Results Found...',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      )
                    : GridViewPhotosBuilder(
                        scrollController: _scrollController,
                        itemCount: PexelsData.searchPhotosData.length,
                        data: PexelsData.searchPhotosData,
                        getPhoto: PexelsData.getSearchPhoto,
                      ),
            isScrollLoading ? CircularProgressIndicator() : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
