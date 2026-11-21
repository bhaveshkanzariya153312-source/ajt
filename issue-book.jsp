<%@ page import="com.library.model.User" %>
<%
if (session.getAttribute("user") == null) { response.sendRedirect(request.getContextPath() + "/login.jsp"); return; }
%>

<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.library.util.Html" %>
<%@ page import="com.library.dao.BookDAO,com.library.dao.StudentDAO,com.library.model.Book,com.library.model.Student,java.util.List" %>
<%
List<Book> books=new BookDAO().getAvailable(); List<Student> students=new StudentDAO().getAll(); String msg=request.getParameter("msg");
%>
<!DOCTYPE html><html><head><meta charset="UTF-8"><title>Issue Book</title><link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/style.css"></head>
<body><div class="app-shell"><jsp:include page="/includes/sidebar.jsp"/><main class="main-content"><jsp:include page="/includes/navbar.jsp"/>
<section class="page"><div class="page-heading"><div><h1>Issue Book</h1><p>Issue an available book to a student.</p></div></div>
<% if("issued".equals(msg)){ %><div class="alert success">Book issued successfully. Transaction ID: <strong><%=Html.esc(request.getParameter("receipt"))%></strong> &mdash; <a href="<%=request.getContextPath()%>/issueReceipt?id=<%=Html.esc(request.getParameter("receipt"))%>">Download PDF receipt</a></div><iframe src="<%=request.getContextPath()%>/issueReceipt?id=<%=Html.esc(request.getParameter("receipt"))%>" style="display:none" title="receipt"></iframe><% } else if("failed".equals(msg)){ %><div class="alert error">Book could not be issued. Check availability and due date.</div><% } %>
<% if(books.isEmpty() || students.isEmpty()){ %><div class="alert error">You need at least one available book and one student.</div><% } %>
<div class="card form-card"><form method="post" action="<%=request.getContextPath()%>/issueBook">
<label>Book *</label><select name="book_id" required><% for(Book b:books){ %><option value="<%=b.getId()%>"><%=Html.esc(b.getTitle())%> &#8212; <%=Html.esc(b.getAuthor())%> (Available: <%=b.getAvailable()%>)</option><% } %></select>
<label>Student *</label><select name="student_id" required><% for(Student s:students){ %><option value="<%=s.getId()%>"><%=s.getId()%> &#8212; <%=Html.esc(s.getName())%></option><% } %></select>
<label>Due Date *</label><input type="date" name="due_date" value="<%=new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date(System.currentTimeMillis()+14L*24*60*60*1000))%>" min="<%=new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date())%>" required>
<div class="form-actions"><button class="btn" type="submit" <%=books.isEmpty()||students.isEmpty()?"disabled":""%>>Issue Book</button><a class="btn secondary" href="dashboard.jsp">Cancel</a></div>
</form></div></section><jsp:include page="/includes/footer.jsp"/></main></div></body></html>
