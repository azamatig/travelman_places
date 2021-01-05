import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

export const onProfileEdit = functions.firestore
  .document("users/{userId}")
  .onUpdate(async (change, context) => {
    const userId = context.params["userId"];
    if (!userId) {
      console.log("--Error with userId", userId);
      return;
    }
    const photoUrlAfter: string = change.after.data()?.["photoUrl"];
    const photoUrlBefore: string = change.before.data()?.["photoUrl"];

    const userNameAfter: string = change.after.data()?.["name"];
    const userNameBefore: string = change.before.data()?.["name"];
    if (userNameAfter !== userNameBefore || photoUrlAfter !== photoUrlBefore) {
      await handleProfileEdit(userId, userNameAfter, photoUrlAfter);
    }
  });

async function handleProfileEdit(
  userId: string,
  authorName: string,
  authorPhotoUrl: string
) {
  const posts = (
    await admin
      .firestore()
      .collection("posts")
      .where("authorId", "==", userId)
      .get()
  ).docs;

  for (const doc in posts) {
    if (posts.hasOwnProperty(doc)) {
      const post = posts[doc];
      await post.ref.update({ authorName, authorPhotoUrl });
    }
  }

  const comments = (
    await admin
      .firestore()
      .collection("comments/{commentId}")
      .where("authorId", "==", userId)
      .get()
  ).docs;
  for (const doc in comments) {
    if (comments.hasOwnProperty(doc)) {
      const comment = comments[doc];
      await comment.ref.update({ authorName, authorPhotoUrl });
    }
  }
}
