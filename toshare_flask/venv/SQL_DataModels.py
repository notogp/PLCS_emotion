class userTable:
    def __init__(self, id, name, surname, user_type, usr, pwd, card_id):
        self.id = id
        self.name = name
        self.surname = surname
        self.user_type = user_type
        self.usr = usr
        self.pwd = pwd
        self.card_id = card_id

#for the admin and customers
class items:
    def __init__(self, id, bike_id, card_id, category, description, rent_date, return_date):
        self.id = id
        self.bike_id = bike_id
        self.card_id = card_id
        self.category = category
        self.description = description
        self.rent_date = rent_date
        self.return_date = return_date

#for the user's history rent
class user_rent:
    def __init__(self, id, bike_id, rent_date, return_date):
        self.id = id
        self.bike_id = bike_id
        self.rent_date = rent_date
        self.return_date = return_date



#for the customer (but also for admin)
class counter:
    def __init__(self, total_quantity, quantity_available):
        self.total_quantity = total_quantity
        self.quantity_available = quantity_available

#for the admin
class customers_subscription:
    def __init__(self, customer_name, customer_data_rinnovo, customer_data_chiusura, totale_rinnovi):
        self.customer_name = customer_name
        self.customer_data_rinnovo = customer_data_rinnovo
        self.customer_data_chiusura = customer_data_chiusura
        self.totale_rinnovi = totale_rinnovi
    

