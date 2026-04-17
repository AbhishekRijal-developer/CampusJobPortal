# Campus Job Portal

A comprehensive web-based job portal application built with Java, JSP, and Servlets for campus placements and recruitment management.

## 📋 Project Overview

Campus Job Portal is a full-stack web application designed to facilitate campus recruitment. It provides a platform where:
- **Students** can browse job listings, submit applications, and track their application status
- **Recruiters** can post job openings, review applications, and manage candidates
- **Administrators** can oversee the entire platform and manage users

## 🏗️ Project Structure

```
CampusJobPortal/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/campusjobportal/
│   │   │       ├── controller/       (Servlets)
│   │   │       │   ├── LoginServlet.java
│   │   │       │   ├── RegisterServlet.java
│   │   │       │   ├── JobServlet.java
│   │   │       │   └── ApplicationServlet.java
│   │   │       ├── dao/              (Data Access Objects)
│   │   │       │   ├── UserDAO.java
│   │   │       │   ├── JobDAO.java
│   │   │       │   └── ApplicationDAO.java
│   │   │       ├── model/            (Entity Classes)
│   │   │       │   ├── User.java
│   │   │       │   ├── Job.java
│   │   │       │   └── Application.java
│   │   │       └── util/             (Utility Classes)
│   │   │           └── DBConnection.java
│   │   └── webapp/
│   │       ├── css/
│   │       │   └── styles.css
│   │       ├── js/
│   │       ├── images/
│   │       ├── pages/
│   │       │   ├── index.jsp
│   │       │   ├── login.jsp
│   │       │   ├── register.jsp
│   │       │   ├── student-dashboard.jsp
│   │       │   ├── recruiter-dashboard.jsp
│   │       │   ├── admin-dashboard.jsp
│   │       │   ├── job-list.jsp
│   │       │   ├── post-job.jsp
│   │       │   └── applications.jsp
│   │       └── WEB-INF/
│   │           └── web.xml
├── lib/
├── pom.xml
└── README.md
```

## 🛠️ Technologies Used

- **Backend**: Java, Servlets, JSP
- **Frontend**: HTML5, CSS3, JavaScript
- **Database**: MySQL
- **Build Tool**: Maven
- **Server**: Tomcat (Recommended: Apache Tomcat 9.x or higher)
- **IDE**: Eclipse / IntelliJ IDEA / VS Code

## 📦 Dependencies

The project uses Maven for dependency management. Key dependencies include:

- **Servlet API 4.0.1** - For creating web servlets
- **JSP API 2.3.3** - For JSP processing
- **JSTL 1.2** - For JSP Standard Tag Library
- **MySQL JDBC Driver 8.0.33** - For database connectivity
- **Apache Commons Codec** - For password encoding
- **Apache Commons Lang** - For utility functions

## 🗄️ Database Setup

### Prerequisites
- MySQL Server installed and running

### Create Database

```sql
CREATE DATABASE campus_job_portal;
USE campus_job_portal;

-- Users Table
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    user_type ENUM('STUDENT', 'RECRUITER', 'ADMIN') NOT NULL,
    phone_number VARCHAR(20),
    company_name VARCHAR(100),
    resume_path VARCHAR(255),
    is_active BOOLEAN DEFAULT TRUE,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Jobs Table
CREATE TABLE jobs (
    job_id INT PRIMARY KEY AUTO_INCREMENT,
    recruiter_id INT NOT NULL,
    job_title VARCHAR(200) NOT NULL,
    job_description TEXT NOT NULL,
    location VARCHAR(100) NOT NULL,
    employment_type VARCHAR(50) NOT NULL,
    salary_range VARCHAR(100),
    qualifications TEXT,
    skills TEXT,
    deadline DATE NOT NULL,
    applications_count INT DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE,
    posted_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (recruiter_id) REFERENCES users(user_id)
);

-- Applications Table
CREATE TABLE applications (
    application_id INT PRIMARY KEY AUTO_INCREMENT,
    job_id INT NOT NULL,
    student_id INT NOT NULL,
    status ENUM('PENDING', 'APPROVED', 'REJECTED', 'WITHDRAWN') DEFAULT 'PENDING',
    cover_letter TEXT,
    resume_path VARCHAR(255),
    application_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (job_id) REFERENCES jobs(job_id),
    FOREIGN KEY (student_id) REFERENCES users(user_id)
);
```

