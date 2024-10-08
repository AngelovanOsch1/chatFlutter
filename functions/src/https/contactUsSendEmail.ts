import * as functions from 'firebase-functions';
import * as nodemailer from 'nodemailer';
import * as dotenv from 'dotenv';
import { ContactUsSendEmail } from '../interfaces';

dotenv.config();

export const contactUsSendEmail = functions
  .region(`europe-west1`)
  .https.onCall(async (data: ContactUsSendEmail) => {
    const transporter = nodemailer.createTransport({
      host: `smtp.gmail.com`,
      port: 465,
      secure: true,
      auth: {
        user: process.env.HOTMAIL_USER,
        pass: process.env.HOTMAIL_PASS,
      },
    });

    const mailData = {
      from: process.env.HOTMAIL_USER,
      to: process.env.HOTMAIL_USER,
      subject: `Message from ${data.email}`,
      text: `From: ${data.email}\n\nMessage: ${data.message}`,
    };

    try {
      const info = await transporter.sendMail(mailData);
      console.log(`Email sent:`, info.response);
      return { success: true, message: `Email sent successfully` };
    } catch (error) {
      console.error(`Error sending email:`, error);
      return { success: false, message: `Failed to send email` };
    }
  });
