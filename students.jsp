<%@ page import="com.library.model.User" %>
<%
if (session.getAttribute("user") == null) { response.sendRedirect(request.getContextPath() + "/login.jsp"); return; }
%>

<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.library.util.Html" %>
<%@ page import="com.library.dao.StudentDAO,com.library.model.Student,java.util.List" %>
<%
List<Student> students=new StudentDAO().getAll(); String msg=request.getParameter("msg");
%>
<!DOCTYPE html><html><head><meta charset="UTF-8"><title>Students</title><link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/style.css"></head>
<body><div class="app-shell"><jsp:include page="/includes/sidebar.jsp"/><main class="main-content"><jsp:include page="/includes/navbar.jsp"/>
<section class="page"><div class="page-heading"><div><h1>Student Management</h1><p>Manage registered library students.</p></div><a class="btn" href="add-student.jsp">+ Add Student</a></div>
<% if("added".equals(msg)){ %><div class="alert success">Student added successfully. Student ID: <strong><%=Html.esc(request.getParameter("newId"))%></strong> &mdash; default password: <strong>student123</strong></div><% } else if("updated".equals(msg)){ %><div class="alert success">Student updated successfully.</div><% } else if("deleted".equals(msg)){ %><div class="alert success">Student deleted successfully.</div><% } else if("cannotDelete".equals(msg)){ %><div class="alert error">Student cannot be deleted while a book is issued.</div><% } %>
<div class="card table-card"><div class="table-wrap"><table><thead><tr><th>ID</th><th>Name</th><th>Email</th><th>Phone</th><th>Course</th><th>Action</th></tr></thead><tbody>
<% if(students.isEmpty()){ %><tr><td colspan="6" class="empty">No students found.</td></tr><% } else { for(Student s:students){ %>
<tr><td><%=s.getId()%></td><td><strong><%=Html.esc(s.getName())%></strong></td><td><%=Html.esc(s.getEmail()==null?"":s.getEmail())%></td><td><%=Html.esc(s.getPhone()==null?"":s.getPhone())%></td><td><%=Html.esc(s.getCourse()==null?"":s.getCourse())%></td><td><a href="edit-student.jsp?id=<%=s.getId()%>">Edit</a> | <a class="danger-link" href="<%=request.getContextPath()%>/deletestudent?id=<%=s.getId()%>" onclick="return confirm('Delete this student?')">Delete</a></td></tr>
<% }} %></tbody></table></div></div>
</section><jsp:include page="/includes/footer.jsp"/></main></div></body></html>
