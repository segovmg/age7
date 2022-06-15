import sys
import smtplib
from email.message import EmailMessage

def send_mail(EMAIL_USER, EMAIL_PASSWORD):
  msg = EmailMessage()
  msg['Subject'] = 'Atualizacao age7'
  msg['From'] = EMAIL_USER
  msg['To'] = EMAIL_USER
  msg.set_content('''
    Olá 
    Segue link de validação age7

    https://transparencia-mg.github.io/age7/
    '''
    )
  with smtplib.SMTP_SSL("smtp.gmail.com", 465) as smtp:
    smtp.starttls()
    smtp.ehlo()
    smtp.login(EMAIL_USER, EMAIL_PASSWORD)
    smtp.send_message(msg)

if __name__ == '__main__':
  send_mail(sys.argv[1], sys.argv[2])