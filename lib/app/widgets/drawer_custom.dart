
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';
import '../routes/app_route_config.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Drawer(
      child: Column(
        children: [
          DrawerHeader(
              decoration:const BoxDecoration(
                color: AppColor.primary_color,
              ),
              child: Container()
              // Assets.wmoLogo.image(fit: BoxFit.contain,filterQuality: FilterQuality.high)
              // Lottie.asset(Assets.lottie.lottieSplash,repeat: true,reverse: true,animate: true)
          ),
          const Text("      App version  - 1.0.4",style: TextStyle(
              color: AppColor.grey
          ),),
          const Gap(40),
          ListTile(
            style: ListTileStyle.drawer,
            tileColor: AppColor.grey.shade100,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side:BorderSide(color: AppColor.grey.shade300)
            ),
            title: const Center(child:Text("Contact Dev")),
            onTap: () async {
          final call = Uri.parse('tel:+919744609937');
          // replace the phone number with the actual phone number of the warden or developer
          if (await canLaunchUrl(call)) {
            await launchUrl(call);
          } else {
            log('Could not launch $call');
          }

            },
          ),
          const Gap(20),
          ListTile(
            style: ListTileStyle.drawer,
            tileColor: AppColor.grey.shade100,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side:BorderSide(color: AppColor.grey.shade300)
            ),
            title:  const Center(child:Text("Individual Person Data",style: TextStyle(
            ),
                )),
            onTap: () async {
              context.pushNamed(Routes.individualFullData.name);
            }
          ),
          const Gap(20),
          ListTile(
            tileColor: AppColor.grey.shade100,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side:BorderSide(color: AppColor.grey.shade300),
            ),
            title: const Center(child: Text("Privacy-Policy")),
            onTap: () async {
              final privacyPage = Uri.parse('https://hostel-attendence-wmo.web.app');
              // replace the phone number with the actual phone number of the warden or developer
              if (await canLaunchUrl(privacyPage)) {
              await launchUrl(privacyPage);
              } else {
              log('Could not launch $privacyPage');
              }
            },
          ),
          const Gap(20),
          ListTile(
            tileColor: AppColor.grey.shade100,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side:BorderSide(color: AppColor.grey.shade300)),
            title: const Center(child:  Text("Bill Payment",style: TextStyle(
              color: AppColor.grey
            ),)),
            onTap: () {
              context.pushNamed(Routes.payment.name);
            },
          ),
          const Gap(50),
          ListTile(
            style: ListTileStyle.drawer,
            tileColor: AppColor.grey.shade100,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side:BorderSide(color: AppColor.grey.shade300)
            ),
            title: const Center(child:  Text("Mess Cut")),textColor: AppColor.accentColor2,
            subtitle: const Center(child: Text("   coming soon...",style: TextStyle(
                fontStyle: FontStyle.italic
            ),)),
            onTap: () {
              // Navigator.pop(context);
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const Page1()),
              // );
            },
          ),
        ],
      ),
    );
  }
}
