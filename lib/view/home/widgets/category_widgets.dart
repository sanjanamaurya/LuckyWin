import 'package:theluckywin/generated/assets.dart';
import 'package:theluckywin/main.dart';
import 'package:theluckywin/res/components/text_widget.dart';
import 'package:flutter/material.dart';

class CategoryWidget extends StatefulWidget {
  final Function(int) onCategorySelected;
  const CategoryWidget({super.key, required this.onCategorySelected});

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  late int selectedCatIndex;
  late int selectedCatIndextwo;
  @override
  void initState() {
    super.initState();
    selectedCatIndex = 0;
    selectedCatIndextwo = 0;
    height;
    width;
  }
  @override
  Widget build(BuildContext context) {
    List<CategoryModel> categoryList = [
      CategoryModel(
          title: 'Lottery', image: Assets.categoryLottery,subimage: Assets.categoryLotteryIcon),
      CategoryModel(
          title: 'Original', image: Assets.categoryFlash,subimage: Assets.categoryFlashIcon),
      CategoryModel(
          title: 'Dragon \n  Tiger', image: Assets.categoryChess,subimage: Assets.categoryDragontiger),
      CategoryModel(
          title: 'Popular', image: Assets.categoryPopula,subimage: Assets.categoryPopularIcon),
      CategoryModel(
          title: 'Sports', image: Assets.categorySport,subimage: Assets.categorySportIcon),
    ];

    return Column(
      children: [
        SizedBox(
          height: height*0.17,
          child: GridView.builder(
              shrinkWrap: true,
              itemCount: 2,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.6
              ),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedCatIndex = index;
                      widget.onCategorySelected(selectedCatIndex);
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage('${categoryList[index].image}'),fit: BoxFit.fill)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: height*0.12,
                          width: width*0.2,
                          decoration: BoxDecoration(
                              image: DecorationImage(image: AssetImage('${categoryList[index].subimage}',),fit: BoxFit.fill)
                          ),
                        ),
                        textWidget(
                          text: categoryList[index].title,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: selectedCatIndex == index
                              ? Colors.black// Change text color if selected
                              : Colors.white,
                        ),
                        const SizedBox(width: 10,)
                      ],
                    ),
                  ),
                );
              }),
        ),

        SizedBox(
          height: height*0.12,

          child: GridView.builder(
              shrinkWrap: true,
              itemCount: categoryList.length-2,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.5
              ),
              itemBuilder: (context, index) {
                final adjustedIndex = index + 2;

                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedCatIndex = adjustedIndex;
                      widget.onCategorySelected(selectedCatIndex);
                      print(selectedCatIndex);
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage('${categoryList[adjustedIndex].image}'),fit: BoxFit.fill)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: height*0.08,
                          width: width*0.17,
                          decoration: BoxDecoration(
                              image: DecorationImage(image: AssetImage('${categoryList[adjustedIndex].subimage}',),fit: BoxFit.fill)
                          ),
                        ),
                        textWidget(
                          text: categoryList[adjustedIndex].title,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: selectedCatIndex == adjustedIndex
                              ? Colors.black// Change text color if selected
                              : Colors.white,
                        ),
                        const SizedBox(width: 10,),
                      ],
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }
}

class CategoryModel {
  final String title;
  final String? image;
  final String? subimage;
  CategoryModel({required this.title, this.image,this.subimage});
}


