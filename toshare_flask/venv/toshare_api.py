from asyncio.windows_events import NULL
from logging import StrFormatStyle
from xmlrpc.client import DateTime
from flask import Flask, make_response, request, json, jsonify, render_template, send_from_directory, redirect, url_for, session
from flask_cors import CORS
from SQL_DataModels import userTable, user_rent
import pyodbc
from datetime import date, datetime

app = Flask(__name__)
CORS(app)


#Fununction used to make the connection with the server
#def connection():
#    server = 'DAN_PC\SQLEXPRESS' #MODEM-01\SQLEXPRESS #DAN_PC\SQLEXPRESS
#    database = 'generic_inventory' 
#    user = 'server' #webserver #server
#    password = 'password' 
#    conn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};SERVER='+server+';DATABASE='+database+';Trusted_connection=yes') #UID='+user+';PWD='+password
#    return conn


def connection():
    server = 'MODEM-01\SQLEXPRESS'
    database = 'generic_inventory' 
    user = 'webserver' 
    password = 'password' 
    conn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};SERVER='+server+';DATABASE='+database+';UID='+user+';PWD='+password)
    return conn


#class usertable:
 #   def __init__(self, id, name, surname, user_type, usr, pwd, card_id):
  #      self.id = id
  #      self.name = name
  #      self.surname = surname
  #      self.user_type = user_type
  #      self.usr = usr
  #      self.pwd = pwd
  #      self.card_id = card_id

#############################################################
FLUTTER_WEB_APP = 'templates'

@app.route('/')
def render_page_web():
    return render_template('index.html')


@app.route('/<path:name>')
def return_flutter_doc(name):

    datalist = str(name).split('/')
    DIR_NAME = FLUTTER_WEB_APP

    if len(datalist) > 1:
        for i in range(0, len(datalist) - 1):
            DIR_NAME += '/' + datalist[i]

    return send_from_directory(DIR_NAME, datalist[-1])

###########################################################

#@app.route("/login", methods=["POST", "GET"])  
#def login():
#        return render_template("index.html")

#@app.route("/register", methods=["POST", "GET"])  
#def register():
#        return render_template("index.html")

@app.route("/totem", methods=["POST", "GET"])  
def totem():
    row={}
    if request.method == "POST":
        serial = request.form["serial"]
        conn = connection()
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM dbo.totems_to_customers where totem_id=(?)",  serial)
        row = cursor.fetchall()     #i suppose there is only one row for each totem in the table
        
        if (not bool(row)):     #if there is no row associated to the serial number
            cursor.execute("""INSERT INTO dbo.totems_to_customers (totem_id) values ( ?)""", (serial))
            conn.commit()
            conn.close()
            return jsonify(["Totem not linked"])
        elif (row[0][2] == None) :    #if a customer_id is not associated to the totem_id
            print(bool(row))
            if (request.form["link_request"] == "true"):    
                customer_code = request.form["customer_code"]
                cursor.execute("SELECT * FROM dbo.users_to_customercodes where customer_code=(?)",  customer_code)
                row = cursor.fetchall()
                print(row)
                if bool(row):     #if there is a customer with the given customer code
                    cursor.execute("""UPDATE dbo.totems_to_customers SET customer_code = (?) WHERE totem_id = (?)""", (customer_code, serial))
                    cursor.commit()
                    print("table updating")
                    conn.close()
                    return jsonify(["Totem linked to customer"])
                else:
                    conn.close()
                    return jsonify(["Customer code doesn't exist"])
            else:   #there is no link request and the totem is not associated
                conn.close()
                return jsonify(["Totem not linked"])
        else:   #totem associated to a customer. Watchout there is no control on a specific customer yet
            conn.close()
            return jsonify(["Totem linked to customer"])       
    else:
        return render_template("index.html")

@app.route('/login', methods=["GET", "POST"])
def login():
    d = {}
    if request.method == "POST":
        email = request.form["email"]
        password = request.form["password"]
        conn = connection()
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM dbo.users")

        for row in cursor.fetchall():
            #print(row)
            if ((email == row[4]) and (password == row[5])) :
                #conn.close()
                #user_id = row[0]
                if(row[3] == 'User'):
                    conn.close()
                    return jsonify(["Success User", {'user_id' :row[0]}])
                elif(row[3] == 'Customer'):
                    conn.close()                 
                    return jsonify(["Success Customer", {'user_id' :row[0]}])
                elif(row[3] == 'Admin'):
                    conn.close()
                    return jsonify(["Success Admin", {'user_id' :row[0]}])
        return jsonify(["Invalid Credentials"])

    else: 
        return render_template('index.html')

