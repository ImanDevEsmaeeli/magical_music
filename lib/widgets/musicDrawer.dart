import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:magical_music/routes/routes.dart';
import 'package:sidebarx/sidebarx.dart';
import 'dart:math' as math;

class MusicDrawer extends StatelessWidget {
  const MusicDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SidebarX(
      headerBuilder: (context, extended) {
        return CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 50,
          child: SvgPicture.asset(
            "assets/icons/cello.svg",
            colorFilter: const ColorFilter.srgbToLinearGamma(),
          ),
        );
      },
      footerDivider: const Divider(),
      footerBuilder: (context, extended) {
        return const Text("Magical Music v.1");
      },
      extendedTheme: SidebarXTheme(
        textStyle: const TextStyle(color: Colors.black87),
        hoverTextStyle: const TextStyle(color: Colors.black87),
        selectedTextStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
        selectedItemDecoration: BoxDecoration(
          color: Colors.blue,
          gradient: LinearGradient(
              colors: [Colors.green.shade200, Colors.teal.shade200]),
          borderRadius: BorderRadius.circular(7),
          border: Border.all(
            color: Colors.blue,
            width: 2,
          ),
        ),
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width * 0.3,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
              topLeft: Radius.circular(75),
              topRight: Radius.circular(75)),
          gradient: LinearGradient(
            transform: const GradientRotation(math.pi / 4),
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.blue,
              Colors.lightBlue,
              Colors.green,
              Colors.green.shade800,
            ],
          ),
        ),
      ),
      theme: const SidebarXTheme(
        //margin: EdgeInsets.all(10),
        //padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.lightBlue,
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25), topRight: Radius.circular(25)),
        ),
      ),
      controller: SidebarXController(selectedIndex: 0, extended: false),
      items: [
        SidebarXItem(
          label: "Home",
          iconWidget: SvgPicture.asset(
            "assets/icons/HomeOutline.svg",
            height: 30,
            colorFilter: const ColorFilter.srgbToLinearGamma(),
          ),
          onTap: () {},
        ),
        SidebarXItem(
          label: "Setting",
          iconWidget: SvgPicture.asset(
            "assets/icons/SettingOutline.svg",
            height: 30,
            colorFilter: const ColorFilter.srgbToLinearGamma(),
          ),
          onTap: () {
            Get.toNamed(Routes.setting);
          },
        ),
      ],
    );
  }
}
