<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Attendance Management</title>
</head>
<body>
    <h1>Mark Attendance</h1>
    <form action="attendance" method="post">
        <label for="studentId">Student ID:</label>
        <input type="text" id="studentId" name="studentId" required><br><br>
        
        <label for="courseId">Course ID:</label>
        <input type="text" id="courseId" name="courseId" required><br><br>
        
        <label for="status">Status:</label>
        <select id="status" name="status">
            <option value="Present">Present</option>
            <option value="Absent">Absent</option>
        </select><br><br>
        
        <button type="submit">Submit</button>
    </form>
</body>
</html>
