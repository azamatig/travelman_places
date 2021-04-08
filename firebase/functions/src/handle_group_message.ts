import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

export const handleGroupMessage = functions.firestore
  .document("Groups/{groupId}/Messages/{msgId}")
  .onCreate(async (snapshot) => {
    const message = snapshot.data();
    if (!message) {
      console.log("Message", message);
      return;
    }
    const { groupId, senderId, content } = message;
    const group = (
      await admin.firestore().doc(`Groups/${groupId}`).get()
    ).data();
    if (!group) {
      console.log("Group", group);
      return;
    }
    const members: string[] = group.members;
    const mutedFor: string[] = group.mutedFor;
    for (const userId of members) {
      if (mutedFor.includes(userId) || userId === senderId) continue;
      await sendMessage(userId, groupId, group.name, content);
    }
  });

async function sendMessage(
  userId: string,
  groupId: string,
  groupName: string,
  content: string
) {
  const user = (await admin.firestore().doc(`users/${userId}`).get()).data();
  if (!user) {
    console.log("Exist User", user);
    return;
  }

  if (!user.groupsNotify) return;

  const payload: admin.messaging.MessagingPayload = {
    notification: {
      title: "Group: " + groupName,
      body: content
        ? content.length <= 100
          ? content
          : content.substring(0, 97) + "..."
        : "",
      click_action: "FLUTTER_NOTIFICATION_CLICK",
      sound: "default",
    },
    data: {
      groupId,
      groupName,
      senderName: user.name,
    },
  };
  const options: admin.messaging.MessagingOptions = {
    priority: "high",
  };
  const { pushToken } = user;

  return admin
    .messaging()
    .sendToDevice(pushToken, payload, options)
    .catch((e) => {
      console.log("Error Send To Device", e);
    });
}
