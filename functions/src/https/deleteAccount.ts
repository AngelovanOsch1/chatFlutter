import * as functions from 'firebase-functions';
export const deleteAccount = functions
  .region('europe-west1')
  .https.onCall((data, context) => {
    functions.logger.log(data);
  });
