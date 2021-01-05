import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

export const sendMsgNotifications = functions.firestore
  .document("chats/{chatId}/messages/{msgId}")
  .onCreate(async (snapshot, cxt) => {
    // const {chatId,msgId} = context.params;
    const message = snapshot.data();
    if (!message) return;
    const { senderId, senderName, sendTo } = message;
    const user = (
      await admin
        .firestore()
        .doc("users/" + sendTo)
        .get()
    ).data();
    if (!user) return;

    const { pushToken, chatNotify } = user;

    if (!chatNotify) return;

    const payload: admin.messaging.MessagingPayload = {
      notification: {
        title: getTitle(senderName, message),
        body: getBody(message),
        icon: "./imgs/logo.png",
        click_action: "FLUTTER_NOTIFICATION_CLICK",
        sound: "default",
      },
      data: {
        senderId,
        senderName,
      },
    };
    const options: admin.messaging.MessagingOptions = {
      priority: "high",
    };

    return admin
      .messaging()
      .sendToDevice(pushToken, payload, options)
      .catch((e) => {
        console.log("Error Send To Device", e);
      });
  });

// get title based on message type
function getTitle(
  senderName: string,
  message: { [x: string]: any; type?: any }
) {
  let title = senderName;
  switch (message.type) {
    // text
    case 0:
      title += " sent you a message.";
      break;
    // image
    case 1:
      title += " sent you an image.";
      break;
    // voice
    case 2:
      title += " sent you a voice.";
      break;
    // video
    case 3:
      title += " sent you a video.";
      break;
    default:
      title = title;
  }
  return title;
}

// get body based on message type
function getBody(message: { [x: string]: any; type?: any }) {
  let body = "";
  switch (message.type) {
    // text
    case 0:
      body = message.content
        ? message.content.length <= 100
          ? message.content
          : message.content.substring(0, 97) + "..."
        : "";
      break;
    // image
    case 1:
      body = "Image";
      break;
    // voice
    case 2:
      body = "Voice";
      break;
    // video
    case 3:
      body = "Video";
      break;
    default:
  }
  return body;
}
