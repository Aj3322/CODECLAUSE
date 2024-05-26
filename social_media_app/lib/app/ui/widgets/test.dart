// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/widgets.dart';
// import 'package:fooddelivery/constants.dart';
// import 'constants.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData.dark().copyWith(
//         scaffoldBackgroundColor: bgColor,
//         textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
//             .apply(bodyColor: Colors.white),
//         canvasColor: secondaryColor,
//       ),
//       home: const Login(),
//     );
//   }
// }
//
//
// class Login extends StatefulWidget {
//   const Login({super.key});
//   @override
//   State<Login> createState() => _LoginState();
// }
//
// class _LoginState extends State<Login> {
//   bool isChecked = false;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Image.asset('assets/images/shape7.png'),
//           Spacer(),
//           Center(
//             child: Column(
//               children: [
//                 Text(
//                   'Welcome Back!',
//                   style: GoogleFonts.ubuntu(
//                       color: Colors.black,
//                       fontSize: 22,
//                       fontWeight: FontWeight.w600),
//                 ),
//                 SizedBox(
//                   height: defaultPadding * 2,
//                 ),
//                 Container(
//                   margin: EdgeInsets.symmetric(
//                     horizontal: defaultPadding * 2,
//                   ),
//                   padding: EdgeInsets.symmetric(horizontal: defaultPadding),
//                   decoration: BoxDecoration(
//                     border: Border.all(width: 1, color: Colors.black54),
//                   ),
//                   child: TextField(
//                     decoration: InputDecoration(
//                         prefixIcon: Container(
//                           height: 10,
//                           width: 10,
//                           child: const Align(
//                             alignment: Alignment.centerLeft,
//                             child: Icon(
//                               Icons.email_outlined,
//                               color: Colors.black,
//                               size: 25,
//                             ),
//                           ),
//                         ),
//                         disabledBorder: InputBorder.none,
//                         enabledBorder: InputBorder.none,
//                         focusedBorder: InputBorder.none,
//                         hintText: 'Email address',
//                         hintStyle: TextStyle(color: Colors.black26)),
//                   ),
//                 ),
//                 //inputbox 2
//                 SizedBox(
//                   height: defaultPadding,
//                 ),
//                 Container(
//                   margin: EdgeInsets.symmetric(
//                     horizontal: defaultPadding * 2,
//                   ),
//                   padding: EdgeInsets.symmetric(horizontal: defaultPadding),
//                   decoration: BoxDecoration(
//                     border: Border.all(width: 1, color: Colors.black54),
//                   ),
//                   child: TextField(
//                     decoration: InputDecoration(
//                         prefixIcon: Container(
//                           height: 10,
//                           width: 10,
//                           child: const Align(
//                             alignment: Alignment.centerLeft,
//                             child: Icon(
//                               Icons.lock_outline,
//                               color: Colors.black,
//                               size: 25,
//                             ),
//                           ),
//                         ),
//                         disabledBorder: InputBorder.none,
//                         enabledBorder: InputBorder.none,
//                         focusedBorder: InputBorder.none,
//                         hintText: 'Password',
//                         hintStyle: TextStyle(color: Colors.black26)),
//                   ),
//                 ),
//                 Padding(
//                   padding:
//                   const EdgeInsets.symmetric(horizontal: defaultPadding),
//                   child: Row(
//                     children: [
//                       Checkbox(
//                           value: isChecked,
//                           checkColor: const Color.fromARGB(
//                               255, 29, 26, 26), //white to black
//                           activeColor: Colors.orange,
//                           side: BorderSide(width: 1, color: Colors.orange),
//                           shape: RoundedRectangleBorder(
//                               borderRadius:
//                               BorderRadius.all(Radius.circular(5))),
//                           onChanged: (bool? value) {
//                             setState(() {
//                               isChecked = value!;
//                             });
//                           }),
//                       SizedBox(
//                         width: 5,
//                       ),
//                       Text(
//                         'Remember me',
//                         style: GoogleFonts.ubuntu(
//                             color: Colors.orange,
//                             fontSize: 14,
//                             fontWeight: FontWeight.w400),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   height: 50,
//                   width: double.infinity,
//                   margin: EdgeInsets.symmetric(horizontal: defaultPadding * 2),
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                         elevation: 0,
//                         // surfaceTintColor: Color.fromARGB(255, 11, 11, 11),
//
//                         // Primary:Color(0FFF7B43F),
//
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10))),
//                     onPressed: () {},
//                     child: Text(
//                       'Login',
//                       style: GoogleFonts.ubuntu(
//                         // here we change black to orange color
//                           color: Colors.orange,
//                           fontSize: 18,
//                           fontWeight: FontWeight.w600),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: defaultPadding,
//                 ),
//                 RichText(
//                     text: TextSpan(
//                         text: "Don't have an account?",
//                         style: GoogleFonts.ubuntu(
//                           // here we change black to orange color
//                           color: Colors.orange,
//                           fontSize: 14,
//                         ),
//                         children: <TextSpan>[
//                           TextSpan(
//                               text: 'Sign Up',
//                               style: GoogleFonts.ubuntu(
//                                 // here we change black to orange color
//                                   color: Colors.orange,
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w500),
//                               recognizer: TapGestureRecognizer()
//                                 ..onTap = () {
//                                   Navigator.of(context).push(MaterialPageRoute(
//                                       builder: (context) => SignUp()));
//                                 }),
//                         ])),
//               ],
//             ),
//           ),
//           Spacer(),
//           Image.asset('assets/images/shape6.png'),
//         ],
//       ),
//     );
//   }
// }
//
//
// class SignUp extends StatefulWidget {
//   const SignUp({super.key});
//
//   @override
//   State<SignUp> createState() => _SignUpState();
// }
//
// class _SignUpState extends State<SignUp> {
//   bool isChecked = false;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Stack(
//             children: [
//               Image.asset('assets/images/shape8.png'),
//               Align(
//                 alignment: Alignment.topRight,
//                 child: Padding(
//                   padding: const EdgeInsets.only(
//                       top: defaultPadding * 3, right: defaultPadding),
//                   child: InkWell(
//                     onTap: () {
//                       Navigator.of(context).push(
//                           MaterialPageRoute(builder: (context) => Home()));
//                     },
//                     child: Text(
//                       'Skip',
//                       style: GoogleFonts.ubuntu(
//                           color: Colors.white,
//                           fontSize: 18,
//                           fontWeight: FontWeight.w600),
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//           Spacer(),
//           Center(
//             child: Column(
//               children: [
//                 Text(
//                   'Welcome',
//                   style: GoogleFonts.ubuntu(
//                       color: Colors.black,
//                       fontSize: 22,
//                       fontWeight: FontWeight.w600),
//                 ),
//                 SizedBox(
//                   height: defaultPadding * 2,
//                 ),
//                 Container(
//                   margin: EdgeInsets.symmetric(
//                       horizontal: defaultPadding * 2), //edgeInserts.symmetric
//                   padding: EdgeInsets.symmetric(horizontal: defaultPadding),
//                   decoration: BoxDecoration(
//                       border: Border.all(width: 1, color: Colors.black54)),
//                   child: TextField(
//                     decoration: InputDecoration(
//                         prefixIcon: Container(
//                           height: 10,
//                           width: 10,
//                           margin: EdgeInsets.symmetric(
//                               horizontal:
//                               defaultPadding * 2), //edgeInserts.symmetric
//                           decoration: BoxDecoration(
//                               border:
//                               Border.all(width: 1, color: Colors.black54)),
//                           child: Align(
//                             alignment: Alignment.centerLeft,
//                             child: Icon(
//                               Icons.person_outline,
//                               color: Colors.black,
//                               size: 25,
//                             ),
//                           ),
//                         ),
//                         disabledBorder: InputBorder.none,
//                         enabledBorder: InputBorder.none,
//                         focusedBorder: InputBorder.none,
//                         hintText: 'User Name',
//                         hintStyle: TextStyle(color: Colors.black26)),
//                   ),
//                 ),
//                 SizedBox(
//                   height: defaultPadding * 2,
//                 ),
//                 Container(
//                   margin: EdgeInsets.symmetric(
//                       horizontal: defaultPadding * 2), //edgeInserts.symmetric
//                   padding: EdgeInsets.symmetric(horizontal: defaultPadding),
//                   decoration: BoxDecoration(
//                       border: Border.all(width: 1, color: Colors.black54)),
//                   child: TextField(
//                     decoration: InputDecoration(
//                         prefixIcon: Container(
//                           height: 10,
//                           width: 10,
//                           margin: EdgeInsets.symmetric(
//                               horizontal:
//                               defaultPadding * 2), //edgeInserts.symmetric
//                           decoration: BoxDecoration(
//                               border:
//                               Border.all(width: 1, color: Colors.black54)),
//                           child: Align(
//                             alignment: Alignment.centerLeft,
//                             child: Icon(
//                               Icons.phone_outlined,
//                               color: Colors.black,
//                               size: 25,
//                             ),
//                           ),
//                         ),
//                         disabledBorder: InputBorder.none,
//                         enabledBorder: InputBorder.none,
//                         focusedBorder: InputBorder.none,
//                         hintText: 'Phone',
//                         hintStyle: TextStyle(color: Colors.black26)),
//                   ),
//                 ),
//                 SizedBox(
//                   height: defaultPadding * 2,
//                 ),
//                 Container(
//                   margin: EdgeInsets.symmetric(
//                       horizontal: defaultPadding * 2), //edgeInserts.symmetric
//                   padding: EdgeInsets.symmetric(horizontal: defaultPadding),
//                   decoration: BoxDecoration(
//                       border: Border.all(width: 1, color: Colors.black54)),
//                   child: TextField(
//                     decoration: InputDecoration(
//                         prefixIcon: Container(
//                           height: 10,
//                           width: 10,
//                           margin: EdgeInsets.symmetric(
//                               horizontal:
//                               defaultPadding * 2), //edgeInserts.symmetric
//                           decoration: BoxDecoration(
//                               border:
//                               Border.all(width: 1, color: Colors.black54)),
//                           child: Align(
//                             alignment: Alignment.centerLeft,
//                             child: Icon(
//                               Icons.email_outlined,
//                               color: Colors.black,
//                               size: 25,
//                             ),
//                           ),
//                         ),
//                         disabledBorder: InputBorder.none,
//                         enabledBorder: InputBorder.none,
//                         focusedBorder: InputBorder.none,
//                         hintText: 'Email',
//                         hintStyle: TextStyle(color: Colors.black26)),
//                   ),
//                 ),
//                 SizedBox(
//                   height: defaultPadding,
//                 ),
//                 Container(
//                   margin: EdgeInsets.symmetric(
//                       horizontal: defaultPadding * 2), //edgeInserts.symmetric
//                   padding: EdgeInsets.symmetric(horizontal: defaultPadding),
//                   decoration: BoxDecoration(
//                       border: Border.all(width: 1, color: Colors.black54)),
//                   child: TextField(
//                     decoration: InputDecoration(
//                         prefixIcon: Container(
//                           height: 10,
//                           width: 10,
//                           margin: EdgeInsets.symmetric(
//                               horizontal:
//                               defaultPadding), //edgeInserts.symmetric
//                           decoration: BoxDecoration(
//                               border:
//                               Border.all(width: 1, color: Colors.black54)),
//                           child: Align(
//                             alignment: Alignment.centerLeft,
//                             child: Icon(
//                               Icons.lock_outline,
//                               color: Colors.black,
//                               size: 25,
//                             ),
//                           ),
//                         ),
//                         disabledBorder: InputBorder.none,
//                         enabledBorder: InputBorder.none,
//                         focusedBorder: InputBorder.none,
//                         hintText: 'Password',
//                         hintStyle: TextStyle(color: Colors.black26)),
//                   ),
//                 ),
//                 SizedBox(
//                   height: defaultPadding,
//                 ),
//                 Container(
//                   height: 50,
//                   width: double.infinity,
//                   margin: EdgeInsets.symmetric(horizontal: defaultPadding * 2),
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                         elevation: 0,
//                         // primary: Color(0xFFF7B43F),   // need few help
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10))),
//                     onPressed: () {},
//                     child: Text(
//                       'Create',
//                       style: GoogleFonts.ubuntu(
//                         // color: Colors.black,
//                           color: Color(0xFFF7B43f),
//                           fontSize: 18,
//                           fontWeight: FontWeight.w600),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: defaultPadding,
//                 ),
//                 RichText(
//                     text: TextSpan(
//                         text: "Already have an account? ",
//                         style: GoogleFonts.ubuntu(
//                           // color: Colors.black,
//                           color: Colors.black,
//                           fontSize: 14,
//                         ),
//                         children: <TextSpan>[
//                           TextSpan(
//                               text: 'Sing In',
//                               style: GoogleFonts.ubuntu(
//                                 // color: Colors.black,
//                                   color: Colors.black,
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w500),
//                               recognizer: TapGestureRecognizer()
//                                 ..onTap = () {
//                                   Navigator.of(context).push(MaterialPageRoute(
//                                       builder: (context) => Login()));
//                                 })
//                         ]))
//               ],
//             ),
//           ),
//           Spacer(),
//           Image.asset('assets/images/shape9.png'),
//         ],
//       ),
//     );
//   }
// }
//
//
// class Home extends StatefulWidget {
//   const Home({super.key});
//
//   @override
//   State<Home> createState() => _HomeState();
// }
//
// class _HomeState extends State<Home> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Stack(
//             children: [
//               Image.asset('assets/images/shape1.png'),
//               Padding(
//                 padding: const EdgeInsets.only(
//                   top: defaultPadding * 4,
//                   left: defaultPadding,
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Icon(
//                           Icons.place_outlined,
//                           size: 40,
//                         ),
//                         Text(
//                           'India,Haryana',
//                           style: GoogleFonts.ubuntu(
//                               fontSize: 18, fontWeight: FontWeight.w600),
//                         ),
//                         Spacer(),
//                         Padding(
//                           padding: const EdgeInsets.only(right: defaultPadding),
//                           child: ClipOval(
//                               child: SizedBox(
//                                 height: 50,
//                                 child: Image.asset('assets/images/unnamed1.jpg'),
//                               )),
//                         )
//                       ],
//                     ),
//                     SizedBox(
//                       height: defaultPadding,
//                     ),
//                     Text(
//                       'Hellow \nmr salamuddin',
//                       style: GoogleFonts.ubuntu(
//                           fontSize: 20, fontWeight: FontWeight.w600),
//                     ),
//                     SizedBox(
//                       height: defaultPadding,
//                     ),
//                     Row(
//                       children: [
//                         Expanded(
//                             child: Container(
//                               height: 50,
//                               padding:
//                               EdgeInsets.symmetric(horizontal: defaultPadding),
//                               decoration: BoxDecoration(
//                                   color: Color.fromARGB(
//                                       255, 19, 10, 10), // white to black
//                                   borderRadius:
//                                   BorderRadius.all(Radius.circular(10))),
//                               child: TextField(
//                                 decoration: InputDecoration(
//                                     suffixIcon: Icon(
//                                       Icons.search_outlined,
//                                       color: Colors.black,
//                                     ),
//                                     hintText: 'Search...',
//                                     hintStyle: TextStyle(
//                                         color: Colors.black54, fontSize: 14)),
//                               ),
//                             )),
//                         SizedBox(
//                           width: defaultPadding,
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(right: defaultPadding),
//                           child: Container(
//                             height: 50,
//                             width: 50,
//                             decoration: BoxDecoration(
//                                 color: Color.fromARGB(
//                                     255, 3, 12, 13), // white to black
//                                 borderRadius:
//                                 BorderRadius.all(Radius.circular(10))),
//                             child: Image.asset(
//                               'assets/icons/settings.png',
//                               scale: 20,
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                     SizedBox(
//                       height: defaultPadding * 2,
//                     ),
//                     SizedBox(
//                       height: 120,
//                       width: double.infinity,
//                       child: ListView.builder(
//                           scrollDirection: Axis.horizontal,
//                           padding: EdgeInsets.all(0),
//                           itemCount: 4,
//                           itemBuilder: (context, index) {
//                             return Padding(
//                               //here is little problems padding not extract nem method(CardBestSellers)  18:32 minutes
//                               padding: const EdgeInsets.only(right: 10),
//                               child: Card(
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(20),
//                                 ),
//                                 child: Container(
//                                   height: 120,
//                                   width: 120,
//                                   decoration: BoxDecoration(
//                                     color: const Color.fromARGB(
//                                         255, 63, 54, 54), // white to balck
//                                     borderRadius:
//                                     BorderRadius.all(Radius.circular(20)),
//                                   ),
//                                 ),
//                               ),
//                             );
//                           }),
//                     )
//                   ],
//                 ),
//               )
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
//
// class SignUp extends StatefulWidget {
//   const SignUp({super.key});
//
//   @override
//   State<SignUp> createState() => _SignUpState();
// }
//
// class _SignUpState extends State<SignUp> {
//   bool isChecked = false;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Stack(
//             children: [
//               Image.asset('assets/images/shape8.png'),
//               Align(
//                 alignment: Alignment.topRight,
//                 child: Padding(
//                   padding: const EdgeInsets.only(
//                       top: defaultPadding * 3, right: defaultPadding),
//                   child: InkWell(
//                     onTap: () {
//                       Navigator.of(context).push(
//                           MaterialPageRoute(builder: (context) => Home()));
//                     },
//                     child: Text(
//                       'Skip',
//                       style: GoogleFonts.ubuntu(
//                           color: Colors.white,
//                           fontSize: 18,
//                           fontWeight: FontWeight.w600),
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//           Spacer(),
//           Center(
//             child: Column(
//               children: [
//                 Text(
//                   'Welcome',
//                   style: GoogleFonts.ubuntu(
//                       color: Colors.black,
//                       fontSize: 22,
//                       fontWeight: FontWeight.w600),
//                 ),
//                 SizedBox(
//                   height: defaultPadding * 2,
//                 ),
//                 Container(
//                   margin: EdgeInsets.symmetric(
//                       horizontal: defaultPadding * 2), //edgeInserts.symmetric
//                   padding: EdgeInsets.symmetric(horizontal: defaultPadding),
//                   decoration: BoxDecoration(
//                       border: Border.all(width: 1, color: Colors.black54)),
//                   child: TextField(
//                     decoration: InputDecoration(
//                         prefixIcon: Container(
//                           height: 10,
//                           width: 10,
//                           margin: EdgeInsets.symmetric(
//                               horizontal:
//                               defaultPadding * 2), //edgeInserts.symmetric
//                           decoration: BoxDecoration(
//                               border:
//                               Border.all(width: 1, color: Colors.black54)),
//                           child: Align(
//                             alignment: Alignment.centerLeft,
//                             child: Icon(
//                               Icons.person_outline,
//                               color: Colors.black,
//                               size: 25,
//                             ),
//                           ),
//                         ),
//                         disabledBorder: InputBorder.none,
//                         enabledBorder: InputBorder.none,
//                         focusedBorder: InputBorder.none,
//                         hintText: 'User Name',
//                         hintStyle: TextStyle(color: Colors.black26)),
//                   ),
//                 ),
//                 SizedBox(
//                   height: defaultPadding * 2,
//                 ),
//                 Container(
//                   margin: EdgeInsets.symmetric(
//                       horizontal: defaultPadding * 2), //edgeInserts.symmetric
//                   padding: EdgeInsets.symmetric(horizontal: defaultPadding),
//                   decoration: BoxDecoration(
//                       border: Border.all(width: 1, color: Colors.black54)),
//                   child: TextField(
//                     decoration: InputDecoration(
//                         prefixIcon: Container(
//                           height: 10,
//                           width: 10,
//                           margin: EdgeInsets.symmetric(
//                               horizontal:
//                               defaultPadding * 2), //edgeInserts.symmetric
//                           decoration: BoxDecoration(
//                               border:
//                               Border.all(width: 1, color: Colors.black54)),
//                           child: Align(
//                             alignment: Alignment.centerLeft,
//                             child: Icon(
//                               Icons.phone_outlined,
//                               color: Colors.black,
//                               size: 25,
//                             ),
//                           ),
//                         ),
//                         disabledBorder: InputBorder.none,
//                         enabledBorder: InputBorder.none,
//                         focusedBorder: InputBorder.none,
//                         hintText: 'Phone',
//                         hintStyle: TextStyle(color: Colors.black26)),
//                   ),
//                 ),
//                 SizedBox(
//                   height: defaultPadding * 2,
//                 ),
//                 Container(
//                   margin: EdgeInsets.symmetric(
//                       horizontal: defaultPadding * 2), //edgeInserts.symmetric
//                   padding: EdgeInsets.symmetric(horizontal: defaultPadding),
//                   decoration: BoxDecoration(
//                       border: Border.all(width: 1, color: Colors.black54)),
//                   child: TextField(
//                     decoration: InputDecoration(
//                         prefixIcon: Container(
//                           height: 10,
//                           width: 10,
//                           margin: EdgeInsets.symmetric(
//                               horizontal:
//                               defaultPadding * 2), //edgeInserts.symmetric
//                           decoration: BoxDecoration(
//                               border:
//                               Border.all(width: 1, color: Colors.black54)),
//                           child: Align(
//                             alignment: Alignment.centerLeft,
//                             child: Icon(
//                               Icons.email_outlined,
//                               color: Colors.black,
//                               size: 25,
//                             ),
//                           ),
//                         ),
//                         disabledBorder: InputBorder.none,
//                         enabledBorder: InputBorder.none,
//                         focusedBorder: InputBorder.none,
//                         hintText: 'Email',
//                         hintStyle: TextStyle(color: Colors.black26)),
//                   ),
//                 ),
//                 SizedBox(
//                   height: defaultPadding,
//                 ),
//                 Container(
//                   margin: EdgeInsets.symmetric(
//                       horizontal: defaultPadding * 2), //edgeInserts.symmetric
//                   padding: EdgeInsets.symmetric(horizontal: defaultPadding),
//                   decoration: BoxDecoration(
//                       border: Border.all(width: 1, color: Colors.black54)),
//                   child: TextField(
//                     decoration: InputDecoration(
//                         prefixIcon: Container(
//                           height: 10,
//                           width: 10,
//                           margin: EdgeInsets.symmetric(
//                               horizontal:
//                               defaultPadding), //edgeInserts.symmetric
//                           decoration: BoxDecoration(
//                               border:
//                               Border.all(width: 1, color: Colors.black54)),
//                           child: Align(
//                             alignment: Alignment.centerLeft,
//                             child: Icon(
//                               Icons.lock_outline,
//                               color: Colors.black,
//                               size: 25,
//                             ),
//                           ),
//                         ),
//                         disabledBorder: InputBorder.none,
//                         enabledBorder: InputBorder.none,
//                         focusedBorder: InputBorder.none,
//                         hintText: 'Password',
//                         hintStyle: TextStyle(color: Colors.black26)),
//                   ),
//                 ),
//                 SizedBox(
//                   height: defaultPadding,
//                 ),
//                 Container(
//                   height: 50,
//                   width: double.infinity,
//                   margin: EdgeInsets.symmetric(horizontal: defaultPadding * 2),
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                         elevation: 0,
//                         // primary: Color(0xFFF7B43F),   // need few help
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10))),
//                     onPressed: () {},
//                     child: Text(
//                       'Create',
//                       style: GoogleFonts.ubuntu(
//                         // color: Colors.black,
//                           color: Color(0xFFF7B43f),
//                           fontSize: 18,
//                           fontWeight: FontWeight.w600),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: defaultPadding,
//                 ),
//                 RichText(
//                     text: TextSpan(
//                         text: "Already have an account? ",
//                         style: GoogleFonts.ubuntu(
//                           // color: Colors.black,
//                           color: Colors.black,
//                           fontSize: 14,
//                         ),
//                         children: <TextSpan>[
//                           TextSpan(
//                               text: 'Sing In',
//                               style: GoogleFonts.ubuntu(
//                                 // color: Colors.black,
//                                   color: Colors.black,
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w500),
//                               recognizer: TapGestureRecognizer()
//                                 ..onTap = () {
//                                   Navigator.of(context).push(MaterialPageRoute(
//                                       builder: (context) => Login()));
//                                 })
//                         ]))
//               ],
//             ),
//           ),
//           Spacer(),
//           Image.asset('assets/images/shape9.png'),
//         ],
//       ),
//     );
//   }
// }