package org.gdf;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

public class EmailTester {
	
	public static void main(String... args) {
		Properties properties=new Properties();
		properties.put("mail.smtp.host", "localhost");
		properties.put("mail.smtp.port", "25");
		properties.put("mail.smtp.user", "admin@gdfnow.org");
		properties.put("mail.transport.protocol", "smtp");
		
		Session session=Session.getDefaultInstance(properties);
		 
		try {
			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress("from@gmail.com"));
			message.setRecipients(
			  Message.RecipientType.TO, InternetAddress.parse("to@gmail.com"));
			message.setSubject("Mail Subject");

			String msg = "This is my first email using JavaMailer";

			MimeBodyPart mimeBodyPart = new MimeBodyPart();
			mimeBodyPart.setContent(msg, "text/html; charset=utf-8");

			Multipart multipart = new MimeMultipart();
			multipart.addBodyPart(mimeBodyPart);

			message.setContent(multipart);

			Transport.send(message);
		} catch (MessagingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}  
		
		
		
		
	}

}
