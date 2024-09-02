import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import { FieldValue } from '@google-cloud/firestore';

admin.initializeApp();
export const deleteAccount = functions
  .region(`europe-west1`)
  .https.onCall(async (data: any) => {
    const userModelId = data.userModelId;
    const promises = [];

    try {
      promises.push(
        admin
          .storage()
          .bucket()
          .deleteFiles({
            prefix: `user_data/${userModelId}/images/profile_photo/profile_photo`,
          })
      );

      promises.push(
        admin
          .storage()
          .bucket()
          .deleteFiles({
            prefix: `user_data/${userModelId}/images/banner_photo/banner_photo`,
          })
      );
      const querySnapshots = await admin
        .firestore()
        .collection(`chats`)
        .where(`participants`, `array-contains`, userModelId)
        .get();

      querySnapshots.forEach((doc) => {
        promises.push(
          doc.ref.update(`participants`, FieldValue.arrayRemove(userModelId)),
          doc.ref.update({
            [`unreadMessageCounterForUser.${userModelId}`]:
              admin.firestore.FieldValue.delete(),
          })
        );
      });

      promises.push(admin.firestore().doc(`users/${userModelId}`).delete());

      promises.push(admin.auth().deleteUser(userModelId));

      await Promise.all(promises);

      return { success: true, message: `Account deleted successfully` };
    } catch (error) {
      console.error(`Error deleting account:`, error);
      return { success: false, message: `Failed to delete account` };
    }
  });
