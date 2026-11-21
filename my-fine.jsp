<%
com.library.model.Student loggedStudent = (com.library.model.Student)session.getAttribute("student");
if (loggedStudent == null) { response.sendRedirect(request.getContextPath() + "/student-login.jsp"); return; }
int id = loggedStudent.getId();
%>

<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.library.util.Html" %>
<%@ page import="com.library.dao.FineDAO,com.library.model.Fine,java.util.List" %>
<%
FineDAO fdao=new FineDAO(); double total=fdao.getStudentFine(id); List<Fine> fines=fdao.getStudentFines(id);
%>
<!DOCTYPE html><html><head><meta charset="UTF-8"><title>My Fine</title><link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/style.css"><meta name="viewport" content="width=device-width,initial-scale=1"></head>
<body><div class="student-shell"><aside class="sidebar student-side"><div class="side-title">&#127891; Student Portal</div><a href="dashboard.jsp">&#127968; Dashboard</a><a href="books.jsp">&#128214; Books</a><a href="my-books.jsp">&#128218; My Books</a><a href="my-fine.jsp">&#128176; My Fine</a><a href="profile.jsp">&#128100; Profile</a><a href="<%=request.getContextPath()%>/studentLogout">&#128682; Logout</a></aside>
<main class="main-content"><header class="topbar"><div class="brand">My Fine</div><div class="user-badge"><%=Html.esc(loggedStudent.getName())%></div></header><section class="page">
<div class="page-heading"><div><h1>My Fine</h1><p>Automatic calculation at &#8377;5 per overdue day.</p></div></div>
<div class="student-fine-box"><span>Current Fine</span><strong>&#8377;<%=String.format("%.0f",total)%></strong><small>Only active overdue transactions are included.</small></div>
<div class="card table-card"><div class="table-wrap"><table><thead><tr><th>Book</th><th>Due Date</th><th>Days Late</th><th>Fine</th></tr></thead><tbody>
<% boolean found=false; for(Fine f:fines){ if(f.getStudentId()==id && f.getDays()>0){found=true;%><tr><td><%=Html.esc(f.getBookTitle())%></td><td><%=Html.esc(f.getDueDate())%></td><td><%=f.getDays()%></td><td>&#8377;<%=String.format("%.0f",f.getAmount())%></td></tr><% }} if(!found){ %><tr><td colspan="4" class="empty">No overdue fine. Great!</td></tr><% } %>
</tbody></table></div></div></section><jsp:include page="/includes/footer.jsp"/></main></div></body></html>
