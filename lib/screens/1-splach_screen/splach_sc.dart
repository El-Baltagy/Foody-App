import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import '../../shared/components.dart';
import '../3-layout/layout.dart';

// class SplashSc extends StatefulWidget {
//   SplashSc() : super();
//
//   @override
//   SplashScState createState() => SplashScState();
// }
//
// class SplashScState extends State<SplashSc> {
//   //
//   late VideoPlayerController _controller;
//   late Future<void> _initializeVideoPlayerFuture;
//   Timer? _timer;
//
//   _startDelay() {
//     _timer = Timer(const Duration(seconds: 5,milliseconds: 200), _goNext);
//   }
//   _goNext() {
//     // bool? _onBoarding=CashHelper.getBoolean(key:'onBoarding');
//     // if (_onBoarding==null) {
//     //   GoPage().navDelete(context, OnBoardingSC());
//     // }  else{
//     //   GoPage().navDelete(context, LayOut());
//     // }
//     GoPage().navDelete(context, LayOut());
//   }
//   @override
//   void initState() {
//     // _startDelay();
//     // _controller = VideoPlayerController.network(
//     //     "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4");
//     _controller = VideoPlayerController.asset("assets/Final Comp_2.mp4");
//     _initializeVideoPlayerFuture = _controller.initialize();
//     _controller.setLooping(true);
//     _controller.setVolume(1.0);
//     _controller.play();
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     _timer?.cancel();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder(
//         future: _initializeVideoPlayerFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             return Center(
//               child: AspectRatio(
//                 aspectRatio: _controller.value.aspectRatio,
//                 child: VideoPlayer(_controller),
//               ),
//             );
//           } else {
//             return Center(
//               child: CircularProgressIndicator(
//                 color: primaryColor,
//               ),
//             );
//           }
//         },
//       ),
//       // floatingActionButton: FloatingActionButton(
//       //   onPressed: () {
//       //     setState(() {
//       //       if (_controller.value.isPlaying) {
//       //         _controller.pause();
//       //       } else {
//       //         _controller.play();
//       //       }
//       //     });
//       //   },
//       //   child:
//       //   Icon(_controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
//       // ),
//     );
//   }
// }


class SplashSc extends StatefulWidget {
  const SplashSc({Key? key}) : super(key: key);

  @override
  State<SplashSc> createState() => _SplashScState();
}

class _SplashScState extends State<SplashSc> with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(vsync: this);
  }
  _goNext() {
    GoPage().navDelete(context, LayOut());

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Theme.of(context).scaffoldBackgroundColor,
      body:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Lottie.asset('assets/foody intro/render/data.json',
            fit: BoxFit.cover,
            repeat: true,
            controller: _controller,
            onLoaded: (composition) {
              _controller
                ..duration = composition.duration
                ..forward().whenComplete((){
                  // _goNext()
                }
                );
            },

          ),
           SizedBox(
            height: 60.h,
          ),
          // Row(
          //   children:  [
          //     const SizedBox(
          //       width: 70,
          //     ),
          //     DefaultTextStyle(
          //       style:  const TextStyle(
          //         fontSize: 40.0,
          //         fontWeight: FontWeight.w900,
          //         color:primaryColor,
          //       ),
          //       child: AnimatedTextKit(
          //         animatedTexts: [
          //           // TypewriterAnimatedText('Newssly '),
          //           TypewriterAnimatedText('Newssly App',
          //             speed: Duration(milliseconds: 300),),
          //
          //         ],
          //
          //       ),
          //     )
          //     // Text('Newssly App',
          //     //   style: TextStyle(
          //     //     fontSize: 40,fontWeight: FontWeight.w900,
          //     //     color:primaryColor,
          //     //   ),)
          //   ],
          // )
        ],
      ),
    );
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}