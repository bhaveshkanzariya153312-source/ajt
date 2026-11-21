<%@ page import="com.library.model.User" %>
<%
if (session.getAttribute("user") == null) { response.sendRedirect(request.getContextPath() + "/login.jsp"); return; }
%>

<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html><html><head><meta charset="UTF-8"><title>Add Student</title><link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/style.css"></head>
<body><div class="app-shell"><jsp:include page="/includes/sidebar.jsp"/><main class="main-content"><jsp:include page="/includes/navbar.jsp"/>
<section class="page"><div class="page-heading"><div><h1>Add Student</h1><p>Register a new library student.</p></div></div>
<% if("invalid".equals(request.getParameter("error"))){ %><div class="alert error">Student name is required.</div><% } %>
<div class="card form-card"><form method="post" action="<%=request.getContextPath()%>/addStudent">
<label>Name *</label><input name="name" required>
<label>Email</label><input name="email" type="email">
<label>Phone</label><input name="phone">
<label>Course</label><input name="course" placeholder="e.g. BCA">
<p class="hint">Default login password for a new student: <strong>student123</strong></p>
<div class="form-actions"><button class="btn" type="submit">Save Student</button><a class="btn secondary" href="students.jsp">Cancel</a></div>
</form></div></section><jsp:include page="/includes/footer.jsp"/></main></div></body></html>
