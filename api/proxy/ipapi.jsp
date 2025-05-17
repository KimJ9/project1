<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*, java.io.*" %>
<%
// 클라이언트 IP 확인 (Cafe24 프록시 고려)
String clientIp = request.getHeader("X-Forwarded-For");
if (clientIp == null || clientIp.isEmpty()) {
    clientIp = request.getRemoteAddr();
}
System.out.println("Client IP: " + clientIp);

try {
    // ipapi.co 요청 URL
    String apiUrl = "https://ipapi.co/" + clientIp + "/json/";
    System.out.println("Requesting URL: " + apiUrl); // 디버깅 로그
    URL url = new URL(apiUrl);
    HttpURLConnection conn = (HttpURLConnection) url.openConnection();
    conn.setRequestMethod("GET");
    conn.setRequestProperty("Accept", "application/json");
    conn.setRequestProperty("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36"); // User-Agent 설정
    conn.setConnectTimeout(10000); // 10초 연결 타임아웃
    conn.setReadTimeout(10000);    // 10초 읽기 타임아웃

    // 응답 코드 확인
    int status = conn.getResponseCode();
    System.out.println("Response Status: " + status); // 디버깅 로그
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
    System.out.println("Exception: " + e.getMessage()); // 디버깅 로그
    e.printStackTrace();
}
%>
