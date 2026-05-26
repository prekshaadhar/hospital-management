from flask import Flask, render_template, request, redirect, url_for, session
from flask_mysqldb import MySQL
import MySQLdb.cursors
import hashlib

app = Flask(__name__)
app.secret_key = 'aarogya_hospital_2026_secure_key'

app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = '#Shinchan1947'
app.config['MYSQL_DB'] = 'aarogya_hospital'

mysql = MySQL(app)

@app.route('/')
def home():
    return render_template('index.html')

@app.route('/medical-services')
def medical_services():
    return render_template('medical-services.html')

@app.route('/contact')
def contact():
    return render_template('contact.html')

@app.route('/submit-contact', methods=['POST'])
def submit_contact():

    name = request.form.get('name')
    email = request.form.get('email')
    phone = request.form.get('phone')
    subject = request.form.get('subject')
    message = request.form.get('message')

    cur = mysql.connection.cursor()

    cur.execute("""
        INSERT INTO ContactMessages
        (name, email, phone, subject, message)
        VALUES (%s, %s, %s, %s, %s)
    """, (name, email, phone, subject, message))

    mysql.connection.commit()
    cur.close()

    return render_template(
        'contact.html',
        success=True
    )

@app.route('/appointment-booking', methods=['GET', 'POST'])
def appointment_booking():

    if request.method == 'POST':

        name = request.form.get('name')
        age = request.form.get('age')
        gender = request.form.get('gender')
        contact = request.form.get('contact')
        address = request.form.get('address')

        department = request.form.get('department')
        doctor = request.form.get('doctor')

        date = request.form.get('date')
        time = request.form.get('time')
        message = request.form.get('message')

        cursor = mysql.connection.cursor()

        cursor.execute("""
            INSERT INTO Patients
            (name, age, gender, contact, address)
            VALUES (%s, %s, %s, %s, %s)
        """, (
            name,
            age,
            gender,
            contact,
            address
        ))

        patient_id = cursor.lastrowid

        cursor.execute("""
            INSERT INTO Appointments
            (
                patient_id,
                department,
                doctor_name,
                appointment_date,
                appointment_time,
                message
            )
            VALUES (%s, %s, %s, %s, %s, %s)
        """, (
            patient_id,
            department,
            doctor,
            date,
            time,
            message
        ))

        mysql.connection.commit()
        cursor.close()

        return render_template(
            'appointment-booking.html',
            success=True
        )

    return render_template('appointment-booking.html')

@app.route('/health-checkup', methods=['GET', 'POST'])
def book_health_checkup():

    if request.method == 'POST':

        name = request.form.get('name')
        age = request.form.get('age')
        gender = request.form.get('gender')
        email = request.form.get('email')
        phone = request.form.get('contact')

        package = request.form.get('package')
        date = request.form.get('date')
        time = request.form.get('time')

        cursor = mysql.connection.cursor()

        cursor.execute("""
            INSERT INTO HealthCheckups
            (
                name,
                age,
                gender,
                email,
                phone,
                package_type,
                preferred_date,
                preferred_time
            )
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
        """, (
            name,
            age,
            gender,
            email,
            phone,
            package,
            date,
            time
        ))

        mysql.connection.commit()
        cursor.close()

        return render_template(
            'book-health-checkup.html',
            success=True
        )

    return render_template('book-health-checkup.html')

@app.route('/search', methods=['POST'])
def search():

    query = request.form.get('query')

    cur = mysql.connection.cursor(
        MySQLdb.cursors.DictCursor
    )

    cur.execute("""
        SELECT * FROM Doctors
        WHERE name LIKE %s
        OR specialization LIKE %s
        OR department LIKE %s
    """, (
        '%' + query + '%',
        '%' + query + '%',
        '%' + query + '%'
    ))

    results = cur.fetchall()

    cur.close()

    return render_template(
        'search-results.html',
        results=results,
        query=query
    )

@app.route('/find-hospital')
def find_hospital():
    return render_template('find-hospital.html')

@app.route('/admin-login', methods=['GET', 'POST'])
def admin_login():

    if request.method == 'POST':

        username = request.form.get('username')
        password = request.form.get('password')

        hashed_password = hashlib.sha256(
            password.encode()
        ).hexdigest()

        cur = mysql.connection.cursor(
            MySQLdb.cursors.DictCursor
        )

        cur.execute("""
            SELECT * FROM Admins
            WHERE username = %s
            AND password_hash = %s
        """, (
            username,
            hashed_password
        ))

        admin = cur.fetchone()

        cur.close()

        if admin:

            session['admin_logged_in'] = True

            return redirect(
                url_for('admin_dashboard')
            )

        else:

            return render_template(
                'admin-login.html',
                success=False
            )

    return render_template('admin-login.html')

@app.route('/admin-dashboard')
def admin_dashboard():

    if 'admin_logged_in' not in session:
        return redirect(url_for('admin_login'))

    return render_template(
        'admin-dashboard.html',
        admin='Admin'
    )

@app.route('/view-patients')
def view_patients():

    if 'admin_logged_in' not in session:
        return redirect(url_for('admin_login'))

    cur = mysql.connection.cursor(
        MySQLdb.cursors.DictCursor
    )

    cur.execute("""
        SELECT * FROM Patients
    """)

    patients = cur.fetchall()

    cur.close()

    return render_template(
        'view-patients.html',
        patients=patients
    )

@app.route('/manage-doctors')
def manage_doctors():

    if 'admin_logged_in' not in session:
        return redirect(url_for('admin_login'))

    cur = mysql.connection.cursor(
        MySQLdb.cursors.DictCursor
    )

    cur.execute("""
        SELECT * FROM Doctors
    """)

    doctors = cur.fetchall()

    cur.close()

    return render_template(
        'manage-doctors.html',
        doctors=doctors
    )

@app.route('/view-appointments')
def view_appointments():

    if 'admin_logged_in' not in session:
        return redirect(url_for('admin_login'))

    cur = mysql.connection.cursor(
        MySQLdb.cursors.DictCursor
    )

    cur.execute("""
        SELECT
            appointment_id,
            patient_id,
            department,
            doctor_name,
            appointment_date,
            appointment_time,
            message
        FROM Appointments
    """)

    appointments = cur.fetchall()

    cur.close()

    return render_template(
        'view-appointments.html',
        appointments=appointments
    )

@app.route('/billing-info')
def billing_info():

    if 'admin_logged_in' not in session:
        return redirect(url_for('admin_login'))

    return render_template('billing-info.html')

@app.route('/logout')
def logout():

    session.pop('admin_logged_in', None)

    return redirect(url_for('admin_login'))

if __name__ == '__main__':
    app.run(debug=True)