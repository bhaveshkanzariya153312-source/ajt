<%@ page import="com.library.model.User" %>
<%
if (session.getAttribute("user") == null) { response.sendRedirect(request.getContextPath() + "/login.jsp"); return; }
%>

<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.library.util.Html" %>
<%@ page import="com.library.dao.BookDAO,com.library.model.Book,java.util.List" %>
<%
String q=request.getParameter("q");
List<Book> books=new BookDAO().getAll(q);
String msg=request.getParameter("msg");
%>
<!DOCTYPE html><html><head><meta charset="UTF-8"><title>Books</title><link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/style.css"></head>
<body><div class="app-shell"><jsp:include page="/includes/sidebar.jsp"/><main class="main-content"><jsp:include page="/includes/navbar.jsp"/>
<section class="page">
<div class="page-heading"><div><h1>Book Management</h1><p>Add, search, edit and remove books.</p></div><a class="btn" href="add-book.jsp">+ Add Book</a></div>
<% if("added".equals(msg)){ %><div class="alert success">Book added successfully.</div><% } else if("updated".equals(msg)){ %><div class="alert success">Book updated successfully.</div><% } else if("deleted".equals(msg)){ %><div class="alert success">Book deleted successfully.</div><% } else if("cannotDelete".equals(msg)){ %><div class="alert error">Book cannot be deleted while a copy is issued to a student.</div><% } %>
<form class="search-bar" method="get" action="books.jsp"><input name="q" value="<%=Html.esc(q==null?"":q)%>" placeholder="Search title, author, category or ISBN"><button class="btn" type="submit">Search</button></form>
<div class="card table-card"><div class="table-wrap"><table><thead><tr><th>ID</th><th>Title</th><th>Author</th><th>Category</th><th>ISBN</th><th>Qty</th><th>Available</th><th>Action</th></tr></thead><tbody>
<% if(books.isEmpty()){ %><tr><td colspan="8" class="empty">No books found.</td></tr><% } else { for(Book b:books){ %>
<tr><td><%=b.getId()%></td><td><strong><%=Html.esc(b.getTitle())%></strong></td><td><%=Html.esc(b.getAuthor())%></td><td><%=Html.esc(b.getCategory()==null?"":b.getCategory())%></td><td><%=Html.esc(b.getIsbn()==null?"":b.getIsbn())%></td><td><%=b.getQuantity()%></td><td><span class="badge <%=b.getAvailable()>0?"available":"unavailable"%>"><%=b.getAvailable()%></span></td><td><a href="edit-book.jsp?id=<%=b.getId()%>">Edit</a> | <a class="danger-link" href="<%=request.getContextPath()%>/deleteBook?id=<%=b.getId()%>" onclick="return confirm('Delete this book?')">Delete</a></td></tr>
<% }} %></tbody></table></div></div>
</section><jsp:include page="/includes/footer.jsp"/></main></div></body></html>
