<%@ page import="com.library.model.User" %>
<%
if (session.getAttribute("user") == null) { response.sendRedirect(request.getContextPath() + "/login.jsp"); return; }
%>

<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.library.util.Html" %>
<%@ page import="com.library.dao.FineDAO,com.library.model.Fine,java.util.List" %>
<% List<Fine> fines=new FineDAO().getAllActiveFines(); double total=0; for(Fine f:fines) total+=f.getAmount(); %>
<!DOCTYPE html><html><head><meta charset="UTF-8"><title>Fines</title><link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/style.css"></head>
<body><div class="app-shell"><jsp:include page="/includes/sidebar.jsp"/><main class="main-content"><jsp:include page="/includes/navbar.jsp"/>
<section class="page"><div class="page-heading"><div><h1>Fine Management</h1><p>Automatic fine calculation for overdue books.</p></div><div class="total-fine">Total Current Fine: <strong>&#8377;<%=String.format("%.0f",total)%></strong></div></div>
<div class="card table-card"><div class="table-wrap"><table><thead><tr><th>Issue ID</th><th>Student</th><th>Book</th><th>Due Date</th><th>Days Late</th><th>Fine</th></tr></thead><tbody>
<% if(fines.isEmpty()){ %><tr><td colspan="6" class="empty">No active issues.</td></tr><% } else { for(Fine f:fines){ %>
<tr><td><%=f.getIssueId()%></td><td><%=Html.esc(f.getStudentName())%></td><td><%=Html.esc(f.getBookTitle())%></td><td><%=Html.esc(f.getDueDate())%></td><td><%=f.getDays()%></td><td>&#8377;<%=String.format("%.0f",f.getAmount())%></td></tr>
<% }} %></tbody></table></div></div>
<div class="card"><p><strong>Fine rule:</strong> &#8377;5 per day after the due date.</p></div>
</section><jsp:include page="/includes/footer.jsp"/></main></div></body></html>
