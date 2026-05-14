# Campus Job Portal - Setup Instructions

## Quick Start Guide

Follow these steps to set up and run the Campus Job Portal application:

## 1. Prerequisites

- Java 11 or higher
- Maven 3.6 or higher
- MySQL Server 5.7 or higher
- Apache Tomcat 9.x or higher
- Git (optional)

## 2. Database Setup

### Step 1: Create MySQL Database
```bash
# Log into MySQL
mysql -u root -p

# Execute the database initialization script
source database_setup.sql;
```

Or manually execute the SQL commands from `database_setup.sql` file.

### Step 2: Verify Database Creation
```sql
USE campus_job_portal;
SHOW TABLES;
```

## 3. Configure Database Connection

Edit the file: `src/main/java/com/campusjobportal/util/DBConnection.java`

```java
private static final String DB_URL = "jdbc:mysql://localhost:3306/campus_job_portal";
private static final String DB_USER = "root";
private static final String DB_PASSWORD = "your_mysql_password"; // Change this
```

## 4. Build the Project

```bash
# Navigate to project directory
cd CampusJobPortal

# Clean and build using Maven
mvn clean package
```

The WAR file will be generated in the `target/` directory.

## 5. Deploy to Tomcat

### Option A: Manual Deployment
1. Copy `target/CampusJobPortal.war` to `TOMCAT_HOME/webapps/`
2. Start Tomcat (if not already running)

### Option B: Maven Deployment
```bash
mvn tomcat7:deploy
```

## 6. Start the Application

### Windows
```bash
cd TOMCAT_HOME\bin
startup.bat
```

### Linux/Mac
```bash
cd TOMCAT_HOME/bin
./startup.sh
```

## 7. Access the Application

Open your browser and navigate to:
```
http://localhost:8080/CampusJobPortal/
```

## 8. Test with Sample Credentials

### Student Account
- Email: `john.doe@email.com`
- Password: `password123`

### Recruiter Account
- Email: `jane.smith@email.com`
- Password: `password123`

### Admin Account
- Email: `admin@email.com`
- Password: `admin123`

## Troubleshooting

### Issue: "Cannot connect to database"
**Solution**: 
- Verify MySQL is running: `mysql -u root -p`
- Check credentials in `DBConnection.java`
- Ensure `campus_job_portal` database exists

### Issue: "404 Not Found"
**Solution**: 
- Check WAR file is deployed in Tomcat webapps
- Verify application name matches URL
- Clear Tomcat cache: `rm -rf TOMCAT_HOME/work/`

### Issue: "Compilation errors"
**Solution**: 
- Ensure Java 11+ is installed: `java -version`
- Clear Maven cache: `mvn clean`
- Rebuild: `mvn install`

### Issue: "JSP pages not loading"
**Solution**: 
- Verify JSP files are in `src/main/webapp/`
- Check web.xml configuration
- Restart Tomcat

## Key Features

✅ User registration and authentication
✅ Student job browsing and application
✅ Recruiter job posting and management
✅ Admin dashboard
✅ Application status tracking
✅ Responsive design
✅ Secure session management

## Project Structure Overview

```
CampusJobPortal/
├── src/main/java/com/campusjobportal/
│   ├── controller/    (Servlets for request handling)
│   ├── dao/           (Database operations)
│   ├── model/         (Data models)
│   └── util/          (Utility classes)
├── src/main/webapp/
│   ├── css/           (Stylesheets)
│   ├── pages/         (JSP pages)
│   └── WEB-INF/       (Configuration files)
├── pom.xml            (Maven configuration)
├── database_setup.sql (Database initialization)
└── README.md          (Documentation)
```

## Next Steps

1. Log in with test credentials
2. Create new users (student/recruiter)
3. Post job listings
4. Submit applications
5. Track application status

## Documentation

- See `README.md` for detailed project documentation
- Check `pom.xml` for all dependencies
- Review `web.xml` for web application configuration

## Support & Help

For issues or questions:
1. Check the README.md file
2. Review database_setup.sql for schema
3. Check Tomcat logs in `TOMCAT_HOME/logs/`
4. Verify all configuration settings

---

**Happy Coding!** 🚀
