import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:image_bay/models/main_screen_model.dart';
import 'package:image_bay/screens/image_detail_screen.dart';
import 'package:image_bay/screens/widgets/category_button.dart';
import 'package:image_bay/screens/widgets/photo_container.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lightBlue[50],
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: SizedBox(
                  height: 50.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: context
                        .select((MainScreenModel m) => m.categories.length),
                    itemBuilder: (context, index) => Container(
                        margin: EdgeInsets.all(8.0),
                        child: CategoryButton(
                          isSelected: context
                                  .watch<MainScreenModel>()
                                  .selectedCategoryIndex ==
                              index,
                          selectedColor: _buildRandomColor(),
                          categoryLabel:
                              context.read<MainScreenModel>().categories[index],
                          onTap: () => context
                              .read<MainScreenModel>()
                              .selectedCategoryIndex = index,
                        )),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 5.0,
                      right: 5.0,
                      bottom: 5.0,
                    ),
                    child: StaggeredGridView.countBuilder(
                      physics: ScrollPhysics(),
                      key: ObjectKey(4),
                      crossAxisCount: 4,
                      itemCount: context.select((MainScreenModel m) =>
                          m.currentCategoryImage.images.length),
                      itemBuilder: (BuildContext context, int index) {
                        var m = context.read<MainScreenModel>();
                        var img = m.currentCategoryImage.images[index];

                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              CupertinoPageRoute(
                                builder: (context) =>
                                    ImageDetailScreen(pixImage: img),
                              ),
                            );
                          },
                          child: Hero(
                            tag: img.id,
                            child: PhotoContainer(
                              img: img,
                              backgroundColor: _buildRandomColor(),
                            ),
                          ),
                        );
                      },
                      staggeredTileBuilder: (int index) {
                        return StaggeredTile.count(2, index.isEven ? 2 : 1);
                      },
                      mainAxisSpacing: 6.0,
                      crossAxisSpacing: 6.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  MaterialAccentColor _buildRandomColor() {
    return Colors.accents[
        Random(DateTime.now().millisecond).nextInt(Colors.accents.length)];
  }
}
