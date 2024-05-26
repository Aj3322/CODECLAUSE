import '../models/comment_model.dart';
import '../models/message_model.dart';
import '../models/notfication_model.dart';
import '../models/post_model.dart';

enum PostType {
  text,
  image,
  video,
}

enum MessageType {
  text,
  image,
  video,
  file,
  audio,
}


// Example usage

// Single image post
Post imagePost = Post(
  postId: 'unique_image_post_id',
  uid: 'user_id',
  username: 'username',
  profilePicUrl: 'profile_pic_url',
  content: ['image_url'],
  caption: 'This is an image post',
  likes: [],
  comments: [],
  createdAt: DateTime.now(),
  postTypeIndex: PostType.image.index,
  privacy: 'public',
);

// Multiple images post
Post multipleImagePost = Post(
  postId: 'unique_multiple_image_post_id',
  uid: 'user_id',
  username: 'username',
  profilePicUrl: 'profile_pic_url',
  content: ['image_url1', 'image_url2', 'image_url3'],
  caption: 'This is a multiple image post',
  likes: [],
  comments: [],
  createdAt: DateTime.now(),
  postTypeIndex: PostType.image.index,
  privacy: 'public',
);

// Text post
Post textPost = Post(
  postId: 'unique_text_post_id',
  uid: 'user_id',
  username: 'username',
  profilePicUrl: 'profile_pic_url',
  content: ['This is a text post'],
  caption: 'This is a caption for a text post',
  likes: [],
  comments: [],
  createdAt: DateTime.now(),
  postTypeIndex: PostType.text.index,
  privacy: 'public',
);

// Video post
Post videoPost = Post(
  postId: 'unique_video_post_id',
  uid: 'user_id',
  username: 'username',
  profilePicUrl: 'profile_pic_url',
  content: ['video_url'],
  caption: 'This is a video post',
  likes: [],
  comments: [],
  createdAt: DateTime.now(),
  postTypeIndex: PostType.video.index,
  privacy: 'public',
);



// Example usage

// Text and image message
MessageModel textAndImageMessage = MessageModel(
  messageId: 'unique_text_and_image_message_id',
  senderId: 'sender_user_id',
  receiverId: 'receiver_user_id',
  senderUsername: 'sender_username',
  receiverUsername: 'receiver_username',
  content: ['Hello, how are you?', 'image_url'],
  contentTypes: [MessageType.text, MessageType.image],
  timestamp: DateTime.now(),
  isRead: false,
  isDelivered: true,
);

// Multiple images message
MessageModel multipleImagesMessage = MessageModel(
  messageId: 'unique_multiple_images_message_id',
  senderId: 'sender_user_id',
  receiverId: 'receiver_user_id',
  senderUsername: 'sender_username',
  receiverUsername: 'receiver_username',
  content: ['image_url1', 'image_url2', 'image_url3'],
  contentTypes: [MessageType.image, MessageType.image, MessageType.image],
  timestamp: DateTime.now(),
  isRead: false,
  isDelivered: true,
);

// Video and text message
MessageModel videoAndTextMessage = MessageModel(
  messageId: 'unique_video_and_text_message_id',
  senderId: 'sender_user_id',
  receiverId: 'receiver_user_id',
  senderUsername: 'sender_username',
  receiverUsername: 'receiver_username',
  content: ['video_url', 'This is a video message'],
  contentTypes: [MessageType.video, MessageType.text],
  timestamp: DateTime.now(),
  isRead: false,
  isDelivered: true,
);


// Example usage

// Main comment
CommentModel mainComment = CommentModel(
  commentId: 'unique_main_comment_id',
  postId: 'related_post_id',
  userId: 'commenter_user_id',
  username: 'commenter_username',
  userAvatarUrl: 'user_avatar_url',
  content: 'This is the main comment',
  timestamp: DateTime.now(),
  likes: 0,
  replies: [],
  isEdited: false,
  isDeleted: false,
);

// Reply to the main comment
CommentModel replyComment = CommentModel(
  commentId: 'unique_reply_comment_id',
  postId: 'related_post_id',
  userId: 'reply_user_id',
  username: 'reply_username',
  userAvatarUrl: 'reply_user_avatar_url',
  content: 'This is a reply to the main comment',
  timestamp: DateTime.now(),
  likes: 0,
  replies: [],
  isEdited: false,
  isDeleted: false,
);

// Add the reply to the main comment's replies
// mainComment.replies.add(replyComment);
// Example usage

// Create a new notification
NotificationModel newNotification = NotificationModel(
  notificationId: 'unique_notification_id',
  userId: 'recipient_user_id',
  content: 'User X liked your post',
  timestamp: DateTime.now(),
  seen: false,
  type: 'like',
  postId: 'related_post_id',
  senderId: 'sender_user_id',
);

// Add the notification to Firestore
// await addNotification(newNotification);
