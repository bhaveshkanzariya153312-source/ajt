<%
com.library.model.Student loggedStudent = (com.library.model.Student)session.getAttribute("student");
if (loggedStudent == null) { response.sendRedirect(request.getContextPath() + "/student-login.jsp"); return; }
int id = loggedStudent.getId();
%>

<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.library.util.Html" %>
<%@ page import="com.library.dao.IssueDAO,com.library.model.Issue,java.util.List" %>
<%
List<Issue> issues=new IssueDAO().getAllForStudent(id);
%>
<!DOCTYPE html><html><head><meta charset="UTF-8"><title>My Books</title><link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/style.css"><meta name="viewport" content="width=device-width,initial-scale=1"></head>
<body><div class="student-shell"><aside class="sidebar student-side"><div class="side-title">&#127891; Student Portal</div><a href="dashboard.jsp">&#127968; Dashboard</a><a href="books.jsp">&#128214; Books</a><a href="my-books.jsp">&#128218; My Books</a><a href="my-fine.jsp">&#128176; My Fine</a><a href="profile.jsp">&#128100; Profile</a><a href="<%=request.getContextPath()%>/studentLogout">&#128682; Logout</a></aside>
<main class="main-content"><header class="topbar"><div class="brand">My Books</div><div class="user-badge"><%=Html.esc(loggedStudent.getName())%></div></header><section class="page">
<div class="page-heading"><div><h1>My Books</h1><p>Current and previous borrowing history.</p></div></div>
<div class="card table-card"><div class="table-wrap"><table><thead><tr><th>Book</th><th>Issue Date</th><th>Due Date</th><th>Return Date</th><th>Status</th></tr></thead><tbody>
<% if(issues.isEmpty()){ %><tr><td colspan="5" class="empty">No issue history found.</td></tr><% } else { for(Issue i:issues){ %><tr><td><strong><%=Html.esc(i.getBookTitle())%></strong></td><td><%=Html.esc(i.getIssueDate())%></td><td><%=Html.esc(i.getDueDate())%></td><td><%=Html.esc(i.getReturnDate())%></td><td><span class="badge <%=Html.esc("ISSUED".equals(i.getStatus())?"issued":"returned")%>"><%=Html.esc(i.getStatus())%></span></td></tr><% }} %>
</tbody></table></div></div></section><jsp:include page="/includes/footer.jsp"/></main></div></body></html>
