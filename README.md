# visualizationsoftware_JAVA

DataViz Pro 📊
DataViz Pro is a dynamic, full-stack web application designed for easy and secure CSV data visualization. Users can register for an account, upload their datasets, and instantly generate a variety of charts like bar graphs, pie charts, and more. The entire application is built from the ground up using Java Servlets for the backend and JavaServer Pages (JSP) with Bootstrap 5 for a clean, responsive frontend.

(Feel free to replace this placeholder image with a screenshot of your own dashboard or a GIF of the application in action!)

✨ Features
Secure User Authentication: Complete login and registration system with session management.

Robust Password Security: User passwords are not stored in plain text; they are securely hashed using the jBCrypt library.

User Dashboard: A central hub for authenticated users to view their history of uploaded files.

Interactive File Upload: A multi-step wizard for uploading CSV files, featuring a drag-and-drop area and live data preview.

Dynamic Data Mapping: Users can select which columns from their CSV should be used for the chart's labels (X-axis) and values (Y-axis).

Multiple Chart Types: Generates several types of charts using the powerful JFreeChart library on the server-side, including:

Bar Charts

Pie Charts

Line Charts

Histograms

Downloadable Visualizations: Users can download their generated charts as high-quality PNG images.

Responsive UI: The entire frontend is built with Bootstrap 5, making it fully responsive and user-friendly on desktops, tablets, and mobile devices.

🛠️ Technology Stack
Backend:

Java Servlets

JFreeChart (for chart image generation)

jBCrypt (for password hashing)

Frontend:

JavaServer Pages (JSP)

Bootstrap 5

HTML5, CSS3, JavaScript (ES6)

Database:

PostgreSQL

Web Server:

Apache Tomcat 9+

Build Tool:

Apache Maven (for dependency management)

🚀 Setup and Installation
To get a local copy up and running, follow these simple steps.

Prerequisites
Java Development Kit (JDK) 11 or higher

Apache Tomcat 9 or higher

PostgreSQL Database Server

Apache Maven

1. Database Setup
First, create a new database in PostgreSQL. The default name used in the project is visualizationsoftware. Then, run the following SQL scripts to create the necessary tables.

users table:

SQL

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL -- Increased length for storing hashes
);
files table:

SQL

CREATE TABLE files (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id),
    filename VARCHAR(255) NOT NULL,
    file_path VARCHAR(512),
    upload_date TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW()
);
2. Configuration
Update the database connection details in the DBConnection.java file to match your PostgreSQL setup.

src/main/java/com/login/visualizationsoftware/util/DBConnection.java:

Java

public class DBConnection {
    private static final String URL = "jdbc:postgresql://localhost:5432/visualizationsoftware"; // Your DB URL
    private static final String USER = "postgres"; // Your DB Username
    private static final String PASSWORD = "your_password_here"; // Your DB Password
    // ...
}
3. Build the Project
Open a terminal or command prompt in the root directory of the project and run the following Maven command. This will compile the code and package it into a .war file in the target/ directory.

Bash

mvn clean install
4. Deployment
Copy the generated .war file from the target/ directory (e.g., visualizationsoftware-1.0.war).

Paste the .war file into the webapps/ directory of your Apache Tomcat installation.

Start your Tomcat server. The application will be automatically deployed.

Access the application in your browser, typically at http://localhost:8080/visualizationsoftware/.

⚙️ Usage Workflow
Register: Create a new account from the landing page.

Login: Log in with your new credentials. You will be redirected to the dashboard.

Upload: From the dashboard, click "Upload New File".

Process File: On the upload page, select a CSV file and choose the columns for the labels and values.

Select Chart: After submitting the file, you will be taken to a page to select the type of chart you want to generate.

View & Download: The final chart is displayed. You can download it as a PNG or go back to select a different chart type for the same data.
