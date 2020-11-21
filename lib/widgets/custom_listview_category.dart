import 'package:flutter/material.dart';
import 'package:wallsy/models/pexels_api.dart';
import 'package:wallsy/screens/search_screen.dart';

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
