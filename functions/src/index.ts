import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
admin.initializeApp();

exports.updateEmail = functions
  .region('europe-west1')
  .https.onRequest(async (data, context) => {
    functions.logger.log('test');
  });
