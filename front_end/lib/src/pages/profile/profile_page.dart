import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getgoods/src/constants/colors.dart';
import 'package:getgoods/src/constants/constants.dart';
import 'package:getgoods/src/models/user_model.dart';
import 'package:getgoods/src/pages/account_detail/account_datail_page.dart';
import 'package:getgoods/src/pages/bank_info_detail/bank_info_page.dart';
import 'package:getgoods/src/pages/help_center/help_center.dart';
import 'package:getgoods/src/pages/login/login_page.dart';
import 'package:getgoods/src/pages/my_purchase/my_purchase_page.dart';
import 'package:getgoods/src/pages/profile/widgets/purchase_bar.dart';
import 'package:getgoods/src/pages/signup/signup_page.dart';
import 'package:getgoods/src/viewmodels/user_viewmodel.dart';

import '../my_store/my_store_page.dart';
import '../register_shop/register_shop_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with WidgetsBindingObserver {
  late UserViewModel userViewModel;

  @override
  void initState() {
    super.initState();
    userViewModel = UserViewModel();
    _getUserDetail();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _getUserDetail();
    }
  }

  _getUserDetail() async {
    await userViewModel.fetchUser();
    if (mounted) {
      setState(() {}); // Rebuild the widget after fetching user details
    }
  }

  @override
  Widget build(BuildContext context) {
    UserDetail userDetail = userViewModel.userDetail;
    UserState userState = userViewModel.state;
    log(userState.toString());
    log(userDetail.email.toString());
    log(userDetail.shop.name.toString());

    if (userState == UserState.loading) {
      return const Center(
        child: CircularProgressIndicator(color: primaryColor),
      );
    }

    if (userState == UserState.error) {
      Future.delayed(Duration.zero, () {});
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                ).then(
                  (_) => _getUserDetail(),
                ); // Fetch user details again after logging in
              },
              child: const Text('Log in'),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor:
          userState == UserState.idle ? primaryColor : secondaryBGColor,
      body: userState == UserState.idle
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: defaultpadding,
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.black12,
                    maxRadius: 100,
                    child: Image.asset('assets/images/logo_2.png'),
                  ),
                  const SizedBox(
                    height: defaultpadding,
                  ),
                  const Text(
                    'Welcome to',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'SFTHONBURI'),
                  ),
                  RichText(
                      text: const TextSpan(
                          text: 'Get',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'SFTHONBURI'),
                          children: [
                        TextSpan(
                            text: 'Goods', style: TextStyle(color: accentColor))
                      ])),
                  const Text(
                    'Marketplace for getting goods.',
                    style: TextStyle(
                        color: Colors.white, fontFamily: 'SFTHONBURI'),
                  ),
                  const SizedBox(
                    height: defaultpadding * 2,
                  ),
                  // const Text(
                  //   "Don't have an account?",
                  //   style: TextStyle(
                  //       color: Colors.white,
                  //       fontSize: 18,
                  //       fontWeight: FontWeight.w500,
                  //       fontFamily: 'SFTHONBURI'),
                  // ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpPage(),
                            ),
                          );
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                              color: primaryColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'SFTHONBURI'),
                        ),
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: DividerWithText(
                      text: 'or',
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'SFTHONBURI'),
                      thickness: 1.0,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: defaultpadding / 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          ).then(
                            (_) => _getUserDetail(),
                          ); // Fetch user details again after logging in
                        },
                        child: const Text(
                          'Log in',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'SFTHONBURI'),
                        ),
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(secondaryColor),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          // child: ElevatedButton(
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => const LoginPage(),
          //       ),
          //     ).then(
          //       (_) => _getUserDetail(),
          //     ); // Fetch user details again after logging in
          //   },
          //   child: const Text('Log in'),
          // ),

          : Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        height: 200,
                        color: primaryColor,
                        child: SafeArea(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                maxRadius: 40,
                                child: CachedNetworkImage(
                                  imageBuilder: (context, imageProvider) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  },
                                  imageUrl: userDetail.photo,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.green,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) {
                                    print(url);
                                    print(error);
                                    return const Center(
                                      child: Icon(
                                        Icons.error_outline,
                                        color: Colors.red,
                                        size: 40,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    userDetail.name,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    userDetail.email,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (userDetail.shop.name.toString() == '') {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const RegisterShopPage(),
                                )).then(
                              (_) => _getUserDetail(),
                            );
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyStorePage(
                                  shopId: userDetail.shop.id,
                                ),
                              ),
                            );
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 16,
                          ),
                          width: double.infinity,
                          color: primaryBGColor,
                          child: Row(
                            children: [
                              const Icon(
                                Icons.storefront_rounded,
                                color: primaryColor,
                                size: 28,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                'My Store',
                                style: TextStyle(
                                  color: primaryTextColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                userDetail.shop.name.toString() == ''
                                    ? 'Free Registration'
                                    : userDetail.shop.name,
                                style: const TextStyle(
                                  color: grey,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              const Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: grey,
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: defaultpadding,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MyPurchasePage(
                                tabIndex: 0,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 16,
                          ),
                          width: double.infinity,
                          color: primaryBGColor,
                          child: Row(
                            children: const [
                              Icon(
                                Icons.assignment_rounded,
                                color: primaryColor,
                                size: 28,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'My Purchases',
                                style: TextStyle(
                                  color: primaryTextColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Spacer(),
                              Text(
                                'Order history',
                                style: TextStyle(
                                  color: grey,
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: grey,
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const PurchasetrackBar(),
                      const SizedBox(
                        height: defaultpadding,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyAccountDetailPage(
                                      userId: userDetail.shop.id,
                                    )),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 16,
                          ),
                          width: double.infinity,
                          color: primaryBGColor,
                          child: Row(
                            children: const [
                              Icon(
                                Icons.person_rounded,
                                color: primaryColor,
                                size: 28,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Account & Address Info',
                                style: TextStyle(
                                  color: primaryTextColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Spacer(),
                              SizedBox(
                                width: 4,
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: grey,
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: defaultpadding,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BankInfoPage(
                                      shopId: userDetail.shop.id,
                                    )),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 16,
                          ),
                          width: double.infinity,
                          color: primaryBGColor,
                          child: Row(
                            children: const [
                              Icon(
                                Icons.account_balance_rounded,
                                color: primaryColor,
                                size: 28,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Banking Account Info',
                                style: TextStyle(
                                  color: primaryTextColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Spacer(),
                              SizedBox(
                                width: 4,
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: grey,
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: defaultpadding,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HelpCenter()),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 16,
                          ),
                          width: double.infinity,
                          color: primaryBGColor,
                          child: Row(
                            children: const [
                              Icon(
                                Icons.help_rounded,
                                color: primaryColor,
                                size: 28,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Help Center',
                                style: TextStyle(
                                  color: primaryTextColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Spacer(),
                              SizedBox(
                                width: 4,
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: grey,
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(defaultpadding),
                        child: Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          child: ElevatedButton(
                            onPressed: () async {
                              await userViewModel.logout();
                              userViewModel.updateState(UserState.idle);
                              setState(() {});
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Log out',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        _buildIconButton(
                          onPressed: () => print('click'),
                          icon: CupertinoIcons.heart,
                          notification: 1,
                        ),
                        _buildIconButton(
                          onPressed: () => print('click'),
                          icon: CupertinoIcons.cart_fill,
                          notification: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
    //       : Center(
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               Text('User: ${userDetail.name}'),
    //               Text('Email: ${userDetail.email}'),
    //               ElevatedButton(
    //                 onPressed: () async {
    //                   await userViewModel.logout();
    //                   userViewModel.updateState(UserState.idle);
    //                   setState(() {});
    //                 },
    //                 child: const Text('Log out'),
    //               ),
    //             ],
    //           ),
    //         ),
    // );
  }

  _buildDivider() {
    return Divider(
      color: Colors.white,
      thickness: 1,
    );
  }

  _buildIconButton({
    required VoidCallback onPressed,
    required IconData icon,
    int notification = 0,
  }) {
    return Stack(
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(icon),
          color: primaryBGColor,
          iconSize: 28,
        ),
        notification <= 0
            ? const SizedBox()
            : Positioned(
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.green,
                    border: Border.all(
                      color: Colors.white,
                    ),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 22,
                    minHeight: 22,
                  ),
                  child: Text(
                    '$notification',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}

class DividerWithText extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final double thickness;
  final Color color;

  const DividerWithText({
    required this.text,
    this.textStyle = const TextStyle(fontSize: 16),
    this.thickness = 1.0,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Divider(
            color: color,
            thickness: thickness,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            text,
            style: textStyle,
          ),
        ),
        Expanded(
          child: Divider(
            color: color,
            thickness: thickness,
          ),
        ),
      ],
    );
  }
}
