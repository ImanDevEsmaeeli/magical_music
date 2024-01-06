import 'package:flutter/material.dart';

class AnimatedSliderButton extends StatefulWidget {
  AnimatedSliderButton({
    super.key,
    required this.addFunc,
    required this.editFunc,
    required this.deleteFunc,
  }) {}

  final void Function()? addFunc;
  final void Function()? editFunc;
  final void Function()? deleteFunc;

  @override
  State<AnimatedSliderButton> createState() => _AnimatedSliderButtonState();
}

class _AnimatedSliderButtonState extends State<AnimatedSliderButton>
    with SingleTickerProviderStateMixin {
  GlobalKey key = GlobalKey();
  bool isvisible = false;
  List<Icon> iconList = [
    const Icon(
      Icons.add_circle,
      size: 30,
      color: Colors.green,
    ),
    const Icon(Icons.edit, color: Colors.yellow),
    const Icon(Icons.delete, color: Colors.red),
  ];

  List<Function()?> functionList = [];

  late AnimationController controller;
  late Animation<double> animation;

  // double widthlist = 0;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);

    functionList.add(widget.addFunc);
    functionList.add(widget.editFunc);
    functionList.add(widget.deleteFunc);
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Card(
        color: Colors.blue,
        shape: const StadiumBorder(),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  isvisible = !isvisible;
                  if (isvisible) {
                    controller.forward();
                  } else {
                    controller.reverse();
                  }
                });
              },
              icon: AnimatedIcon(
                  icon: AnimatedIcons.menu_close, progress: animation),

              //Icon(Icons.list),
            ),
            TweenAnimationBuilder(
              duration: const Duration(milliseconds: 600),
              tween: isvisible
                  ? Tween<double>(begin: 0, end: 150)
                  : Tween<double>(begin: 150, end: 0),
              builder: (context, value, child) => SizedBox(
                width: value,
                height: 50,
                child: ListView.builder(
                  key: key,
                  scrollDirection: Axis.horizontal,
                  itemCount: iconList.length,
                  itemBuilder: (context, index) => IconButton(
                    onPressed: functionList[index],
                    icon: iconList[index],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
