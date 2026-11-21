<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%
String ctx = request.getContextPath();
%>
<header class="topbar">
    <div class="brand">&#128218; SmartLib</div>
    <div class="top-actions">
        <span class="user-badge">Admin Panel</span>
        <a class="logout-link" href="<%=ctx%>/logout">Logout</a>
    </div>
</header>
