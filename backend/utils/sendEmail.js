const nodeMailer = require("nodemailer");
const sendEmail = async (options) => {
  console.log(options);
  const transporter = nodeMailer.createTransport({
    service: process.env.SMTP_Service,
    auth: {
      user: process.env.SMTP_Mail,
      pass: process.env.SMTP_Pass,
    },
  });
  const mailOptions = {
    from: process.env.SMTP_Mail,
    to: options.email,
    subject: options.subject,
    text: options.message,
  };
  await transporter.sendMail(mailOptions);
};
module.exports = sendEmail;
