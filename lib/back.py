#from __future__ import print_function
from flask import Flask, jsonify, request,json

import os.path

from google.auth.transport.requests import Request
from google.oauth2.credentials import Credentials
from google_auth_oauthlib.flow import InstalledAppFlow
from googleapiclient.discovery import build
from googleapiclient.errors import HttpError
import base64
from bs4 import BeautifulSoup

# If modifying these scopes, delete the file token.json.
SCOPES = ['https://www.googleapis.com/auth/gmail.readonly']

app=Flask(__name__)

cwd=os.getcwd()
cwd+=r'\lib'

@app.route("/checkAccount", methods=["POST"])
def checkAccount():
    global creds
    creds=None

    try:
        if os.path.exists(rf'{cwd}\token.json'):
            creds = Credentials.from_authorized_user_file(rf'{cwd}\token.json', SCOPES)
        else:
            return jsonify({'statusCode': 100, 'error': "token.json does not exist"})
        # If there are no (valid) credentials available, let the user log in.
        if not creds or not creds.valid:
            return jsonify({'statusCode': 200})
        return jsonify({'statusCode':100})
    except Exception as error:
        return jsonify({'statusCode': 100,'error':error})

@app.route("/signIn", methods=["POST"])
def signIn():
    global creds
    creds=None
    try:
        if os.path.exists(rf'{cwd}\token.json'):
            creds = Credentials.from_authorized_user_file(rf'{cwd}\token.json', SCOPES)
        # If there are no (valid) credentials available, let the user log in.
        if not creds or not creds.valid:
            if creds and creds.expired and creds.refresh_token:
                creds.refresh(Request())
            else:
                flow = InstalledAppFlow.from_client_secrets_file(
                    rf'{cwd}\credentials.json', SCOPES)
                creds = flow.run_local_server(port=0)
            # Save the credentials  for the next run
            with open(rf'{cwd}\token.json', 'w') as token:
                token.write(creds.to_json())
        return jsonify({'statusCode': 200, 'result': "Signed in succesfully"})
    except Exception as error:
        return jsonify({'statusCode': 100,'error':error})


@app.route("/", methods=["GET"])
def primary():

    # global creds
    # creds=Credentials(user_id)
    # The file token.json stores the user's access and refresh tokens, and is
    # created automatically when the authorization flow completes for the first
    # time.
    # if os.path.exists(rf'{cwd}\token.json'):
    #     creds = Credentials.from_authorized_user_file(rf'{cwd}\token.json', SCOPES)
    # # If there are no (valid) credentials available, let the user log in.
    # if not creds or not creds.valid:
    #     if creds and creds.expired and creds.refresh_token:
    #     #     creds.refresh(Request())
    #     # else:
    #         flow = InstalledAppFlow.from_client_secrets_file(
    #             rf'{cwd}\credentials.json', SCOPES)
    #         creds = flow.run_local_server(port=0)
    #     # Save the credentials  for the next run
    #     with open(rf'{cwd}\token.json', 'w') as token:
    #         token.write(creds.to_json())

    try:
        service= build('gmail', 'v1', credentials=creds)
        results=service.users().messages().list(userId='me', maxResults=50)   
        messagesids=results.execute().get('messages')
        Sender=[]
        Subject=[]
        Payload=[]
        Body=[]
        if not messagesids:
            print(f"No messages found")
            return
        else:
            """msg=[]
            for message in messagesids:
                msg+=service.users().messages().get(userId='me',id=message['id']).execute()
        print(type(msg))"""

            for messages in messagesids:
                msg=service.users().messages().get(userId='me',id=messages['id']).execute()
                payload = msg['payload']
                headers = payload['headers']
      
                # Look for Subject and Sender Email in the headers
                for d in headers:
                    if d['name'] == 'Subject':
                        subject = d['value']
                    if d['name'] == 'From':
                        sender = d['value']
      
                # The Body of the message is in Encrypted format. So, we have to decode it.
                # Get the data and decode it with base 64 decoder.
                if(payload.get('parts')==None):
                    continue
                # try:
                #     parts = payload.get('parts')[0]
                #     data = parts['body']['data']
                #     data = data.replace("-","+").replace("_","/")
                #     decoded_data = base64.b64decode(data)
                # except:
                #     continue
      
                # # Now, the data obtained is in lxml. So, we will parse 
                # # it with BeautifulSoup library
                # soup = BeautifulSoup(decoded_data , "lxml")
                # body = soup.body().text()
                
                Subject.append(subject)
                Sender.append(sender)
                Payload.append(payload)
                # Body.append(body)

    except HttpError as error:
        print(f"An error occured {error}")

    except:
        pass

    return jsonify({'Subject': Subject,'Sender':Sender,'Msg':Payload})
    #i=0
    # try:
    #     for sub in Subject:
    #         print("Subject: ",sub)
    #         print("Sender: ",Sender[i])
    #         print("Body: ",Body[i])
    #         print("\n")
    #         i+=1
        
    # except Exception as er:
    #     print(f"An error has occured {er}")