@app.route('/loginwithrfid', methods=["GET", "POST"])
def loginwithrfid():
    if request.method == "POST":
        cardid = request.form["rfidvalue"]
        serial = request.form["serial"]
        conn = connection()
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM dbo.users")
        for row in cursor.fetchall():
            #print(row)
            if ((cardid == row[6])) :
                #conn.close()
                #user_id = row[0]
                if(row[3] == 'User'):
                    conn.close()
                    return jsonify(["Success User", {'user_id' :row[0]}])
                elif(row[3] == 'Customer'):
                    cursor.execute("SELECT customer_code FROM dbo.users_to_customercodes where user_id=(?)",  row[0])
                    customer_code = cursor.fetchall()
                    cursor.execute("SELECT totem_id FROM dbo.totems_to_customers where customer_code=(?)",  customer_code[0][0])
                    totem_ids = cursor.fetchall()
                    conn.close()
                    for row in totem_ids:
                        if row[0] == serial:
                            return jsonify(["Success Customer", {'user_id' :row[0]}])
                    return jsonify(["Invalid Credentials"])
                elif(row[3] == 'Admin'):
                    conn.close()
                    return jsonify(["Success Admin", {'user_id' :row[0]}])
        return jsonify(["Invalid Credentials"])

    else: 
        return render_template('index.html')

@app.route('/register', methods=["GET", "POST"])
def register():
    d={}
    if request.method =="POST":
        name = request.form["name"]
        surname = request.form["surname"]
        email = request.form["email"]
        password = request.form["password"]
        repassword = request.form["rewrite password"]
        print(name, surname, email, password, repassword)
        conn = connection()
        cursor = conn.cursor()
        cursor.execute("""INSERT INTO dbo.users (name, surname, user_type, usr, pwd) values ( ?, ?, ?, ?, ?)""", (name, surname, 'User', email, password))
        conn.commit()
        return jsonify(["success"])

    else: 
        return render_template("index.html")

@app.route('/adduser', methods=["GET", "POST"])
def adduser():
    d={}
    if request.method =="POST":
        name = request.form["name"]
        surname = request.form["surname"]
        email = request.form["email"]
        cardid = request.form["cardid"]
        password = request.form["password"]
        usertype = request.form["usertype"]
        print(name, surname, email, cardid, password, usertype)
        conn = connection()
        cursor = conn.cursor()
        cursor.execute("""INSERT INTO dbo.users (name, surname, user_type, usr, pwd, card_id) values ( ?, ?, ?, ?, ?, ?)""", (name, surname, usertype, email, password, cardid))
        conn.commit()
        return jsonify(["success"])

    else: 
        return render_template("index.html")

@app.route('/edituser', methods=["GET", "POST"])
def edituser():
    d={}
    if request.method =="POST":
        print("HELLOOOOO")
        id = request.form ["id"]
        name = request.form["name"]
        surname = request.form["surname"]
        email = request.form["usr"]
        cardid = request.form["card_id"]
        password = request.form["pwd"]
        usertype = request.form["user_type"]
        
        conn = connection()
        cursor = conn.cursor()
        cursor.execute("""UPDATE dbo.users SET name = ?, surname = ?, usr = ?, card_id = ?, pwd = ?, user_type = ? where id = ?""", (name, surname, email, cardid, password, usertype, id))
        conn.commit()
        return jsonify(["success"])

    else: 
        return render_template("index.html")

@app.route('/addcustomer', methods=["GET", "POST"])
def addcustomer():
    d={}
    if request.method =="POST":
        name = request.form["website_name"]
        website = request.form["website_address"]
        print(name, website)
        conn = connection()
        cursor = conn.cursor()
        cursor.execute("""INSERT INTO dbo.customers (website_name, website_address) values ( ?, ?)""", (name, website))
        conn.commit()
        return jsonify(["success"])

    else: 
        return render_template("index.html")

@app.route('/editcustomer', methods=["GET", "POST"])
def editcustomer():
    d={}
    if request.method =="POST":
        print("HELLOOOOO")
        id = request.form ["id"]
        name = request.form["website_name"]
        website = request.form["website_address"]
        print(name, website)
        conn = connection()
        cursor = conn.cursor()
        cursor.execute("""UPDATE dbo.customers SET website_name = ?, website_address = ? where id = ?""", (name, website, id))
        conn.commit()
        return jsonify(["success"])

    else: 
        return render_template("index.html")


