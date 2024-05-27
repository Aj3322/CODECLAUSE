import 'package:flutter/material.dart';
import 'package:social_media_app/app/data/models/comment_model.dart';
import 'package:social_media_app/app/ui/theme/color_palette.dart';

import '../../utils/Date_time_formate.dart';
class CommentCard extends StatelessWidget {
  final CommentModel commentModel;
  const CommentCard({Key? key, required this.commentModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 8),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(40)),
        child: Card(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 13),
            decoration: BoxDecoration(
              gradient: isDarkMode
                  ? null
                  : LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
                colors: ColorPalette.linearColor,
              ),
            ),
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
                                  style: TextStyle(fontWeight: FontWeight.bold,color:isDarkMode?Colors.white: Colors.black)
                              ),
                              TextSpan(
                                  text: MyDateUtil().getFormattedTime(context: context, time:commentModel.timestamp.toLocal().toString()),

                                  style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w400,color:isDarkMode?Colors.grey:  Colors.black)
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            commentModel.content,
                            style:  TextStyle(color:isDarkMode?Colors.white:  Colors.black45),
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
      ),
    );
  }
}