@app.route("/spam",methods=['GET'])
def spam():
    # creds = Credentials(user_id)
    # The file token.json stores the user's access and refresh tokens, and is
    # created automatically when the authorization flow completes for the first
    # time.
    # cwd=os.getcwd()
    # cwd+=r'\lib'
    # if os.path.exists(rf'{cwd}\token.json'):
    #     creds = Credentials.from_authorized_user_file(rf'{cwd}\token.json', SCOPES)
    # # If there are no (valid) credentials available, let the user log in.
    # if not creds or not creds.valid:
    #     if creds and creds.expired and creds.refresh_token:
    #         creds.refresh(Request())
    #     else:
    #         flow = InstalledAppFlow.from_client_secrets_file(
    #             rf'{cwd}\credentials.json', SCOPES)
    #         creds = flow.run_local_server(port=0)
    #     # Save the credentials  for the next run
    #     with open(rf'{cwd}\token.json', 'w') as token:
    #         token.write(creds.to_json())

    try:
        service= build('gmail', 'v1', credentials=creds)
        results=service.users().messages().list(userId='me', maxResults=50, labelIds=["SPAM"])   
        messagesids=results.execute().get('messages')
        Sender=[]
        Subject=[]
        Payload=[]
        Body=[]
        if not messagesids:
            print(f"No messages found")
            return
        else:
            """msg=[]
            for message in messagesids:
                msg+=service.users().messages().get(userId='me',id=message['id']).execute()
        print(type(msg))"""

            for messages in messagesids:
                msg=service.users().messages().get(userId='me',id=messages['id']).execute()
                payload = msg['payload']
                headers = payload['headers']
      
                # Look for Subject and Sender Email in the headers
                for d in headers:
                    if d['name'] == 'Subject':
                        subject = d['value']
                    if d['name'] == 'From':
                        sender = d['value']
      
                # The Body of the message is in Encrypted format. So, we have to decode it.
                # Get the data and decode it with base 64 decoder.
                if(payload.get('parts')==None):
                    continue
                # try:
                #     parts = payload.get('parts')[0]
                #     data = parts['body']['data']
                #     data = data.replace("-","+").replace("_","/")
                #     decoded_data = base64.b64decode(data)
                # except:
                #     continue
      
                # # Now, the data obtained is in lxml. So, we will parse 
                # # it with BeautifulSoup library
                # soup = BeautifulSoup(decoded_data , "lxml")
                # body = soup.body()
                
                Subject.append(subject)
                Sender.append(sender)
                Payload.append(payload)
                # Body.append(body)

    except HttpError as error:
        print(f"An error occured {error}")

    except:
        pass

    return jsonify({'Subject': Subject,'Sender':Sender,'Payload':Payload})

@app.route("/important",methods=['GET'])
def important():
    # creds = Credentials(user_id)
    # The file token.json stores the user's access and refresh tokens, and is
    # created automatically when the authorization flow completes for the first
    # time.
    # cwd=os.getcwd()
    # cwd+=r'\lib'
    # if os.path.exists(rf'{cwd}\token.json'):
    #     creds = Credentials.from_authorized_user_file(rf'{cwd}\token.json', SCOPES)
    # # If there are no (valid) credentials available, let the user log in.
    # if not creds or not creds.valid:
    #     if creds and creds.expired and creds.refresh_token:
    #         creds.refresh(Request())
    #     else:
    #         flow = InstalledAppFlow.from_client_secrets_file(
    #             rf'{cwd}\credentials.json', SCOPES)
    #         creds = flow.run_local_server(port=0)
    #     # Save the credentials  for the next run
    #     with open(rf'{cwd}\token.json', 'w') as token:
    #         token.write(creds.to_json())

    try:
        service= build('gmail', 'v1', credentials=creds)
        results=service.users().messages().list(userId='me', maxResults=50, labelIds=["IMPORTANT"])   
        messagesids=results.execute().get('messages')
        Sender=[]
        Subject=[]
        msgId=[]
        #Body=[]
        if not messagesids:
            print(f"No messages found")
            return
        else:
            """msg=[]
            for message in messagesids:
                msg+=service.users().messages().get(userId='me',id=message['id']).execute()
        print(type(msg))"""

            for messages in messagesids:
                msg=service.users().messages().get(userId='me',id=messages['id']).execute()
                payload = msg['payload']
                headers = payload['headers']
      
                # Look for Subject and Sender Email in the headers
                for d in headers:
                    if d['name'] == 'Subject':
                        subject = d['value']
                    if d['name'] == 'From':
                        sender = d['value']
      
                # The Body of the message is in Encrypted format. So, we have to decode it.
                # Get the data and decode it with base 64 decoder.
                if(payload.get('parts')==None):
                    continue
                parts = payload['parts']
                html_part = next(part for part in parts if part['mimeType'] == 'text/html')
                html_content = base64.urlsafe_b64decode(html_part['body']['data']).decode('utf-8')
                # try:
                #     parts = payload.get('parts')[0]
                #     data = parts['body']['data']
                #     data = data.replace("-","+").replace("_","/")
                #     decoded_data = base64.b64decode(data)
                # except:
                #     continue
      
                # # Now, the data obtained is in lxml. So, we will parse 
                # # it with BeautifulSoup library
                # soup = BeautifulSoup(decoded_data , "lxml")
                # body = soup.body()
                
                Subject.append(subject)
                Sender.append(sender)
                #Msg.append(msg)
                msgId.append(messages['id'])

    except HttpError as error:
        print(f"An error occured {error}")

    except:
        pass

    return jsonify({'Subject': Subject,'Sender':Sender,'msgId':msgId})

