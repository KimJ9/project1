<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*, java.io.*" %>
<%
// 클라이언트 IP 확인
String clientIp = request.getHeader("X-Forwarded-For");
if (clientIp == null || clientIp.isEmpty()) {
    clientIp = request.getRemoteAddr();
}
System.out.println("Client IP: " + clientIp);

try {
    // ipinfo.io 요청 URL
    String apiUrl = "https://ipinfo.io/" + clientIp + "/json";
    URL url = new URL(apiUrl);
    HttpURLConnection conn = (HttpURLConnection) url.openConnection();
    conn.setRequestMethod("GET");
    conn.setRequestProperty("Accept", "application/json");
    conn.setConnectTimeout(10000);
    conn.setReadTimeout(10000);

    // 응답 코드 확인
    int status = conn.getResponseCode();
    if (status != 200) {
        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        out.print("{\"error\":\"API request failed with status " + status + "\"}");
        return;
    }

    // 응답 읽기
    BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
    StringBuilder responseBuilder = new StringBuilder();
    String line;
    while ((line = reader.readLine()) != null) {
        responseBuilder.append(line);
    }
    reader.close();
    conn.disconnect();

    // JSON 응답 클라이언트로 전달
    out.print(responseBuilder.toString());
} catch (Exception e) {
    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
    out.print("{\"error\":\"Failed to fetch IP location: " + e.getMessage() + "\"}");
    e.printStackTrace();
}
%>
