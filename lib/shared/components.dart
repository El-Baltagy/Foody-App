import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody/shared/manager/theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'manager/color.dart';
import 'network/cash_helper.dart';



showSnackBar(
    BuildContext context, String text,{
      int sec=1,
      Color colorText=Colors.white,
      Color backgroundColor=Colors.red
}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content:
      Text(text,
        style: TextStyle(color: colorText,fontSize: 17.sp),),
      duration: Duration(seconds: sec),
      backgroundColor: backgroundColor,
    ),
  );
}




// class BuildLoadingSkelton extends StatelessWidget {
//   const BuildLoadingSkelton({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child:  Card(
//         elevation: 8,
//         child:   Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Row(
//             children:
//             [
//               Shimmer.fromColors(
//                 highlightColor:Theme.of(context).highlightColor ,
//                 baseColor: Theme.of(context).baseColor,
//                 child: Container(
//                   width: 120.0,
//                   height: 120.0,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10.0,),
//                     color: Theme.of(context).baseColor
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 width: 20.0,
//               ),
//               Expanded(
//                 child: Container(
//                   height: 120.0,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children:
//                     [
//                       Shimmer.fromColors(
//                           highlightColor:Theme.of(context).highlightColor ,
//                           baseColor: Theme.of(context).baseColor,
//                           child: myDivider(color: Theme.of(context).baseColor,height: 60)),
//                       const SizedBox(
//                         height: 20.0,
//                       ),
//                       Shimmer.fromColors(
//                           highlightColor:Theme.of(context).highlightColor ,
//                           baseColor: Theme.of(context).baseColor,
//                           child: myDivider(color: Theme.of(context).baseColor,height: 20))
//                     ],
//                   ),
//                 ),
//               ),
//               // const SizedBox(
//               //   width: 8.0,
//               // ),
//             ],
//           ),
//
//         ),
//       ),
//     );
//   }
// }



// class networkCheck extends StatelessWidget {
//   const networkCheck({
//     super.key,
//     required this.h,
//     required this.w,
//     required this.function,
//   });
//
//   final double h;
//   final double w;
//   final VoidCallback function;
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: h,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Center(
//               child: Lottie.asset(
//                 "assets/images/Not Done.json",
//                 width: w * 0.70,
//               )),
//           ElevatedButton(
//               onPressed: function,
//               child: const Text("Try again"))
//         ],
//       ),
//     );
//   }
// }

class DropDownList extends StatelessWidget {
  const DropDownList({super.key, required this.name, required this.call});
  final String name;
  final Function call;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ListTile(title: Text(name)),
      onTap: () => call(),
    );
  }
}


TextFormField buildTextFormField({
  required String labelTitle,
  Function(String)? onChange,
  String? Function(String?)? validator,
  TextEditingController? controller,
  FocusNode? focusNode,
  bool isPassword=false,
  IconData? suffix,
  IconData? prefix,
  Function(String)? onSubmit,
  Function()? suffixPressed,
  TextInputType Type=TextInputType.emailAddress,
  EdgeInsetsGeometry? padding=const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
  InputBorder? border= const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10))
  )
}) {
  return TextFormField(
    // textAlign: TextAlign.center,
    onFieldSubmitted: onSubmit,
    maxLength: 1,
    style: TextStyle(color: primaryColor),
    validator: validator ,
    obscureText: isPassword,
    keyboardType:Type,
    controller:controller ,
    focusNode: focusNode,
    cursorColor: primaryColor,
    onChanged: onChange,
    decoration: InputDecoration(
        suffixIcon: IconButton(onPressed: suffixPressed, icon: Icon(suffix,color: primaryColor,)),
        prefixIcon: Icon(prefix,color: primaryColor) ,
        labelText: labelTitle,
        contentPadding:  padding,
        border: border,
       counterStyle: TextStyle(
           color: primaryColor
       ),
        labelStyle: TextStyle(
            color: primaryColor
        ),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.grey,width: 1
            ),
            borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
                color: primaryColor,width: 2
            ),
            borderRadius: BorderRadius.all(Radius.circular(10))
        )
    ),
  );
}

class GoPage {
  GoPage();

  void navDelete(
      context,
      widget,
      {bool Rt = false}
      ) =>
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => widget,
        ),
      );

  void navigateAndFinish(
      context,
      widget,
      {bool Rt = false}
      ) =>
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => widget,
        ), (route) =>Rt,
      );
   pushNavigation(context, {
    required Widget path,
    var curve = Curves.ease,
    double x=0.2,
    double y=0,
  }) {
    Navigator.of(context).
    push(_createRoute(Sc: path,curve:curve,X:x ,Y:y ));
  }
  void popNavigation(context, {
    required Widget path,
    var curve = Curves.ease,
    double x=0.0,
    double y=0.2,
  }) {
    Navigator.of(context).pop(_createRoute(Sc: path,curve:curve,X:x ,Y:y ));
  }
  _createRoute({
    required Widget Sc,
    required var curve,
    required double X,Y,
  }) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => Sc,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(X,Y);
        const end = Offset.zero;

        var tween = Tween(begin: begin, end: end).chain(
            CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  // void getNavigation({required Widget path, Transition transition=Transition.zoom,}){
  //   Get.to((context)=>path,transition:transition,);
  // }
}

Widget myDivider({
  double height=2.0,
  Color color =primaryColor
}) => Padding(
  padding: const EdgeInsetsDirectional.only(
      end:30.0,start: 10,
  ),
  child: Container(
    width: double.infinity,
    height: height,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(4.0,),
      color: color,
    ),

  ),
);