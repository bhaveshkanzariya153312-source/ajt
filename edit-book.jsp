<%@ page import="com.library.model.User" %>
<%
if (session.getAttribute("user") == null) { response.sendRedirect(request.getContextPath() + "/login.jsp"); return; }
%>

<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.library.util.Html" %>
<%@ page import="com.library.dao.BookDAO,com.library.model.Book" %>
<%
Book book=null; try { book=new BookDAO().findById(Integer.parseInt(request.getParameter("id"))); } catch(Exception e) {}
%>
<!DOCTYPE html><html><head><meta charset="UTF-8"><title>Edit Book</title><link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/style.css"></head>
<body><div class="app-shell"><jsp:include page="/includes/sidebar.jsp"/><main class="main-content"><jsp:include page="/includes/navbar.jsp"/>
<section class="page"><div class="page-heading"><div><h1>Edit Book</h1><p>Update book details.</p></div></div>
<% if(book==null){ %><div class="alert error">Book not found.</div><% } else { %>
<% if("duplicate".equals(request.getParameter("error"))){ %><div class="alert error">Another book already uses this ISBN.</div><% } else if("invalid".equals(request.getParameter("error"))){ %><div class="alert error">Please enter valid book details.</div><% } %>
<% if("1".equals(request.getParameter("error"))){ %><div class="alert error">Quantity cannot be lower than the number of copies currently issued.</div><% } %>
<div class="card form-card"><form method="post" action="<%=request.getContextPath()%>/updateBook">
<input type="hidden" name="id" value="<%=book.getId()%>">
<label>Title *</label><input name="title" value="<%=Html.esc(book.getTitle())%>" required>
<label>Author *</label><input name="author" value="<%=Html.esc(book.getAuthor())%>" required>
<label>Category</label><input name="category" value="<%=Html.esc(book.getCategory()==null?"":book.getCategory())%>">
<label>ISBN</label><input name="isbn" value="<%=Html.esc(book.getIsbn()==null?"":book.getIsbn())%>">
<label>Total Quantity *</label><input type="number" name="quantity" min="1" value="<%=book.getQuantity()%>" required>
<p class="hint">Currently available: <strong><%=book.getAvailable()%></strong></p>
<div class="form-actions"><button class="btn" type="submit">Update Book</button><a class="btn secondary" href="books.jsp">Cancel</a></div>
</form></div><% } %></section><jsp:include page="/includes/footer.jsp"/></main></div></body></html>
