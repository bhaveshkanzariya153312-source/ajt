<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%
String ctx = request.getContextPath();
%>
<aside class="sidebar">
    <div class="side-title">&#128218; Smart Library</div>
    <a href="<%=ctx%>/admin/dashboard.jsp">&#127968; Dashboard</a>
    <a href="<%=ctx%>/admin/books.jsp">&#128214; Books</a>
    <a href="<%=ctx%>/admin/add-book.jsp">&#10133; Add Book</a>
    <a href="<%=ctx%>/admin/students.jsp">&#127891; Students</a>
    <a href="<%=ctx%>/admin/add-student.jsp">&#128100; Add Student</a>
    <a href="<%=ctx%>/admin/issue-book.jsp">&#128228; Issue Book</a>
    <a href="<%=ctx%>/admin/return-book.jsp">&#128229; Return Book</a>
    <a href="<%=ctx%>/admin/fines.jsp">&#128176; Fines</a>
    <a href="<%=ctx%>/admin/reports.jsp">&#128202; Reports</a>
    <a href="<%=ctx%>/logout">&#128682; Logout</a>
</aside>