@app.route('/additem', methods=["GET", "POST"])
def additem():
    d={}
    if request.method =="POST":
        bikeid = request.form["bike_id"]
        cardid = request.form["card_id"]
        category = request.form["category"]
        description = request.form["description"]
        conn = connection()
        cursor = conn.cursor()
        cursor.execute("""INSERT INTO dbo.items (bike_id, card_id, category, description) values (?, ?, ?, ?)""", (bikeid, cardid, category, description))
        conn.commit()
        return jsonify(["success"])

    else: 
        return render_template("index.html")


@app.route('/edititem', methods=["GET", "POST"])
def edititem():
    d={}
    if request.method =="POST":
        print("HELLOOOOO")
        id = request.form ["id"]
        bikeid = request.form["bike_id"]
        cardid = request.form["card_id"]
        category = request.form["category"]
        description = request.form["description"]
        
        conn = connection()
        cursor = conn.cursor()
        cursor.execute("""UPDATE dbo.items SET bike_id = ?, card_id = ?, category = ?, description = ? where id = ?""", (bikeid, cardid, category, description, id))
        conn.commit()
        return jsonify(["success"])

    else: 
        return render_template("index.html")

@app.route('/removeuser', methods=["GET", "POST"])
def removeuser():
    d={}
    if request.method =="POST":
        uid = int(request.form["id"])
        print(uid)
        conn = connection()
        cursor = conn.cursor()
        cursor.execute("""
                DELETE FROM dbo.users 
                WHERE id in (?)
               """, uid)
        conn.commit()
        return jsonify(["success"])

    else: 
        return render_template("index.html")

@app.route('/removeitem', methods=["GET", "POST"])
def removeitem():
    d={}
    if request.method =="POST":
        itid = int(request.form["id"])
        conn = connection()
        cursor = conn.cursor()
        cursor.execute("""
                DELETE FROM dbo.items 
                WHERE id in (?)
               """, itid)
        conn.commit()
        return jsonify(["success"])

    else: 
        return render_template("index.html")


@app.route('/removecustomer', methods=["GET", "POST"])
def removecustomer():
    d={}
    if request.method =="POST":
        cusid = int(request.form["id"])
        print(cusid)
        conn = connection()
        cursor = conn.cursor()
        cursor.execute("""
                DELETE FROM dbo.customers 
                WHERE id in (?)
               """, cusid)
        conn.commit()
        return jsonify(["success"])

    else: 
        return render_template("index.html")

@app.route('/userlist', methods=["GET", "POST"])
def userlist():
    #d = {}
    if request.method == "POST":
        conn = connection()
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM dbo.users")
        table = []
        for row in cursor.fetchall():
            #print(row)
            #ut = usertable( row[0], row[1], row[2], row[3], row[4], row[5], row[6])
            table.append({
                'id' : row[0],
                'name' : row[1],
                'surname' : row[2],
                'user_type' : row[3],
                'usr' : row[4],
                'pwd' : row[5],
                'card_id': row[6]
                })
        print(table)
        return jsonify(table)

    else: 
        return render_template('index.html')

@app.route('/itemlist', methods=["GET", "POST"])
def itemlist():
    #d = {}
    if request.method == "POST":
        conn = connection()
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM dbo.items")
        table = []
        for row in cursor.fetchall():
            #print(row)
            #ut = usertable( row[0], row[1], row[2], row[3], row[4])
            table.append({
                'id' : row[0],
                'bike_id' : row[1],
                'card_id' : row[2],
                'category' : row[3],
                'description' : row[4],
                })
        print(table)
        return jsonify(table)

    else: 
        return render_template('index.html')


@app.route('/customerlist', methods=["GET", "POST"])
def customerlist():
    #d = {}
    if request.method == "POST":
        conn = connection()
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM dbo.customers")
        table = []
        for row in cursor.fetchall():
            #print(row)
            #ut = usertable( row[0], row[1], row[2], row[3], row[4], row[5], row[6])
            table.append({
                'id' : row[0],
                'website_name' : row[1],
                'website_address' : row[2]})
        print(table)
        return jsonify(table)

    else: 
        return render_template('index.html')

@app.route('/admindashboard', methods=["GET", "POST"])
def admindashboard():
    #d = {}
    if request.method == "POST":
        conn = connection()
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM dbo.users")
        table = []
        for row in cursor.fetchall():
            #print(row)
            table.append({
                'id' : row[0],
                'name' : row[1],
                'surname' : row[2],
                'user_type' : row[3],
                'usr' : row[4],
                'pwd' : row[5],
                'card_id': row[6]
                })
        print(table)
        return jsonify(table)

    else: 
        return render_template('index.html')

