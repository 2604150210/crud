<%@ page language="java" contentType="application/csv; charset=GBK"
	pageEncoding="GBK"%><%@ page import="com.newsclan.crud.*,java.sql.*"%><%
	if (session.getAttribute("admin") == null
			&& session.getAttribute("report") == null)
		return;

	String sql = (String) session.getAttribute("sql");

	response.setContentType("binary/octet-stream");
	response.setHeader("Content-Disposition", "attachment; filename="
			+ new String("��������.csv".getBytes("gb2312"), "iso8859-1"));

	Field[] fds = DAO.getFields(sql);
	Connection conn = DB.getConnection();
	Statement stmt = conn.createStatement();
	ResultSet rs = stmt.executeQuery(sql);
	for (int i = 0; i < fds.length; i++) {
		if (i > 0)
			out.print(",");
		out.print(fds[i].label);
	}
	out.println();
	while (rs.next()) {
		for (int i = 0; i < fds.length; i++) {
			if (i > 0)
				out.print(",");
			out.print(rs.getString(i + 1));

		}
		out.println();

	}
	DB.close(conn);
%>