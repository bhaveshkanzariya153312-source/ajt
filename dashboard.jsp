<%@ page import="com.library.model.User" %>
<%
if (session.getAttribute("user") == null) { response.sendRedirect(request.getContextPath() + "/login.jsp"); return; }
%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.library.dao.DatabaseConnection,com.library.util.Html,java.sql.*" %>
<%
int books=0,copies=0,students=0,issued=0,returned=0,overdue=0,available=0; double fine=0;
try (Connection con=DatabaseConnection.getConnection(); Statement st=con.createStatement()) {
    try(ResultSet rs=st.executeQuery("SELECT COUNT(*),COALESCE(SUM(quantity),0),COALESCE(SUM(available),0) FROM books")) {
        if(rs.next()){books=rs.getInt(1);copies=rs.getInt(2);available=rs.getInt(3);}
    }
    try(ResultSet rs=st.executeQuery("SELECT COUNT(*) FROM students")) { if(rs.next()) students=rs.getInt(1); }
    try(ResultSet rs=st.executeQuery("SELECT COUNT(*) FROM issues WHERE status='ISSUED'")) { if(rs.next()) issued=rs.getInt(1); }
    try(ResultSet rs=st.executeQuery("SELECT COUNT(*) FROM issues WHERE status='RETURNED'")) { if(rs.next()) returned=rs.getInt(1); }
    try(ResultSet rs=st.executeQuery("SELECT COUNT(*) FROM issues WHERE status='ISSUED' AND due_date<CURDATE()")) { if(rs.next()) overdue=rs.getInt(1); }
    try(ResultSet rs=st.executeQuery("SELECT COALESCE(SUM(GREATEST(DATEDIFF(CURDATE(),due_date),0)*5),0) FROM issues WHERE status='ISSUED'")) { if(rs.next()) fine=rs.getDouble(1); }
} catch(Exception e) { request.setAttribute("dbError", DatabaseConnection.describeError(e)); }
%>
<!DOCTYPE html><html><head><meta charset="UTF-8"><title>Dashboard</title><link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/style.css"><meta name="viewport" content="width=device-width,initial-scale=1"></head>
<body><div class="app-shell"><jsp:include page="/includes/sidebar.jsp"/><main class="main-content"><jsp:include page="/includes/navbar.jsp"/>
<section class="page">
<div class="page-heading"><div><h1>Dashboard</h1><p>Real-time library management overview</p></div></div>
<% if(request.getAttribute("dbError")!=null){ %><div class="alert error"><strong>Database connection error:</strong> <%=Html.esc(request.getAttribute("dbError"))%></div><% } %>
<div class="stats">
<div class="stat-card"><span>&#128218; Total Book Titles</span><strong><%=books%></strong></div>
<div class="stat-card"><span>&#128230; Total Copies</span><strong><%=copies%></strong></div>
<div class="stat-card"><span>&#127891; Registered Students</span><strong><%=students%></strong></div>
<div class="stat-card"><span>&#128228; Currently Issued</span><strong><%=issued%></strong></div>
<div class="stat-card"><span>&#128229; Returned</span><strong><%=returned%></strong></div>
<div class="stat-card"><span>&#9989; Available Copies</span><strong><%=available%></strong></div>
<div class="stat-card"><span>&#9888; Overdue Books</span><strong><%=overdue%></strong></div>
<div class="stat-card"><span>&#128176; Current Fine</span><strong>&#8377;<%=String.format("%.0f",fine)%></strong></div>
</div>
<div class="card"><h2>Quick Actions</h2><div class="quick-links">
<a class="quick" href="add-book.jsp">&#10133; Add Book</a>
<a class="quick" href="books.jsp">&#128218; Manage Books</a>
<a class="quick" href="add-student.jsp">&#127891; Add Student</a>
<a class="quick" href="issue-book.jsp">&#128228; Issue Book</a>
<a class="quick" href="return-book.jsp">&#128229; Return Book</a>
<a class="quick" href="fines.jsp">&#128176; Manage Fines</a>
<a class="quick" href="reports.jsp">&#128202; Reports</a>
</div></div>
</section><jsp:include page="/includes/footer.jsp"/></main></div></body></html>
