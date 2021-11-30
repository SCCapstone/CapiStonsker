// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
//
// class Filters extends StatefulWidget {
//
//   @override
//   _FiltersState createState() => _FiltersState();
// }
//
// class _FiltersState extends State<Filters> {
//   TutorialCoachMark tutorialCoachMark;
//
//   List<TargetFocus> targets = List();
//
//   GlobalKey keyButton = GlobalKey();
//   GlobalKey keyButton1 = GlobalKey();
//   GlobalKey keyButton2 = GlobalKey();
//   GlobalKey keyButton3 = GlobalKey();
//   GlobalKey keyButton4 = GlobalKey();
//
//   @override
//   Widget build(BuildContext context) {
//     return ViewModelBuilder<FilterViewModel>.reactive(
//         viewModelBuilder: () => FilterViewModel(),
//         builder: (context, model, _) => SafeArea(
//             child: Scaffold(
//               appBar: AppBar(
//                 title: "Filters".text.black.make(),
//                 actions: <Widget>[
//                   FlatButton(onPressed: (){}, child: "Done".text.bold.make())
//                 ],
//               ),
//               body: ListView(
//                 physics: BouncingScrollPhysics(),
//                 shrinkWrap: true,
//                 padding: EdgeInsets.all(8),
//                 children: <Widget>[
//                   8.heightBox,
//                   "Services".text.bold.size(18).make(),
//                   8.heightBox,
//                   Wrap(
//                     key: keyButton,
//                     direction: Axis.horizontal,
//                     spacing: 8,
//                     children: List.generate(
//                         model.serviceFilters.length,
//                             (index) => FilterChip(
//                           label: Text(model.serviceFilters[index], style: model.serviceFilterIndex != index ? null : TextStyle(color: Vx.white, fontWeight: FontWeight.bold)),
//                           selected: model.serviceFilterIndex == index,
//                           onSelected: (isSelected) => model.onServiceFilterSelected(isSelected, index),
//                         )
//                     ).toList(),
//                   ),
//                   16.heightBox,
//                   "Rating".text.bold.size(18).make(),
//                   8.heightBox,
//                   Row(
//                     key: keyButton1,
//                     children: <Widget>[
//                       SmoothStarRating(
//                         rating: model.rating ?? 0,
//                         allowHalfRating: true,
//                         color: AppColors.ratingColor,
//                         size: 30,
//                         onRated: model.onRatingChanged,
//                         borderColor: Colors.grey[400],
//                         defaultIconData: Icons.star,
//                       ),
//                       32.widthBox,
//                       "${model.rating ?? 0} Star".text.gray500.bold.make()
//                     ],
//                   ),
//                   16.heightBox,
//                   "Gender".text.bold.size(18).make(),
//                   8.heightBox,
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       GestureDetector(
//                         onTap: () => model.onGenderChanged(0),
//                         child: Row(
//                           children: <Widget>[
//                             Radio(
//                                 key: keyButton2,
//                                 value: 0,
//                                 activeColor: AppColors.linkColor,
//                                 groupValue: model.gender,
//                                 onChanged: model.onGenderChanged
//                             ),
//                             "Man".text.bold.make()
//                           ],
//                         ),
//                       ),
//                       GestureDetector(
//                         onTap: () => model.onGenderChanged(1),
//                         child: Row(
//                           children: <Widget>[
//                             Radio(
//                                 value: 1,
//                                 activeColor: AppColors.linkColor,
//                                 groupValue: model.gender,
//                                 onChanged: model.onGenderChanged
//                             ),
//                             "Woman".text.bold.make()
//                           ],
//                         ),
//                       ),
//                       GestureDetector(
//                         onTap: () => model.onGenderChanged(2),
//                         child: Row(
//                           children: <Widget>[
//                             Radio(
//                                 value: 2,
//                                 activeColor: AppColors.linkColor,
//                                 groupValue: model.gender,
//                                 onChanged: model.onGenderChanged
//                             ),
//                             "Other".text.bold.make()
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                   16.heightBox,
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       "Distance".text.size(18).bold.make(),
//                       "${model.distance.end} km".text.gray500.bold.make()
//                     ],
//                   ),
//                   8.heightBox,
//                   RangeSlider(
//                     key: keyButton3,
//                     values: model.distance,
//                     onChanged: model.onDistanceChanged,
//                     activeColor: AppColors.linkColor,
//                     min: 0,
//                     max: 10,
//                     divisions: 10,
//                     inactiveColor: Colors.grey,
//                     labels: RangeLabels("${model.distance.start} km", "${model.distance.end} km"),
//                   ),
//                   16.heightBox,
//                   "Sort By".text.size(18).bold.make(),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: List.generate(model.sortByFilters.length,
//                             (index) => ListTile(
//                           onTap: () => model.onSortByChanged(index),
//                           title: Text(model.sortByFilters[index], style: model.sortByFilterIndex == index ? TextStyle(color: AppColors.linkColor) : null),
//                           trailing: model.sortByFilterIndex == index ? Icon(LineIcons.check_solid, color: AppColors.linkColor): null,
//                         )
//                     ).toList(),
//                   ),
//                   "Price".text.size(18).bold.make(),
//                   Row(
//                     key: keyButton4,
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: List.generate(3,
//                             (index) => FilterChip(
//                           label: Row(
//                               children: List.generate(index + 1, (iconIndex) => Icon(LineIcons.dollar_sign_solid, color: model.priceFilterIndex != index ? null : Vx.white))
//                           ),
//                           selected: model.priceFilterIndex == index,
//                           onSelected: (isSelected) => model.onPriceFilterSelected(isSelected, index),
//                         )
//                     ).toList(),
//                   )
//                 ],
//               ),
//             )
//         )
//     );
//   }
//
//   @override
//   void initState() {
//     initTargets();
//     WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
//     super.initState();
//   }
//
//   void showTutorial() {
//     tutorialCoachMark = TutorialCoachMark(context,
//         targets: targets,
//         colorShadow: Colors.black,
//         textSkip: "SKIP",
//         paddingFocus: 10,
//         opacityShadow: 0.8, onFinish: () {
//           print("finish");
//         }, onClickTarget: (target) {
//           print(target);
//         }, onClickSkip: () {
//           print("skip");
//         }
//     )..show();
//   }
//
//   void _afterLayout(_) {
//     Future.delayed(Duration(milliseconds: 100), () {
//       showTutorial();
//     });
//   }
//
//   void initTargets() {
//     targets.add(
//         TargetFocus(
//             identify: "Target 1",
//             keyTarget: keyButton,
//             shape: ShapeLightFocus.Circle,
//             contents: [
//               ContentTarget(
//                   align: AlignContent.bottom,
//                   child: Column(
//                     children: <Widget>[
//                       "Services".text.size(20).white.make(),
//                       16.heightBox,
//                       "Select service type to filter saloon".text.white.make()
//                     ],
//                   )
//               )
//             ]
//         )
//     );
//     targets.add(
//         TargetFocus(
//             identify: "Target 2",
//             keyTarget: keyButton1,
//             shape: ShapeLightFocus.RRect,
//             contents: [
//               ContentTarget(
//                   align: AlignContent.bottom,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Icon(Icons.star, color: AppColors.ratingColor, size: 30),
//                       8.heightBox,
//                       "Rating".text.size(20).white.make(),
//                       16.heightBox,
//                       "Tap and drag to set rating filter".text.white.make()
//                     ],
//                   )
//               )
//             ]
//         )
//     );
//     targets.add(
//         TargetFocus(
//             identify: "Target 3",
//             keyTarget: keyButton2,
//             shape: ShapeLightFocus.Circle,
//             contents: [
//               ContentTarget(
//                   align: AlignContent.right,
//                   child: Column(
//                     children: <Widget>[
//                       Icon(LineIcons.user_alt_solid, color: AppColors.linkColor, size: 50),
//                       8.heightBox,
//                       "Gender".text.size(20).white.make(),
//                       16.heightBox,
//                       "Select gender to filter salon".text.white.make()
//                     ],
//                   )
//               )
//             ]
//         )
//     );
//     targets.add(
//         TargetFocus(
//             identify: "Target 4",
//             keyTarget: keyButton3,
//             shape: ShapeLightFocus.RRect,
//             contents: [
//               ContentTarget(
//                   align: AlignContent.top,
//                   child: Column(
//                     children: <Widget>[
//                       Icon(LineIcons.map_marker_alt_solid, color: AppColors.linkColor, size: 30),
//                       8.heightBox,
//                       "Distance".text.size(20).white.make(),
//                       16.heightBox,
//                       "Set minimum distance to filter salon nearby".text.white.make()
//                     ],
//                   )
//               ),
//               ContentTarget(
//                   align: AlignContent.bottom,
//                   child: Column(
//                     children: <Widget>[
//                       "Set Maximum distance to filter salon nearby".text.white.make()
//                     ],
//                   )
//               )
//             ]
//         )
//     );
//     targets.add(
//         TargetFocus(
//             identify: "Target 5",
//             keyTarget: keyButton4,
//             shape: ShapeLightFocus.RRect,
//             contents: [
//               ContentTarget(
//                   align: AlignContent.top,
//                   child: Column(
//                     children: <Widget>[
//                       Icon(LineIcons.dollar_sign_solid, color: AppColors.linkColor, size: 30),
//                       8.heightBox,
//                       "Price".text.size(20).white.make(),
//                       16.heightBox,
//                       "Select Price low, medium or high filter for salon".text.white.make()
//                     ],
//                   )
//               )
//             ]
//         )
//     );
//   }
//
// }