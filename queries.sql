import mysql.connector
conn=mysql.connector.connect(
    user='root',
    host='localhost',
    password='',
    database='BMSsystem'
)
cursor=conn.cursor()
#cursor.execute("create database BMSsystem")
cursor.execute("""
CREATE TABLE IF NOT EXISTS account (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    user_name VARCHAR(100),
    init_amount DECIMAL(10,2)
)
""")

def create_account():
      user_name = input("Enter your name: ")
      init_amount = float(input("Enter initial deposit amount: "))
      cursor.execute("insert into account(user_name,init_amount)values(%s,%s)",(user_name,init_amount))
      conn.commit()
def deposit_money():
    acc_id = input("Enter account ID: ")
    amount = float(input("Enter deposit amount: "))

    cursor.execute("SELECT init_amount FROM account WHERE user_id=%s", (acc_id,))
    data = cursor.fetchone()

    if data is None:
        print("Account does not exist\n")
    else:
        cursor.execute(
            "UPDATE account SET init_amount = init_amount + %s WHERE user_id=%s",
            (amount, acc_id)
        )
        conn.commit()
        
        print("Money deposited successfully\n")
def withdraw_money():
     acc_id=input("enter the account ID : ")
     amount=float(input("enter the amount you want to withdraw "))
     cursor.execute("select init_amount from account WHERE user_id=%s",(acc_id,))
     data=cursor.fetchone()
     if data is None:
          print("account doesnot exist")
     elif data[0] < amount: 
         print("balance is not sufficient")     
     else:
          cursor.execute("update account SET init_amount=init_amount - %s WHERE user_id=%s",(amount,acc_id))
          conn.commit()
          
    
          print ("money withdraw sucessfully")
          


           
while True:
     print(" press -1 to Create account\n press -2 to deposite money\npress-3 to withdraw money")
     choice=input("please select your choice")
     if choice == "1":
        create_account()
     elif choice == "2":
        deposit_money()
     elif choice == "3":
        withdraw_money()

    
