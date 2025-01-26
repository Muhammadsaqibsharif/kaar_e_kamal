import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:kaar_e_kamal/widgets/user/social_engagement/post_widget.dart';

class PostSharingScreen extends StatelessWidget {
  // Function to handle sharing posts on social media
  Future<void> sharePost(String postImage) async {
    await FlutterShare.share(
      title: 'Share Your Donation',
      text:
          'I just made a donation to a great cause! Join me in supporting the community. $postImage',
      linkUrl: 'https://example.com/donation',
      chooserTitle: 'Share your donation on social media',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Sharing'),
        centerTitle: true,
        elevation: 5,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Share your donation post to encourage others to contribute!',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),

            // Post 1
            PostWidget(
              image: 'assets/Images/1.jpg',
              postCaption:
                  'Join me in supporting this cause by donating today!',
              sharePost: sharePost,
            ),

            SizedBox(height: 20),

            // Post 2
            PostWidget(
              image: 'assets/Images/2.jpg',
              postCaption: 'Every little bit counts! Let\'s make a difference.',
              sharePost: sharePost,
            ),

            SizedBox(height: 20),

            // Post 3
            PostWidget(
              image: 'assets/Images/3.jpg',
              postCaption: 'I just made my donation. Will you join me?',
              sharePost: sharePost,
            ),
          ],
        ),
      ),
    );
  }
}
