<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>데이터베이스 관리</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            background-color: #f5f5f5;
        }
        .container {
            background-color: #fff;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            text-align: center;
            width: 400px;
        }
        h2 {
            margin-bottom: 20px;
            color: #333;
        }
        .form-group {
            margin-bottom: 15px;
            text-align: left;
        }
        label {
            display: inline-block;
            width: 140px; /* 수정: 120px -> 140px */
            color: #555;
        }
        input {
            width: calc(100% - 150px); /* 수정: 130px -> 150px */
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 3px;
            box-sizing: border-box;
        }
        button {
            padding: 10px 15px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 3px;
            cursor: pointer;
            font-size: 14px;
            margin: 5px;
        }
        button:hover {
            background-color: #0056b3;
        }
        .status {
            color: green;
            margin: 10px 0;
        }
        .error {
            color: red;
            margin: 10px 0;
        }
        .disabled {
            background-color: #cccccc;
            cursor: not-allowed;
        }
    </style>
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            var saveButton = document.querySelector('button[value="save"]');
            var createButton = document.querySelector('button[value="create"]');
            var sqlButton = document.querySelector('button[value="sql"]');
            saveButton.disabled = true;
            saveButton.classList.add("disabled");
            createButton.disabled = true;
            createButton.classList.add("disabled");
            sqlButton.disabled = true;
            sqlButton.classList.add("disabled");
            checkConnectionStatus();
        });

        function checkConnectionStatus() {
            var statusElement = document.querySelector(".status");
            var dbStatusElement = document.querySelector(".db-status");
            var saveButton = document.querySelector('button[value="save"]');
            var createButton = document.querySelector('button[value="create"]');
            var sqlButton = document.querySelector('button[value="sql"]');
            if ((statusElement && (
                    statusElement.textContent.includes("성공적으로 연결되었습니다") ||
                    statusElement.textContent.includes("설정이 저장되었습니다")
                )) ||
                (dbStatusElement && (
                    dbStatusElement.textContent.includes("이미 존재합니다") ||
                    dbStatusElement.textContent.includes("성공적으로 생성되었습니다")
                ))
            ) {
                saveButton.disabled = false;
                saveButton.classList.remove("disabled");
                createButton.disabled = false;
                createButton.classList.remove("disabled");
                sqlButton.disabled = false;
                sqlButton.classList.remove("disabled");
            }
        }
    </script>
</head>
<body>
    <div class="container">
        <h2>MySql 데이터베이스 설정</h2>
        <form method="post" action="${pageContext.request.contextPath}/dbadmin" onsubmit="setTimeout(checkConnectionStatus, 100)">
            <div class="form-group">
                <label>호스트:</label>
                <input type="text" name="host" value="${form.host != null ? form.host : config.host}">
            </div>
            <div class="form-group">
                <label>포트:</label>
                <input type="text" name="port" value="${form.port != null ? form.port : config.port}">
            </div>
            <div class="form-group">
                <label>사용자 이름:</label>
                <input type="text" name="username" value="${form.username != null ? form.username : config.username}">
            </div>
            <div class="form-group">
                <label>비밀번호:</label>
                <input type="password" name="password" value="${form.password != null ? form.password : config.password}">
            </div>
            <div class="form-group">
                <label>데이터베이스 이름:</label>
                <span>tourdb</span>
            </div>
            <div>
                <button type="submit" name="action" value="test">연결 테스트</button>
                <button type="submit" name="action" value="save">설정 저장</button>
                <button type="submit" name="action" value="create">tourdb 생성</button>
                <button type="button" onclick="window.location.href='${pageContext.request.contextPath}/sql'" value="sql">SQL 실행</button>
            </div>
        </form>
        <c:if test="${not empty connectionStatus}">
            <p class="${connectionStatus.contains('실패') ? 'error' : 'status'}">
                연결 상태: ${connectionStatus}
            </p>
        </c:if>
        <c:if test="${not empty dbStatus}">
            <p class="${dbStatus.contains('실패') ? 'error' : 'status'} db-status">
                데이터베이스 상태: ${dbStatus}
            </p>
        </c:if>
    </div>
</body>
</html>
