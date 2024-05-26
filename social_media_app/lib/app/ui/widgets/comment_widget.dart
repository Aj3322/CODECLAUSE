import 'package:flutter/material.dart';
import 'package:social_media_app/app/data/models/comment_model.dart';
import 'package:social_media_app/app/ui/theme/color_palette.dart';
class CommentCard extends StatelessWidget {
  final CommentModel commentModel;
  const CommentCard({Key? key, required this.commentModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 8),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(40)),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 13),
          color: ColorPalette.textColor,
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                  commentModel.userAvatarUrl,
                ),
                radius: 18,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text:commentModel.username,
                                style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.black)
                            ),
                            TextSpan(
                                text: commentModel.content,
                                style: const TextStyle(color: Colors.black45)
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                            commentModel.timestamp.toString(),
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w400,color: Colors.cyan),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: const Icon(
                  Icons.favorite,
                  size: 16,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}