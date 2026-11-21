<%@ page import="com.library.model.User" %>
<%
if (session.getAttribute("user") == null) { response.sendRedirect(request.getContextPath() + "/login.jsp"); return; }
%>

<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.library.util.Html" %>
<%@ page import="com.library.dao.IssueDAO,com.library.model.Issue,java.util.List" %>
<% List<Issue> issues=new IssueDAO().getActive(); String msg=request.getParameter("msg"); %>
<!DOCTYPE html><html><head><meta charset="UTF-8"><title>Return Book</title><link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/style.css"></head>
<body><div class="app-shell"><jsp:include page="/includes/sidebar.jsp"/><main class="main-content"><jsp:include page="/includes/navbar.jsp"/>
<section class="page"><div class="page-heading"><div><h1>Return Book</h1><p>Complete an active issue transaction.</p></div></div>
<% if("returned".equals(msg)){ %><div class="alert success">Book returned successfully. <a href="<%=request.getContextPath()%>/returnReceipt?id=<%=Html.esc(request.getParameter("receipt"))%>">Download PDF return receipt</a></div><iframe src="<%=request.getContextPath()%>/returnReceipt?id=<%=Html.esc(request.getParameter("receipt"))%>" style="display:none" title="receipt"></iframe><% } else if("failed".equals(msg)){ %><div class="alert error">This transaction is already returned or does not exist.</div><% } %>
<div class="card table-card"><div class="table-wrap"><table><thead><tr><th>Issue ID</th><th>Book</th><th>Student</th><th>Issue Date</th><th>Due Date</th><th>Action</th></tr></thead><tbody>
<% if(issues.isEmpty()){ %><tr><td colspan="6" class="empty">No active issued books.</td></tr><% } else { for(Issue i:issues){ %>
<tr><td><%=i.getId()%></td><td><strong><%=Html.esc(i.getBookTitle())%></strong></td><td><%=Html.esc(i.getStudentName())%></td><td><%=Html.esc(i.getIssueDate())%></td><td><%=Html.esc(i.getDueDate())%></td><td><a class="btn small" href="<%=request.getContextPath()%>/returnBook?id=<%=i.getId()%>" onclick="return confirm('Return this book?')">Return</a></td></tr>
<% }} %></tbody></table></div></div>
</section><jsp:include page="/includes/footer.jsp"/></main></div></body></html>