## 🚀 Installation & Setup

### 1. Clone/Download the Project
```bash
git clone <repository-url>
cd CampusJobPortal
```

### 2. Configure Database Connection
Edit `src/main/java/com/campusjobportal/util/DBConnection.java`:
```java
private static final String DB_URL = "jdbc:mysql://localhost:3306/campus_job_portal";
private static final String DB_USER = "root";
private static final String DB_PASSWORD = "your_password";
```

### 3. Build the Project
```bash
mvn clean install
```

### 4. Deploy to Tomcat
- Copy the generated WAR file from `target/` folder to Tomcat's `webapps/` directory
- Or deploy using Maven plugin: `mvn tomcat7:deploy`

### 5. Start Tomcat
```bash
catalina run
```

### 6. Access the Application
Open your browser and navigate to:
```
http://localhost:8080/CampusJobPortal/
```

## 👥 User Roles

### Student
- Browse available job listings
- Apply for jobs
- Track application status
- Manage profile and resume

### Recruiter
- Post new job openings
- View job postings
- Review student applications
- Manage candidate profiles

### Administrator
- Manage all users (students, recruiters)
- View platform statistics
- Manage all job postings
- Monitor applications

## 🔐 Features

- **User Authentication**: Secure login and registration system
- **User Profiles**: Customizable profiles for different user types
- **Job Management**: Post, edit, and manage job listings
- **Application Tracking**: Track application status and history
- **Search & Filter**: Search jobs by title, location, and employment type
- **Responsive Design**: Works on desktop and mobile devices
- **Session Management**: Secure session handling

## 📝 Usage

### For Students
1. Register with email and password
2. Complete your profile
3. Browse available jobs
4. Submit job applications
5. Track your applications

### For Recruiters
1. Register as a recruiter with company details
2. Post job openings
3. Review student applications
4. Update application status (approve/reject)

### For Administrators
1. Access admin panel
2. Manage user accounts
3. View platform statistics
4. Monitor system activities

## 🔧 Configuration

### web.xml Settings
- Session timeout: 30 minutes
- Session tracking: Cookie-based
- Error pages: Configured for 404 and 500 errors

### Database Connection Pool
Can be configured in `DBConnection.java` for better performance in production.

## 📋 Testing

Run unit tests:
```bash
mvn test
```

## 🐛 Troubleshooting

### Database Connection Issues
- Ensure MySQL server is running
- Check database credentials in `DBConnection.java`
- Verify MySQL driver is in classpath

### Tomcat Deployment Issues
- Check Tomcat logs in `catalina.out`
- Ensure port 8080 is available
- Verify WAR file is correctly placed in webapps folder

### JSP Compilation Errors
- Clear Tomcat work directory
- Rebuild project with `mvn clean build`

## 📚 Additional Resources

- [Java Servlets Documentation](https://docs.oracle.com/javaee/7/tutorial/servlets.htm)
- [JSP Documentation](https://docs.oracle.com/javaee/7/tutorial/jsptechover.htm)
- [MySQL JDBC Driver](https://dev.mysql.com/downloads/connector/j/)
- [Apache Tomcat Documentation](https://tomcat.apache.org/tomcat-10.0-doc/)

## 📄 License

This project is provided for educational purposes.

## 👨‍💻 Author

Created for Advanced Programming Coursework - Campus Job Portal Project

## 🤝 Contributing

Feel free to fork, modify, and improve this project for your coursework.

---

**Note**: This is a coursework project. Make sure to modify and personalize it according to your assignment requirements before submission.
# CampusJobPortal