@app.route("/starred",methods=['GET'])
def starred():
    # creds = Credentials(user_id)
    # The file token.json stores the user's access and refresh tokens, and is
    # created automatically when the authorization flow completes for the first
    # time.
    # cwd=os.getcwd()
    # cwd+=r'\lib'
    # if os.path.exists(rf'{cwd}\token.json'):
    #     creds = Credentials.from_authorized_user_file(rf'{cwd}\token.json', SCOPES)
    # # If there are no (valid) credentials available, let the user log in.
    # if not creds or not creds.valid:
    #     if creds and creds.expired and creds.refresh_token:
    #         creds.refresh(Request())
    #     else:
    #         flow = InstalledAppFlow.from_client_secrets_file(
    #             rf'{cwd}\credentials.json', SCOPES)
    #         creds = flow.run_local_server(port=0)
    #     # Save the credentials  for the next run
    #     with open(rf'{cwd}\token.json', 'w') as token:
    #         token.write(creds.to_json())

    try:
        service= build('gmail', 'v1', credentials=creds)
        results=service.users().messages().list(userId='me', maxResults=50, labelIds=["STARRED"])   
        messagesids=results.execute().get('messages')
        Sender=[]
        Subject=[]
        Payload=[]
        Body=[]
        if not messagesids:
            print(f"No messages found")
            return "404"
        else:
            """msg=[]
            for message in messagesids:
                msg+=service.users().messages().get(userId='me',id=message['id']).execute()
        print(type(msg))"""

            for messages in messagesids:
                msg=service.users().messages().get(userId='me',id=messages['id']).execute()
                payload = msg['payload']
                headers = payload['headers']
      
                # Look for Subject and Sender Email in the headers
                for d in headers:
                    if d['name'] == 'Subject':
                        subject = d['value']
                    if d['name'] == 'From':
                        sender = d['value']
      
                # The Body of the message is in Encrypted format. So, we have to decode it.
                # Get the data and decode it with base 64 decoder.
                if(payload.get('parts')==None):
                    continue
                try:
                    parts = payload.get('parts')[0]
                    data = parts['body']['data']
                    data = data.replace("-","+").replace("_","/")
                    decoded_data = base64.b64decode(data)
                except:
                    continue
      
                # Now, the data obtained is in lxml. So, we will parse 
                # it with BeautifulSoup library
                soup = BeautifulSoup(decoded_data , "lxml")
                body = soup.body()
                
                Subject.append(subject)
                Sender.append(sender)
                Payload.append(payload)
                # Body.append(body)

    except HttpError as error:
        print(f"An error occured {error}")

    except:
        pass

    return jsonify({'Subject': Subject,'Sender':Sender,'Payload':Payload})

message=""
@app.route("/messages", methods=['POST','GET'])
def messages():
    if(request.method=="POST"):
        global message
        request_data=request.data
        request_data=json.loads(request_data.decode('utf-8'))
        data=request_data['msgId']
        # creds = Credentials.from_authorized_user_file(rf'{cwd}\token.json', SCOPES)
        service= build('gmail', 'v1', credentials=creds)
        msg=service.users().messages().get(userId='me',id=data).execute()
        payload = msg['payload']
        try:
            parts = payload.get('parts')[0]
            data = parts['body']['data']
            data = data.replace("-","+").replace("_","/")
            message=data
            # decoded_data = base64.b64decode(data)
            # message=decoded_data
            # message = decoded_data.decode('utf-8')
        except:
            message="There's no message"
            pass
        return 

    # Now, the data obtained is in lxml. So, we will parse 
    # it with BeautifulSoup library
    # soup = BeautifulSoup(decoded_data , "lxml")
    # body = soup.body()
    if(request.method=="GET"):
        return jsonify({"body":message})
    
    

if __name__ == '__main__':
    app.run(debug=True)

