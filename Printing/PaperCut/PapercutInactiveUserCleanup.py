import requests
from requests.auth import HTTPBasicAuth
import xmltodict

# Configuration
server_url = "http://papercut:9191/rpc/api/xmlrpc"
admin_username = ""
admin_password = ""
apiToken = ""

# Function to get user list
def get_base_url():
    response = requests.post(server_url,  auth=HTTPBasicAuth(admin_username, admin_password))
    if response: 
        print(response.status_code)
    else:
        print("No error")

def get_user_list():
    request_body = f"""<methodCall>
    <methodName>api.listUserAccounts</methodName>
    <params>
        <param>
            <value>
                <string>{apiToken}</string>
            </value>
        </param>
        <param>
            <value>
                <int>0</int>
            </value>
        </param>
        <param>
            <value>
                <int>10000</int>
            </value>
        </param>
    </params>
    </methodCall>"""

    content = {
        "Content-Type": "text/xml",
        "Content-Length": str(len(request_body))
    }


    response = requests.post(f"{server_url}", auth=HTTPBasicAuth(admin_username, admin_password), headers=content, data=request_body, timeout=10)
    if response:
        return response.content
    else:
        print("Could not get user list.")

def get_user_properties(username, propertyName):
    request_body = f"""<methodCall>
    <methodName>api.getUserProperty</methodName>
    <params>
        <param>
            <value>
                <string>{apiToken}</string>
            </value>
        </param>
        <param>
            <value>
                <string>{username}</string>
            </value>
        </param>
        <param>
            <value>
                <string>{propertyName}</string>
            </value>
        </param>
    </params>
    </methodCall>"""

    content = {
        "Content-Type": "text/xml",
        "Content-Length": str(len(request_body))
    }

    response = requests.post(f"{server_url}", auth=HTTPBasicAuth(admin_username, admin_password), headers=content, data=request_body, timeout=10)
    if response:
        return response.content

# Function to delete a user
def delete_user(username):
    request_body = f"""<methodCall>
    <methodName>api.deleteExistingUser</methodName>
    <params>
        <param>
            <value>
                <string>{apiToken}</string>
            </value>
        </param>
        <param>
            <value>
                <string>{username}</string>
            </value>
        </param>
        <param>
            <value>
                <boolean>0</boolean>
            </value>
        </param>
    </params>
    </methodCall>"""


    content = {
        "Content-Type": "text/xml",
        "Content-Length": str(len(request_body))
    }

    response = requests.post(f"{server_url}", auth=HTTPBasicAuth(admin_username, admin_password), headers=content, data=request_body, timeout=10)
    print("Deleted user: " + username)
    return response.status_code

# Get list of users
userXML = get_user_list()

convertedJSON = xmltodict.parse(userXML)

finalCount = 0

# Logic to select users to delete (e.g., inactive users)
for user in convertedJSON['methodResponse']['params']['param']['value']['array']['data']['value']:
    printCountXML = get_user_properties(user, "print-stats.job-count")
    convertedPrintCountJSON = xmltodict.parse(printCountXML)

    printCount = convertedPrintCountJSON['methodResponse']['params']['param']['value']

    if int(printCount) < 5:
        delete_user(user)
        print("Print count: "+str(printCount))
        finalCount+=1

print("Deleted "+str(finalCount)+" users.")