import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:magical_music/stateManagement/bindings/musicIds.dart';
import 'package:magical_music/stateManagement/controllers/musics/musicControllers.dart';
import 'package:magical_music/stateManagement/models/music.dart';
import 'package:delayed_tween_animation_builder/delayed_tween_animation_builder.dart';

class AnimatedFavoriteIcon extends StatelessWidget {
  AnimatedFavoriteIcon({super.key, required this.music});
  final Music music;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Get.find<MusicControllers>().favorite(music);
      },
      icon: GetBuilder<MusicControllers>(
        id: MusicIds.favorite,
        builder: (ctrl) {
          return Stack(
            alignment: Alignment.center,
            children: [
              DelayedTweenAnimationBuilder(
                delay: music.isFavorite
                    ? Duration(milliseconds: 300)
                    : Duration(seconds: 0),
                delayOnlyOnce: false,
                curve: music.isFavorite ? Curves.elasticOut : Curves.linear,
                tween: music.isFavorite
                    ? Tween<double>(begin: 0, end: 25)
                    : Tween<double>(begin: 25, end: 0),
                duration: music.isFavorite
                    ? Duration(milliseconds: 800)
                    : Duration(milliseconds: 300),
                builder: (context, sizeValue, _) => Icon(
                  Icons.favorite,
                  size: sizeValue,
                  color: Colors.red,
                ),
              ),
              DelayedTweenAnimationBuilder(
                delayOnlyOnce: false,
                delay: music.isFavorite
                    ? Duration(seconds: 0)
                    : Duration(milliseconds: 300),
                curve: Curves.linear,
                tween: music.isFavorite
                    ? Tween<double>(begin: 25, end: 0)
                    : Tween<double>(begin: 0, end: 25),
                duration: Duration(milliseconds: 300),
                builder: (context, sizeValue, _) => Icon(
                  Icons.favorite,
                  size: sizeValue,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
