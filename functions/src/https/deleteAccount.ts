import * as functions from 'firebase-functions';
export const deleteAccount = functions.region('europe-west1').https.onCall((data) => {
  functions.logger.log(data);
});
