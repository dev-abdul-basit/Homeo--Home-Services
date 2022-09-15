import 'package:flutter/material.dart';

class WorkImagesGridView extends StatefulWidget {
  const WorkImagesGridView({Key? key}) : super(key: key);

  @override
  State<WorkImagesGridView> createState() => _WorkImagesGridViewState();
}

class _WorkImagesGridViewState extends State<WorkImagesGridView> {
  final List<String> _listImages = [
    "assets/images/cleaner_2.png",
    // "assets/images/cleaner_2.png",
    // "assets/images/cleaner_2.png",
    // "assets/images/cleaner_2.png",
    // "assets/images/cleaner_2.png",
  ];
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 12, right: 12),
      child: GridView.builder(
          controller: _controller,
          itemCount: _listImages.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          padding: const EdgeInsets.all(8.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1.0,
            crossAxisSpacing: 5.0,
            mainAxisSpacing: 5.0,
          ),
          itemBuilder: (BuildContext context, int index) {
            return Card(
              color: Colors.white,
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              child: InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Image.asset(_listImages[index], fit: BoxFit.fill),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
