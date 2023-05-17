#!/usr/bin/python

import cgi
import pymysql
import os

# Connect to the Cloud SQL database via Cloud SQL Proxy
def connect_to_database():
    db_socket_dir = os.environ.get("DB_SOCKET_DIR", "/cloudsql")
    cloud_sql_connection_name = "nimble-unison-386200:us-central1:main"
    db_user = "karan"
    db_password = "karan"
    db_name = "main"

    try:
        unix_socket = db_socket_dir + '/' + cloud_sql_connection_name
        conn = pymysql.connect(
            unix_socket=unix_socket,
            user=db_user,
            password=db_password,
            database=db_name,
            cursorclass=pymysql.cursors.DictCursor
        )
        return conn
    except Exception as e:
        print("Content-type:text/html\r\n\r\n")
        print("<html>")
        print("<head>")
        print("<title>Error</title>")
        print("</head>")
        print("<body>")
        print("<h1>Error connecting to the database.</h1>")
        print("</body>")
        print("</html>")
        return None

# Login page HTML
# Login page HTML
def login_page():
    with open('/var/www/html/login.html', 'r') as file:
        print("Content-type:text/html\r\n\r\n")
        print(file.read())
# Verify login credentials
def verify_login(username, password):
    conn = connect_to_database()
    if conn is not None:
        try:
            with conn.cursor() as cursor:
                sql = "SELECT * FROM users WHERE username=%s AND password=%s"
                cursor.execute(sql, (username, password))
                result = cursor.fetchone()
                if result:
                    return True
                else:
                    return False
        except Exception as e:
            print("Content-type:text/html\r\n\r\n")
            print("<html>")
            print("<head>")
            print("<title>Error</title>")
            print("</head>")
            print("<body>")
            print("<h1>Error executing SQL query.</h1>")
            print("</body>")
            print("</html>")
            return False
        finally:
            conn.close()
    else:
        return False

# Main CGI code
def main():
    form = cgi.FieldStorage()
    username = form.getvalue('username')
    password = form.getvalue('password')

    if username and password:
        if verify_login(username, password):
            print("Content-type:text/html\r\n\r\n")
            print("<html>")
            print("<head>")
            print("<title>Welcome</title>")
            print("</head>")
            print("<body>")
            print("<h1>Welcome, {}!</h1>".format(username))
            print("</body>")
            print("</html>")
        else:
            print("Content-type:text/html\r\n\r\n")
            print("<html>")
            print("<head>")
            print("<title>Login Failed</title>")
            print("</head>")
            print("<body>")
            print("<h1>Login Failed. Invalid username or password.</h1>")
            print("</body>")
            print("</html>")
    else:
        login_page()

if __name__ == '__main__':
    main()
