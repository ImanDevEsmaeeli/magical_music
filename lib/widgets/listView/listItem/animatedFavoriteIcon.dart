import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/default_transitions.dart';
import 'package:like_button/like_button.dart';
import 'package:magical_music/stateManagement/controllers/musics/musicControllers.dart';
import 'package:magical_music/stateManagement/models/music.dart';

// class AnimatedFavoriteIcon extends StatefulWidget {
//   AnimatedFavoriteIcon({
//     super.key,
//     required this.music,
//   });

//   Music music;

//   @override
//   State<AnimatedFavoriteIcon> createState() => _AnimatedFavoriteIconState();
// }

// class _AnimatedFavoriteIconState extends State<AnimatedFavoriteIcon>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;

//   @override
//   void initState() {
//     super.initState();
//     _controller =
//         AnimationController(vsync: this, duration: const Duration(seconds: 2));
//     _animation = Tween<double>(begin: 0, end: 1).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
//     );

//     if (widget.music.isFavorite) {
//       _controller.reset();
//       _controller.forward();
//     } else {
//       _controller.reverse();
//     }
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   // _startanimation() {
//   //   if (sdf) {
//   //     _controller.reset();
//   //     _controller.forward();
//   //   } else {
//   //     _controller.reverse();
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         const Center(
//           child: Icon(
//             Icons.favorite_outline_rounded,
//             color: Colors.red,
//           ),
//         ),
//         Center(
//           child: ScaleTransition(
//             scale: _animation,
//             child: const Icon(
//               Icons.favorite_rounded,
//               color: Colors.red,
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }

// class AnimatedFavoriteIcon extends StatelessWidget {
//   AnimatedFavoriteIcon({super.key, required this.isfavorite});

//   bool isfavorite;

//   @override
//   Widget build(BuildContext context) {
//     return LikeButton(
//       isLiked: isfavorite,
//       likeBuilder: (isLiked) {
//         return Icon(
//           Icons.favorite_rounded,
//           color: isfavorite ? Colors.red : Colors.grey,
//         );
//       },
//       //onTap: func,
//     );
//   }
// }

class AnimatedFavoriteIconController extends GetxController
    with GetTickerProviderStateMixin {
  late AnimationController anim;
  late Animation<double> animation;
  @override
  void onInit() {
    initAnimation();
    anim.forward();
    super.onInit();
  }

  void initAnimation() {
    anim = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    animation = Tween<double>(begin: 0, end: 25).animate(
      CurvedAnimation(
        parent: anim,
        curve: Curves.elasticOut,
      ),
    )..addListener(() {
        update();
      });
  }

  @override
  void dispose() {
    anim.dispose();
    super.dispose();
  }
}

class AnimatedFavoriteIcon extends StatelessWidget {
  AnimatedFavoriteIcon({super.key, required this.isFavorite}) {}
  bool isFavorite;
  //Music music;
  // MusicControllers musicControler = ;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AnimatedFavoriteIconController>(
      init: AnimatedFavoriteIconController(),
      initState: (state) {
        if (isFavorite) {
          state.controller?.anim.forward();
        } else {
          state.controller?.anim.reverse();
        }
      },
      builder: (controller) {
        return Icon(
          Icons.favorite,
          size: controller.animation.value,
          color: Colors.red,
        );
      },
    );
  }
}
