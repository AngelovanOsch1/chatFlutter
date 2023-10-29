import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
admin.initializeApp();


exports.checkHealth = functions.https.onCall(async (data, context) => {
  return 'test';
});

exports.sendNotifications = functions.https.onCall(async (data, context) => {const title = data.title});
