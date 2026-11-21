<%
com.library.model.Student loggedStudent = (com.library.model.Student)session.getAttribute("student");
if (loggedStudent == null) { response.sendRedirect(request.getContextPath() + "/student-login.jsp"); return; }
int id = loggedStudent.getId();
%>

<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.library.util.Html" %>
<!DOCTYPE html><html><head><meta charset="UTF-8"><title>My Profile</title><link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/style.css"><meta name="viewport" content="width=device-width,initial-scale=1"></head>
<body><div class="student-shell"><aside class="sidebar student-side"><div class="side-title">&#127891; Student Portal</div><a href="dashboard.jsp">&#127968; Dashboard</a><a href="books.jsp">&#128214; Books</a><a href="my-books.jsp">&#128218; My Books</a><a href="my-fine.jsp">&#128176; My Fine</a><a href="profile.jsp">&#128100; Profile</a><a href="<%=request.getContextPath()%>/studentLogout">&#128682; Logout</a></aside>
<main class="main-content"><header class="topbar"><div class="brand">My Profile</div><div class="user-badge"><%=Html.esc(loggedStudent.getName())%></div></header><section class="page">
<div class="page-heading"><div><h1>Student Profile</h1><p>Your registered library details.</p></div></div>
<div class="card profile-card"><div class="profile-avatar">&#127891;</div><div><h2><%=Html.esc(loggedStudent.getName())%></h2><p><strong>Student ID:</strong> <%=loggedStudent.getId()%></p><p><strong>Email:</strong> <%=Html.esc(loggedStudent.getEmail()==null?"":loggedStudent.getEmail())%></p><p><strong>Phone:</strong> <%=Html.esc(loggedStudent.getPhone()==null?"":loggedStudent.getPhone())%></p><p><strong>Course:</strong> <%=Html.esc(loggedStudent.getCourse()==null?"":loggedStudent.getCourse())%></p></div></div>
</section><jsp:include page="/includes/footer.jsp"/></main></div></body></html>
