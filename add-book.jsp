<%@ page import="com.library.model.User" %>
<%
if (session.getAttribute("user") == null) { response.sendRedirect(request.getContextPath() + "/login.jsp"); return; }
%>

<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html><html><head><meta charset="UTF-8"><title>Add Book</title><link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/style.css"></head>
<body><div class="app-shell"><jsp:include page="/includes/sidebar.jsp"/><main class="main-content"><jsp:include page="/includes/navbar.jsp"/>
<section class="page"><div class="page-heading"><div><h1>Add New Book</h1><p>Enter book information.</p></div></div>
<% if("duplicate".equals(request.getParameter("error"))){ %><div class="alert error">A book with this ISBN already exists.</div><% } else if("invalid".equals(request.getParameter("error"))){ %><div class="alert error">Please enter valid book details (title, author and quantity of at least 1).</div><% } %>
<div class="card form-card"><form method="post" action="<%=request.getContextPath()%>/addBook">
<label>Title *</label><input name="title" required>
<label>Author *</label><input name="author" required>
<label>Category</label><input name="category">
<label>ISBN</label><input name="isbn">
<label>Quantity *</label><input type="number" name="quantity" min="1" value="1" required>
<div class="form-actions"><button class="btn" type="submit">Save Book</button><a class="btn secondary" href="books.jsp">Cancel</a></div>
</form></div></section><jsp:include page="/includes/footer.jsp"/></main></div></body></html>
