<%@ page import="com.library.model.User" %>
<%
if (session.getAttribute("user") == null) {
    response.sendRedirect(request.getContextPath() + "/login.jsp"); return;
}
%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.library.dao.DatabaseConnection,com.library.util.Html,java.sql.*" %>
<%
int titles=0,totalCopies=0,available=0,students=0,issued=0,returned=0,overdue=0;
try(Connection con=DatabaseConnection.getConnection(); Statement st=con.createStatement()){
    try(ResultSet rs=st.executeQuery("SELECT COUNT(*),COALESCE(SUM(quantity),0),COALESCE(SUM(available),0) FROM books")){
        if(rs.next()){titles=rs.getInt(1);totalCopies=rs.getInt(2);available=rs.getInt(3);}
    }
    try(ResultSet rs=st.executeQuery("SELECT COUNT(*) FROM students")){if(rs.next())students=rs.getInt(1);}
    try(ResultSet rs=st.executeQuery("SELECT COUNT(*) FROM issues WHERE status='ISSUED'")){if(rs.next())issued=rs.getInt(1);}
    try(ResultSet rs=st.executeQuery("SELECT COUNT(*) FROM issues WHERE status='RETURNED'")){if(rs.next())returned=rs.getInt(1);}
    try(ResultSet rs=st.executeQuery("SELECT COUNT(*) FROM issues WHERE status='ISSUED' AND due_date<CURDATE()")){if(rs.next())overdue=rs.getInt(1);}
} catch(Exception e) { request.setAttribute("dbError", DatabaseConnection.describeError(e)); }
%>
<!DOCTYPE html><html><head><meta charset="UTF-8"><title>Reports</title><link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/style.css"><meta name="viewport" content="width=device-width,initial-scale=1"></head>
<body><div class="app-shell"><jsp:include page="/includes/sidebar.jsp"/><main class="main-content"><jsp:include page="/includes/navbar.jsp"/>
<section class="page">
<div class="page-heading"><div><h1>Library Reports</h1><p>Real-time statistics and downloadable report.</p></div>
<div><a class="btn" href="<%=request.getContextPath()%>/exportReport">&#11015; Export CSV</a></div></div>
<% if(request.getAttribute("dbError")!=null){ %><div class="alert error"><strong>Database connection error:</strong> <%=Html.esc(request.getAttribute("dbError"))%></div><% } %>
<div class="stats">
<div class="stat-card"><span>&#128218; Book Titles</span><strong><%=titles%></strong></div>
<div class="stat-card"><span>&#128230; Total Copies</span><strong><%=totalCopies%></strong></div>
<div class="stat-card"><span>&#9989; Available Copies</span><strong><%=available%></strong></div>
<div class="stat-card"><span>&#128228; Issued</span><strong><%=issued%></strong></div>
<div class="stat-card"><span>&#128229; Returned</span><strong><%=returned%></strong></div>
<div class="stat-card"><span>&#9888; Overdue</span><strong><%=overdue%></strong></div>
<div class="stat-card"><span>&#127891; Students</span><strong><%=students%></strong></div>
</div>
<div class="card"><h2>Project Summary</h2>
<p><strong>Smart Library Management System</strong> is an AJT web application using JSP, Java Servlets, JDBC, MySQL, HTML, CSS, Bootstrap-compatible responsive design and JavaScript.</p>
<p>Modules include authentication, book management, student management, issue/return transactions, automatic fine calculation, dashboards, reports and PDF transaction receipts.</p>
</div>
</section><jsp:include page="/includes/footer.jsp"/></main></div></body></html>