@app.route('/userdashboard', methods=["GET", "POST"])
def userinfo():
    if request.method =="POST":
        user_id = request.form["user_id"]
        print(user_id)
        conn = connection()
        cursor = conn.cursor()
        table = {"user_info": {}, "user_rents": []}  #this is a dictionary of lists, containting other dictionaries.

        cursor.execute("SELECT * FROM dbo.users where id=(?)", user_id)
        for row in cursor.fetchall():
            table["user_info"] = {
                    'id' : row[0],
                    'name' : row[1],
                    'surname' : row[2],
                    'user_type' : row[3],
                    'usr' : row[4],
                    'pwd' : 'None',
                    'card_id': row[6]
                    }

        cursor.execute("SELECT * from dbo.rent_history where user_id=(?) order by id desc", user_id)
        for row in cursor.fetchall():
            table["user_rents"].append({
                'id' : row[0],
                'user_id': row[1],
                'bike_id' : row[2],
                'rent_date' : str(row[3]),
                'return_date' : str(row[4]) #must be a string, or the jsonify encoder will transform this in a unwanted format for us
                })

        if request.form['update_rent'] == 'true':
            print('date update required')
            date = request.form['date']
            rfid = request.form['rfid']
            cursor.execute("SELECT * from dbo.items where card_id=(?)", rfid)
            row = cursor.fetchall()
            if not bool(row):
                return jsonify('No item associated to the rfid')
            else:
                bike_id = row[0][1]
                cursor.execute("SELECT * from dbo.rent_history where user_id=(?) order by id desc", user_id)
                row = cursor.fetchall()
                print(row[0][2])
                if row[0][4] == None:   #if the return date is empty    
                    if row[0][2] != bike_id:
                        return jsonify('Wrong returned item')   #if the current rented item doesn't correspond to the rfid
                    else:
                        key = row[0][0]
                        cursor.execute("""UPDATE dbo.rent_history SET return_date = (?) WHERE user_id = (?) AND id = (?)""", (datetime.strptime(date, '%Y-%m-%d %H:%M:%S.%f'), user_id, key))
                        cursor.commit()
                        conn.close()
                        return jsonify('Return updated')
                else:       #in this case a new rent is started
                        cursor.execute("""INSERT INTO dbo.rent_history (user_id, bike_id, rent_date) values (?, ?, ?)""", (user_id, bike_id, datetime.strptime(date, '%Y-%m-%d %H:%M:%S.%f')))
                        cursor.commit()
                        conn.close()
                        return jsonify('Rent started')              
        conn.close()
        return jsonify(table)
    else: 
        return render_template("index.html")

@app.route('/totemreturnrent', methods=["GET", "POST"])
def totemreturnrent():
    if request.method =="POST":
        print('date update required')
        conn = connection()
        cursor = conn.cursor()
        date = request.form['date']
        rfid = request.form['rfid']
        cursor.execute("SELECT * from dbo.items where card_id=(?)", rfid)
        row = cursor.fetchall()
        if not bool(row):
            return jsonify('No item associated to the rfid')
        else:
            bike_id = row[0][1]
            cursor.execute("SELECT * from dbo.rent_history where return_date IS NULL and bike_id = (?)" , bike_id)
            row = cursor.fetchall()
            if bool(row):   #if there is an entry with return_date NULL
                cursor.execute("UPDATE dbo.rent_history SET return_date = (?) WHERE bike_id = (?) AND return_date IS NULL", datetime.strptime(date, '%Y-%m-%d %H:%M:%S.%f'), bike_id )
                cursor.commit()
                conn.close()
                return jsonify('Return updated')
            else:
                conn.close()
                return jsonify('Item already returned')
    else: 
        return render_template("index.html")

@app.route('/updateuserrfid', methods=["GET", "POST"])
def updateuserrfid():
    d={}
    if request.method =="POST":
        userid = request.form["userid"]
        scanuserrfid = request.form["card_id"]
        print(scanuserrfid)
        conn = connection()
        cursor = conn.cursor()
        cursor.execute("""UPDATE dbo.users SET card_id = ? where id = ?""", (scanuserrfid, userid))
        conn.commit()
        return jsonify(["success"])

    else: 
        return render_template("index.html")

@app.route('/updateitemrfid', methods=["GET", "POST"])
def updateitemrfid():
    d={}
    if request.method =="POST":
        itemid = request.form["itemid"]
        scanitemrfid = request.form["card_id"]
        print(scanitemrfid)
        conn = connection()
        cursor = conn.cursor()
        cursor.execute("""UPDATE dbo.items SET card_id = ? where id = ?""", (scanitemrfid, itemid))
        conn.commit()
        return jsonify(["success"])

    else: 
        return render_template("index.html")


if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000 ,debug=True)


# DBCC CHECKIDENT (users, RESEED, 5)
