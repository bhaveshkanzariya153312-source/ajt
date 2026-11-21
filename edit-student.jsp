<%@ page import="com.library.model.User" %>
<%
if (session.getAttribute("user") == null) { response.sendRedirect(request.getContextPath() + "/login.jsp"); return; }
%>

<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.library.util.Html" %>
<%@ page import="com.library.dao.StudentDAO,com.library.model.Student" %>
<%
Student student=null; try { student=new StudentDAO().findById(Integer.parseInt(request.getParameter("id"))); } catch(Exception e) {}
%>
<!DOCTYPE html><html><head><meta charset="UTF-8"><title>Edit Student</title><link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/style.css"></head>
<body><div class="app-shell"><jsp:include page="/includes/sidebar.jsp"/><main class="main-content"><jsp:include page="/includes/navbar.jsp"/>
<section class="page"><div class="page-heading"><div><h1>Edit Student</h1><p>Update student information.</p></div></div>
<% if(student==null){ %><div class="alert error">Student not found.</div><% } else { %>
<div class="card form-card"><form method="post" action="<%=request.getContextPath()%>/updatestudent">
<input type="hidden" name="id" value="<%=student.getId()%>">
<label>Name *</label><input name="name" value="<%=Html.esc(student.getName())%>" required>
<label>Email</label><input name="email" type="email" value="<%=Html.esc(student.getEmail()==null?"":student.getEmail())%>">
<label>Phone</label><input name="phone" value="<%=Html.esc(student.getPhone()==null?"":student.getPhone())%>">
<label>Course</label><input name="course" value="<%=Html.esc(student.getCourse()==null?"":student.getCourse())%>">
<div class="form-actions"><button class="btn" type="submit">Update Student</button><a class="btn secondary" href="students.jsp">Cancel</a></div>
</form></div><% } %></section><jsp:include page="/includes/footer.jsp"/></main></div></body></html>
