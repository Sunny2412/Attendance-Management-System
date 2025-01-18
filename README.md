### Attendance Management System

#### Prerequisites:
1. **Java Development Kit (JDK)**: Ensure you have JDK 11 or later installed.
2. **Apache Maven**: For dependency management.
3. **MySQL**: For database management.
4. **Apache Tomcat**: For deploying the application.

#### Project Structure:
The project will follow the **MVC architecture**:
- **Model**: Represents the database and business logic.
- **View**: Handles the user interface.
- **Controller**: Manages the flow between the Model and View.

#### Steps to Create the System:

1. **Setup Maven Project**:
   ```
   mvn archetype:generate -DgroupId=com.university.attendance -DartifactId=attendance-management -DarchetypeArtifactId=maven-archetype-webapp -DinteractiveMode=false
   ```

2. **Add Dependencies**:
   Update the `pom.xml` with the required dependencies:
   ```xml
   <dependencies>
       <!-- MySQL Connector -->
       <dependency>
           <groupId>mysql</groupId>
           <artifactId>mysql-connector-java</artifactId>
           <version>8.0.33</version>
       </dependency>

       <!-- Servlet API -->
       <dependency>
           <groupId>javax.servlet</groupId>
           <artifactId>javax.servlet-api</artifactId>
           <version>4.0.1</version>
           <scope>provided</scope>
       </dependency>

       <!-- JSTL -->
       <dependency>
           <groupId>javax.servlet</groupId>
           <artifactId>jstl</artifactId>
           <version>1.2</version>
       </dependency>

       <!-- Hibernate -->
       <dependency>
           <groupId>org.hibernate</groupId>
           <artifactId>hibernate-core</artifactId>
           <version>5.6.15.Final</version>
       </dependency>

       <!-- Log4j -->
       <dependency>
           <groupId>org.apache.logging.log4j</groupId>
           <artifactId>log4j-core</artifactId>
           <version>2.20.0</version>
       </dependency>
   </dependencies>
   ```

3. **Database Schema**:
   Create a MySQL database and tables for students, courses, and attendance records:
   ```sql
   CREATE DATABASE attendance_db;

   CREATE TABLE students (
       id INT AUTO_INCREMENT PRIMARY KEY,
       name VARCHAR(100),
       email VARCHAR(100)
   );

   CREATE TABLE courses (
       id INT AUTO_INCREMENT PRIMARY KEY,
       name VARCHAR(100),
       instructor VARCHAR(100)
   );

   CREATE TABLE attendance (
       id INT AUTO_INCREMENT PRIMARY KEY,
       student_id INT,
       course_id INT,
       date DATE,
       status ENUM('Present', 'Absent'),
       FOREIGN KEY (student_id) REFERENCES students(id),
       FOREIGN KEY (course_id) REFERENCES courses(id)
   );
   ```

4. **Model Layer**:
   Define Java classes for `Student`, `Course`, and `Attendance`.

   Example: `Student.java`
   ```java
   public class Student {
       private int id;
       private String name;
       private String email;

       // Getters and setters
   }
   ```

5. **DAO Layer**:
   Create Data Access Objects (DAOs) for CRUD operations.

   Example: `StudentDAO.java`
   ```java
   import java.sql.*;
   import java.util.*;

   public class StudentDAO {
       private Connection connection;

       public StudentDAO(Connection connection) {
           this.connection = connection;
       }

       public List<Student> getAllStudents() throws SQLException {
           List<Student> students = new ArrayList<>();
           String query = "SELECT * FROM students";
           try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(query)) {
               while (rs.next()) {
                   Student student = new Student();
                   student.setId(rs.getInt("id"));
                   student.setName(rs.getString("name"));
                   student.setEmail(rs.getString("email"));
                   students.add(student);
               }
           }
           return students;
       }
   }
   ```

6. **Controller Layer**:
   Implement servlets to handle requests.

   Example: `AttendanceController.java`
   ```java
   import javax.servlet.*;
   import javax.servlet.http.*;
   import java.io.*;

   public class AttendanceController extends HttpServlet {
       protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
           // Fetch data and forward to JSP
           request.getRequestDispatcher("attendance.jsp").forward(request, response);
       }

       protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
           // Handle form submissions
       }
   }
   ```

7. **View Layer**:
   Create JSP pages for user interaction.

   Example: `attendance.jsp`
   ```jsp
   <html>
   <head>
       <title>Attendance Management</title>
   </head>
   <body>
       <h1>Attendance Management System</h1>
       <form action="AttendanceController" method="post">
           <label for="studentId">Student ID:</label>
           <input type="text" id="studentId" name="studentId">
           <label for="courseId">Course ID:</label>
           <input type="text" id="courseId" name="courseId">
           <label for="status">Status:</label>
           <select id="status" name="status">
               <option value="Present">Present</option>
               <option value="Absent">Absent</option>
           </select>
           <button type="submit">Submit</button>
       </form>
   </body>
   </html>
   ```

8. **Deploy on Tomcat**:
   - Package the application as a WAR file using Maven:
     ```
     mvn clean package
     ```
   - Deploy the WAR file to the Tomcat `webapps` directory.

9. **Test the Application**:
   Access the application via `http://localhost:8080/attendance-management`.

#### Notes:
- Ensure proper exception handling and logging.
- Secure sensitive data like database credentials.
- Use connection pooling for database connections.
- Validate user input to prevent SQL injection.

---

### README

#### Attendance Management System

**Description:**
The Attendance Management System is a web application designed for university-level graduates to manage student attendance records efficiently. Built using Java, the application follows the MVC architecture and uses MySQL for backend data management. It is deployed on an Apache Tomcat server for live access.

**Features:**
- Add, view, and manage students and courses.
- Record attendance for students in specific courses.
- Generate attendance reports.

**Technologies Used:**
- Java (JDK 11 or later)
- Apache Maven
- MySQL (Database)
- Apache Tomcat (Deployment)
- JSP (View Layer)
- Servlets (Controller Layer)

**Setup Instructions:**
1. Clone the repository or download the source code.
2. Set up the MySQL database using the provided schema.
3. Update the database connection details in the `DatabaseConnection` class.
4. Build the project using Maven:
   ```bash
   mvn clean package
   ```
5. Deploy the generated WAR file to the Tomcat `webapps` directory.
6. Start the Tomcat server and access the application at:
   ```
   http://localhost:8080/attendance-management
   ```

**Usage:**
1. Navigate to the application home page.
2. Add students and courses using the appropriate forms.
3. Record attendance for students in courses.
4. View and manage attendance records.

**Contributors:**
- Sunny Kumar

**License:**
This project is licensed under the MIT License.
