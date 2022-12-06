import 'package:flutter/material.dart';

class CustomCarouselSlider extends StatefulWidget {
  const CustomCarouselSlider(
      {Key? key,
      required this.itemCount,
      required this.items,
      this.selectedIndex = 0})
      : super(key: key);

  final int? selectedIndex;
  final int itemCount;
  final List<Widget> items;
  @override
  State<CustomCarouselSlider> createState() => _CustomCarouselSliderState();
}

class _CustomCarouselSliderState extends State<CustomCarouselSlider> {
  late int _selectedIndex;
  late PageController controller;

  @override
  void initState() {
    super.initState();
    setState(() => _selectedIndex = widget.selectedIndex!);
    controller = PageController(initialPage: _selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: PageView(
            controller: controller,
            children: widget.items,
            onPageChanged: (p) {
              setState(() => _selectedIndex = p);
            },
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 12,
          width: 40,
          child: ListView.builder(
              itemCount: 2,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Container(
                    height: 10,
                    width: 10,
                    margin: const EdgeInsets.only(left: 8, bottom: 8),
                    decoration: BoxDecoration(
                        color: index == _selectedIndex
                            ? Colors.white
                            : Colors.grey.withOpacity(.7),
                        borderRadius: BorderRadius.circular(55)),
                  )),
        )
      ],
    );
  }
}
