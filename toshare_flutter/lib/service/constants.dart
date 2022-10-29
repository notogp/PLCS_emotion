//const base = 'http://192.168.8.101:5000';
const base = 'http://192.168.5.104:5000';
//const base = 'http://192.168.1.55:5000';

const loginUrl = base + '/login';
const registerUrl = base + '/register';
const addcustomerUrl = base + '/addcustomer';
const editcustomerUrl = base + '/editcustomer';
const adduserUrl = base + '/adduser';
const edituserUrl = base + '/edituser';
const additemUrl = base + '/additem';
const edititemUrl = base + '/edititem';
const removecustomerUrl = base + '/removecustomer';
const removeuserUrl = base + '/removeuser';
const removeitemUrl = base + '/removeitem';
const userdashboardUrl = base + "/userdashboard";
const customerlistUrl = base + '/customerlist';
const userlistUrl = base + '/userlist';
const itemlistUrl = base + '/itemlist';
const updateuserrfidUrl = base + '/updateuserrfid';
const updateitemrfidUrl = base + '/updateitemrfid';
const rfidUrl = 'http://127.0.0.1:5000/rfid';
const totemUrl = 'http://127.0.0.1:5000/logintotem';
const loginwithrfidUrl = base + '/loginwithrfid';

bool isTotem = false;
double fee = 0.1;
