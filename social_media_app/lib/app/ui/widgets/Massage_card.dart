import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social_media_app/app/data/models/message_model.dart';
import 'package:social_media_app/app/ui/theme/color_palette.dart';

import '../../data/enum/enum.dart';
import '../../utils/Date_time_formate.dart';

class MessageCard extends StatefulWidget {
  const MessageCard({super.key, required this.message, required this.photoUrl});

  final MessageModel message;
  final String photoUrl;

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {

  @override
  Widget build(BuildContext context) {
    bool isMe = FirebaseAuth.instance.currentUser!.uid== widget.message.senderId;
    return InkWell(
        onLongPress: () {
          _showBottomSheet(isMe);
        },
        child: isMe ? _sendMessage() : _receiveMessage());
  }

  // sender or another user message
  Widget _receiveMessage() {
    var mq = MediaQuery.of(context).size;
    //update last read message if sender and receiver are different
    if (widget.message.isRead) {
      //update satatus
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(widget.photoUrl),
            radius: 20,
          ),
          Row(
            children: [
              //message content
              Flexible(
                child: Container(
                  constraints: BoxConstraints(
                      maxWidth: mq.width*0.7,
                      minWidth: mq.width*0.15,
                      maxHeight: mq.height*.4
                  ),
                  padding: EdgeInsets.all(widget.message.contentTypes.first == MessageType.image
                      ? mq.width * .009
                      : mq.width * .04),
                  margin: EdgeInsets.symmetric(
                    horizontal: mq.width * .12,),
                  decoration: const BoxDecoration(
                      color: ColorPalette.textColor,
                      //making borders curved
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: widget.message.contentTypes.first == MessageType.text
                      ?
                  //show text
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for(int i =0 ;i<widget.message.content.length;i++)
                      Text(
                        widget.message.content[i],
                        style: const TextStyle(fontSize: 15, color: Colors.black87),
                      ),
                    ],
                  )
                      :
                  //show image
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for(int i =0 ;i<widget.message.content.length;i++)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(widget.message.content[i]
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: mq.width * .15,top: 4),
            child: Text(
              MyDateUtil.getFormattedTime(
                  context: context, time: widget.message.timestamp.toLocal().toString()),
              style: const TextStyle(fontSize: 12, color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }

  // our or user message
  Widget _sendMessage() {
    print(widget.message.contentTypes.first.index);
    var mq = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Flexible(
              child: Container(
                constraints:  BoxConstraints(
                    maxWidth: mq.width*0.7,
                    minWidth: mq.width*0.15,
                    minHeight: mq.height*.04,
                    maxHeight: mq.height*0.4
                ),
                padding: EdgeInsets.all(widget.message.contentTypes.first == MessageType.image
                    ? mq.width * .009
                    : 10),
                margin: EdgeInsets.symmetric(
                    horizontal: mq.width * .04, vertical: mq.height * .01),
                decoration: const BoxDecoration(
                    color:ColorPalette.primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(20),)),
                child: widget.message.contentTypes.first == MessageType.text ?
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    for(int i =0 ;i<widget.message.content.length;i++)
                    Text(
                      widget.message.content[i],
                      style: const TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ],
                ) : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for(int i =0 ;i<widget.message.content.length;i++)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(widget.message.content[i]
                      ),
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            //for adding some space


            //double tick blue icon for message read
            if (widget.message.isRead)
              const Icon(Icons.done_all_rounded, color: Colors.blue, size: 15),

            //for adding some space
            const SizedBox(width: 2),

            //sent time
            Text(
              MyDateUtil.getFormattedTime(
                  context: context, time: widget.message.timestamp.toLocal().toString()),
              style: const TextStyle(fontSize: 12, color: Colors.black54),
            ),
            SizedBox(width: mq.width * .07),
          ],
        ),
      ],
    );
  }

  // bottom sheet for modifying message details
  void _showBottomSheet(bool isMe) {
    var mq = MediaQuery.of(context).size;
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        builder: (_) {
          return Container(
            color: ColorPalette.mobileBackgroundColor,
            child: ListView(
              shrinkWrap: true,
              children: [
                //black divider
                Container(
                  height: 4,
                  margin: EdgeInsets.symmetric(
                      vertical: mq.height * .015, horizontal: mq.width * .4),
                  decoration: BoxDecoration(
                      color: Colors.grey, borderRadius: BorderRadius.circular(8)),
                ),

                widget.message.contentTypes == MessageType.text
                    ?
                //copy option
                _OptionItem(
                    icon: const Icon(Icons.copy_all_rounded,
                        color: Colors.blue, size: 26),
                    name: 'Copy Text',
                    onTap: () async {
                      await Clipboard.setData(
                          ClipboardData(text: widget.message.content.first))
                          .then((value) {
                        //for hiding bottom sheet
                        Navigator.pop(context);


                      });
                    })
                    :
                //save option
                Container(),

                //separator or divider
                if (isMe)
                  Divider(
                    color: Colors.black54,
                    endIndent: mq.width * .04,
                    indent: mq.width * .04,
                  ),

                // //edit option
                // if (widget.message.type == Type.text && isMe)
                //   _OptionItem(
                //       icon: const Icon(Icons.edit, color: Colors.blue, size: 26),
                //       name: 'Edit Message',
                //       onTap: () {
                //         //for hiding bottom sheet
                //         Navigator.pop(context);
                //
                //       }),

                //delete option
                if (isMe)
                  _OptionItem(
                      icon: const Icon(Icons.delete_forever,
                          color: Colors.red, size: 26),
                      name: 'Delete Message',
                      onTap: () async {

                      }),

                //separator or divider
                Divider(
                  color: Colors.black54,
                  endIndent: mq.width * .04,
                  indent: mq.width * .04,
                ),

                //sent time
                _OptionItem(
                    icon: const Icon(Icons.remove_red_eye, color: Colors.blue),
                    name:
                    'Sent At: ${MyDateUtil.getMessageTime(context: context, time: widget.message.timestamp.toLocal().toString())}',
                    onTap: () {}),

                //read time
                _OptionItem(
                    icon: const Icon(Icons.remove_red_eye, color: Colors.green),
                    name: widget.message.isRead
                        ? 'Read At: Not seen yet'
                        : 'Read At: ${MyDateUtil.getMessageTime(context: context, time: widget.message.toString())}',
                    onTap: () {}),
              ],
            ),
          );
        });
  }

//dialog for updating message content

}

//custom options card (for copy, edit, delete, etc.)
class _OptionItem extends StatelessWidget {
  final Icon icon;
  final String name;
  final VoidCallback onTap;

  const _OptionItem(
      {required this.icon, required this.name, required this.onTap});

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    return InkWell(
        onTap: () => onTap(),
        child: Padding(
          padding: EdgeInsets.only(
              left: mq.width * .05,
              top: mq.height * .015,
              bottom: mq.height * .015),
          child: Row(children: [
            icon,
            Flexible(
                child: Text('    $name',
                    style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black54,
                        letterSpacing: 0.5)))
          ]),
        ));
  }
}