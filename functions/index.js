// Import dependencies
const functions = require("firebase-functions");
const admin = require("firebase-admin");
const sgMail = require("@sendgrid/mail");

admin.initializeApp();

// Set your SendGrid API Key
sgMail.setApiKey("YOUR_SENDGRID_API_KEY");

// Define your cloud function
exports.sendAppointmentReminder=functions.https.onCall(async (data, context) =>{
  const {email, appointmentDate, appointmentTime} = data;

  const msg = {
    to: email,
    from: "your_verified_sender@example.com",
    subject: "Appointment Reminder",
    text: `This is a reminder of your appointment on ${appointmentDate}` +
      ` at ${appointmentTime}.`,
    html: `<strong>This is a reminder of your appointment ${appointmentDate}`+
      ` at ${appointmentTime}.</strong>`};

  try {
    await sgMail.send(msg);
    return {
      success: true,
      message: "Email sent successfully.",
    };
  } catch (error) {
    console.error("Error sending email:", error);
    return {
      success: false,
      error: error.message,
    };
  }
});
