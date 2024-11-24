import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../common/widgets/appbar/appbar.dart';

class HelpAndSupportScreen extends StatelessWidget {
  const HelpAndSupportScreen({Key? key}) : super(key: key);

  Future<void> _launchEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'https',
      host: 'mail.google.com',
      path: '/mail/u/0/',
      queryParameters: {
        'view': 'cm',
        'fs': '1',
        'to': 'avishkadulanjana377@gmail.com',
        'su': 'Support Inquiry',
        'body': 'Dear Support Team',
      },
    );

    // Try launching the Gmail app URL
    if (!await launchUrl(emailLaunchUri)) {
      // Fallback: Open the URL in a web browser if the Gmail app can't be opened
      print('Could not launch in Gmail app, trying to open in a browser...');
      await launchUrl(
        emailLaunchUri,
        mode: LaunchMode.externalApplication,
      );
    }
  }

  Future<void> _launchSocialMedia(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(
        title: Text('Contact Us'),
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'For any queries or assistance, feel free to contact us:',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.email),
              title: Text(
                'Email',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              subtitle: Text(
                'avishkadulanjana377@gmail.com',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              onTap: _launchEmail,
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.phone),
              title: Text(
                'Phone',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              subtitle: Text(
                '+94717375582',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              onTap: () async {
                final Uri phoneLaunchUri = Uri.parse('tel:+94717375582');

                if (await canLaunchUrl(phoneLaunchUri)) {
                  await launchUrl(phoneLaunchUri);
                } else {
                  print('Could not launch $phoneLaunchUri');
                }
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.location_on),
              title: Text(
                'Address',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              subtitle: Text(
                '24/7, Main Street, Colombo, Sri Lanka',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              onTap: () {
                // Handle address tap
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Iconsax.facebook),
              title: Text(
                'Facebook',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              subtitle: Text(
                'Red Zone',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              onTap: () {
                _launchSocialMedia('https://www.facebook.com/6iX9iNE.PiXEL/');
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Iconsax.twitch),
              title: Text(
                'Twitter',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              subtitle: Text(
                '@red_zone',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              onTap: () {},
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Iconsax.instagram),
              title: Text(
                'Instagram',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              subtitle: Text(
                '@red_zone',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              onTap: () {},
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
