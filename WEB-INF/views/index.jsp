<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>관광지 검색</title>

    <style>
        /* 기존 CSS 유지 (변경 없음) */
        body {
            font-family: 'Malgun Gothic', Arial, sans-serif;
            margin: 0;
            background-color: #f5f5f5;
            display: flex;
            flex-direction: column;
            align-items: center;
            min-height: 100vh;
            padding: 13px;
            box-sizing: border-box;
        }
        
        .title-container {
            width: clamp(300px, 90vw, 1200px);
            background-image: url('${pageContext.request.contextPath}/resources/bg1.jpg');
            background-size: 100% 100%;
            background-position: center;
            background-repeat: no-repeat;
            background-color: #e6f3ff;
            padding: clamp(8px, 2vw, 12px);
            border: 1px solid #ddd;
            border-radius: 8px;
            margin-bottom: 10px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            box-sizing: border-box;
            max-height: 100px;
            min-height: 80px;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }

        .title-container h1 {
            margin: 0;
            font-size: clamp(24px, 5vw, 32px);
            line-height: 1.2;
            color: #4A4A4A;
            font-weight: 600;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.2);
            text-align: center;
        }

        .search-form {
            background-color: #fff;
            padding: clamp(15px, 3vw, 25px);
            border: 1px solid #ddd;
            border-radius: 8px;
            margin-bottom: 20px;
            width: clamp(300px, 90vw, 1200px);
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            box-sizing: border-box;
        }
        
        .search-form label {
            font-size: clamp(14px, 2.5vw, 16px);
            margin: 0;
            padding: 0;
            line-height: 1.5;
            text-align: left;
        }
        
        .search-form input, .search-form select {
            padding: clamp(8px, 1.8vw, 10px);
            border: 1px solid #ddd;
            border-radius: 4px;
            margin: 0;
            font-size: clamp(14px, 2.5vw, 16px);
            box-sizing: border-box;
            line-height: 1.5;
            height: clamp(38px, 4.8vw, 42px);
            overflow: visible;
        }
        
        .search-form input[name="mapX"], .search-form input[name="mapY"] {
            width: clamp(100px, 10vw, 130px);
        }
        
        .search-form input[name="radius"] {
            width: clamp(60px, 8vw, 80px);
        }
        
        .search-form select[name="gungu"], .search-form select[name="sido"], .search-form select[name="arrange"] {
            width: clamp(150px, 18vw, 180px);
        }
        
        .search-form button {
            background-color: #007bff;
            color: white;
            border: none;
            padding: clamp(8px, 1.8vw, 10px);
            border-radius: 4px;
            cursor: pointer;
            font-size: clamp(14px, 2.5vw, 16px);
            width: clamp(80px, 12vw, 120px);
            height: clamp(38px, 4.8vw, 42px);
            box-sizing: border-box;
            white-space: nowrap;
        }
        
        .search-form button:hover {
            background-color: #0056b3;
        }
        
        .search-form button#getCurrentLocationBtn, .search-form button#showMapBtn {
            background-color: #6c757d;
            width: clamp(80px, 20vw, 100px);
        }
        
        .search-form button#getCurrentLocationBtn:hover, .search-form button#showMapBtn:hover {
            background-color: #5a6268;
        }
        
        .search-form button#applyRegionBtn {
            background-color: #28a745;
            width: clamp(60px, 8vw, 80px);
        }
        
        .search-form button#applyRegionBtn:hover {
            background-color: #218838;
        }
        
        .search-form button#showMapBtn {
            margin-right: 20px;
        }
        
        .search-form button#festivalBtn {
            background-color: #ff6f61;
            height: clamp(38px, 4.8vw, 42px);
        }
        
        .search-form button#festivalBtn:hover {
            background-color: #e65b50;
        }
        
        .content-type-list {
            display: flex;
            gap: 10px;
            margin-bottom: 15px;
            flex-wrap: wrap;
            overflow-x: auto;
        }
        
        .content-type-list label {
            display: flex;
            align-items: center;
            margin-right: 15px;
            font-size: clamp(12px, 2vw, 16px);
        }
        
        .content-type-list input[type="radio"] {
            margin-right: 5px;
        }
        
        .form-row {
            display: flex;
            align-items: center;
            flex-wrap: wrap;
            gap: 10px;
            margin-bottom: 10px;
        }
        
        .combo-container {
            display: flex;
            flex-direction: row;
            align-items: center;
            gap: 4px;
            margin: 0;
            padding: 0;
            flex-wrap: nowrap;
        }
        
        .button-row {
            display: flex;
            align-items: center;
            flex-wrap: wrap;
            gap: 8px;
        }
        
        .sort-group {
            display: flex;
            align-items: center;
            flex-wrap: nowrap;
            gap: 8px;
            flex: 0 0 auto;
        }
        
        .sort-group .combo-container {
            gap: 4px;
            margin: 0;
            padding: 0;
        }
        
        .sort-group .combo-container label {
            margin: 0;
            padding: 0;
            font-size: clamp(14px, 2.5vw, 16px);
            line-height: 1.5;
            min-width: 50px;
            text-align: left;
        }
        
        .sort-group .combo-container select {
            margin: 0;
            padding: clamp(8px, 1.8vw, 10px);
            font-size: clamp(14px, 2.5vw, 16px);
            line-height: 1.5;
            height: clamp(38px, 4.8vw, 42px);
        }
        
        .error {
            color: red;
            margin-bottom: 20px;
            font-size: clamp(14px, 2.5vw, 16px);
        }
        
        .no-results {
            font-size: clamp(16px, 2.5vw, 20px);
            margin-bottom: 20px;
            color: #333;
        }
        
        .results {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            width: clamp(300px, 90vw, 1200px);
            margin-left: 0;
        }

        .result-item {
            width: calc(25% - 10px);
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 10px;
            text-align: center;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            box-sizing: border-box;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        .result-item:hover, .result-item.touched {
            transform: scale(1.05);
            box-shadow: 0 6px 12px rgba(0,0,0,0.25);
        }
        .result-item img {
            width: 100%;
            height: 180px;
            object-fit: cover;
            border-radius: 8px;
            margin-bottom: 10px;
            margin-left: 0;
            user-select: none;
            user-drag: none;
            -webkit-user-drag: none;
            touch-action: auto;
            pointer-events: auto;
        }
        .result-item .no-image {
            width: 100%;
            height: 180px;
            background-color: #f0f0f0;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #888;
            border-radius: 8px;
            margin-bottom: 10px;
            user-select: none;
            user-drag: none;
            -webkit-user-drag: none;
            touch-action: auto;
            pointer-events: auto;
        }
        .result-item a {
            touch-action: manipulation;
            pointer-events: auto;
            text-decoration: none;
            color: inherit;
        }

        .result-item h3 {
            font-size: clamp(16px, 2.5vw, 20px);
            margin: 0 0 10px 0;
            white-space: normal;
            word-break: break-all;
            line-height: 1.4;
            max-height: 2.8em;
            overflow: hidden;
        }
        
        .total-count {
            font-size: clamp(16px, 2.5vw, 20px);
            margin-bottom: 20px;
        }
        
        .pagination {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            align-items: center;
            gap: 8px;
            margin-top: 20px;
            width: clamp(300px, 90vw, 1200px);
            min-height: 40px;
        }
        
        .pagination a, .pagination span {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            margin: 0;
            padding: clamp(6px, 1.5vw, 8px) clamp(10px, 2vw, 12px);
            text-decoration: none;
            color: #007bff;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: clamp(12px, 2vw, 16px);
            min-width: 32px;
            height: 32px;
            box-sizing: border-box;
        }
        
        .pagination a:hover {
            background-color: #f0f0f0;
        }
        
        .pagination .current {
            background-color: #007bff;
            color: white;
            border-color: #007bff;
        }
        
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0,0,0,0.4);
        }
        
        .modal-content {
            background-color: #fefefe;
            margin: 10% auto;
            padding: 20px;
            border: 1px solid #888;
            width: clamp(300px, 90vw, 1000px);
            border-radius: 8px;
        }
        
        .close {
            color: #aaa;
            float: right;
            font-size: clamp(24px, 4vw, 32px);
            font-weight: bold;
        }
        
        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }

        .result-item h3 .title {
            font-size: clamp(14px, 2.1875vw, 17px);
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            line-height: 1.4;
        }

        .results .result-item h3 > a:hover {
            text-decoration: underline;
        }

        .result-item h3 .title-text {
            font-size: inherit;
        }

        .result-item h3 .distance {
            font-size: clamp(11px, 1.5625vw, 14px);
            color: #666;
            line-height: 1.4;
            text-decoration: none;
        }

        .result-item h3 .date {
            font-size: clamp(11px, 1.5625vw, 14px);
            color: #666;
            line-height: 1.4;
            text-decoration: none;
        }

        #map {
            width: 100%;
            height: 400px;
        }
        
        @media (max-width: 768px) {
            body {
                padding: 10px;
            }
        
            .title-container {
                max-height: 83px;
                padding: 6px;
                margin-bottom: 10px;
            }

            .title-container h1 {
                font-size: clamp(20px, 4vw, 24px);
            }
        
            .search-form {
                padding: 10px;
                margin-bottom: 15px;
            }
        
            .search-form label {
                font-size: clamp(11px, 2.5vw, 13px);
                margin: 0;
                padding: 0;
                min-width: 40px;
                line-height: 1.5;
                text-align: left;
            }
        
            .search-form input, .search-form select {
                font-size: clamp(11px, 2.5vw, 13px);
                margin: 0;
                padding: clamp(7px, 1.6vw, 9px);
                line-height: 1.5;
                height: clamp(36px, 4.5vw, 40px);
                overflow: visible;
            }
        
            .search-form input[name="mapX"], .search-form input[name="mapY"] {
                width: clamp(80px, 15vw, 100px);
            }
        
            .search-form input[name="radius"] {
                width: clamp(50px, 10vw, 60px);
            }
        
            .search-form select[name="gungu"], .search-form select[name="sido"], .search-form select[name="arrange"] {
                width: clamp(80px, 15vw, 100px);
            }
        
            .search-form button {
                width: clamp(80px, 20vw, 100px);
                height: clamp(36px, 4.5vw, 40px);
                font-size: clamp(11px, 2.5vw, 13px);
                padding: clamp(7px, 1.6vw, 9px);
            }
        
            .combo-container {
                gap: 3px;
                margin: 0;
                padding: 0;
                flex-wrap: nowrap;
            }
        
            .form-row {
                display: flex;
                flex-direction: row;
                flex-wrap: wrap;
                gap: 8px;
                align-items: center;
            }
        
            .button-row {
                gap: 6px;
            }
        
            .form-row .combo-container:nth-child(1) {
                flex: 1 1 100%;
                display: flex;
                justify-content: flex-start;
                gap: 4px;
            }
        
            .form-row .combo-container:nth-child(2),
            .form-row .combo-container:nth-child(3) {
                flex: 1 1 calc(50% - 8px);
                min-width: 130px;
            }
        
            .form-row .combo-container:nth-child(4) {
                flex: 1 1 100%;
                min-width: 130px;
            }
        
            .button-row button#getCurrentLocationBtn,
            .button-row button#showMapBtn {
                width: clamp(80px, 20vw, 100px);
                flex: 0 0 auto;
            }
        
            .sort-group {
                gap: 6px;
            }
        
            .sort-group .combo-container {
                gap: 3px;
            }
        
            .sort-group .combo-container label {
                font-size: clamp(11px, 2.5vw, 13px);
                min-width: 40px;
                text-align: left;
            }
        
            .sort-group .combo-container select {
                font-size: clamp(11px, 2.5vw, 13px);
                padding: clamp(7px, 1.6vw, 9px);
                height: clamp(36px, 4.5vw, 40px);
                line-height: 1.5;
            }
        
            .button-row button#searchBtn {
                flex: 0 0 auto;
                width: clamp(80px, 20vw, 100px);
            }
        
            .results {
                flex-direction: row;
                flex-wrap: wrap;
                gap: 10px;
            }
        
            .result-item {
                width: calc(50% - 10px);
            }

            .result-item img, .result-item .no-image {
                height: 150px;
            }

            .pagination {
                gap: 6px;
                min-height: 36px;
            }
        
            .pagination a, .pagination span {
                min-width: 28px;
                height: 28px;
                font-size: clamp(11px, 2.5vw, 14px);
                padding: clamp(4px, 1vw, 6px) clamp(8px, 1.5vw, 10px);
            }
        
            .modal-content {
                margin: 15% auto;
                padding: 15px;
            }
        
            #map {
                height: 300px;
            }
        }

        @media (max-width: 360px) {
            .search-form label {
                font-size: clamp(9px, 2vw, 11px);
                margin: 0;
                padding: 0;
                min-width: 35px;
                line-height: 1.5;
                text-align: left;
            }

            .search-form input, .search-form select {
                font-size: clamp(9px, 2vw, 11px);
                margin: 0;
                padding: clamp(5px, 1.2vw, 6px);
                line-height: 1.5;
                height: clamp(30px, 3.8vw, 34px);
                overflow: visible;
            }

            .search-form input[name="mapX"], .search-form input[name="mapY"] {
                width: clamp(60px, 12vw, 80px);
            }

            .search-form input[name="radius"] {
                width: clamp(50px, 10vw, 60px);
            }

            .search-form select[name="gungu"], .search-form select[name="sido"], .search-form select[name="arrange"] {
                width: clamp(60px, 12vw, 80px);
            }

            .search-form button {
                width: clamp(70px, 18vw, 90px);
                height: clamp(30px, 3.8vw, 34px);
                font-size: clamp(9px, 2vw, 11px);
                padding: clamp(5px, 1.2vw, 6px);
            }

            .form-row, .button-row {
                gap: 4px;
            }

            .form-row .combo-container,
            .button-row .combo-container,
            .button-row button {
                min-width: 100px;
            }

            .form-row .combo-container:nth-child(1) {
                gap: 3px;
            }

            .form-row .combo-container:nth-child(2),
            .form-row .combo-container:nth-child(3) {
                flex: 1 1 calc(50% - 6px);
                min-width: 100px;
            }

            .form-row .combo-container:nth-child(4) {
                min-width: 100px;
            }

            .button-row button#getCurrentLocationBtn,
            .button-row button#showMapBtn {
                width: clamp(70px, 18vw, 90px);
            }

            .sort-group {
                gap: 4px;
            }

            .sort-group .combo-container {
                gap: 2px;
            }

            .sort-group .combo-container label {
                font-size: clamp(9px, 2vw, 11px);
                min-width: 35px;
                text-align: left;
            }

            .sort-group .combo-container select {
                font-size: clamp(9px, 2vw, 11px);
                padding: clamp(5px, 1.2vw, 6px);
                height: clamp(30px, 3.8vw, 34px);
                line-height: 1.5;
            }

            .button-row button#searchBtn {
                width: clamp(70px, 18vw, 90px);
            }

            .results {
                flex-direction: row;
                flex-wrap: wrap;
                gap: 8px;
            }

            .result-item {
                width: calc(100% - 8px);
            }

            .result-item img, .result-item .no-image {
                height: 120px;
            }

            .result-item h3 .title {
                font-size: clamp(11px, 1.8vw, 14px);
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
                line-height: 1.4;
            }

            .result-item h3 .title-text {
                font-size: inherit;
            }

            .result-item h3 .distance {
                font-size: clamp(9px, 2vw, 11px);
                color: #666;
                line-height: 1.4;
            }

            .result-item h3 .date {
                font-size: clamp(9px, 2vw, 11px);
                color: #666;
                line-height: 1.4;
            }
        }
    </style>
</head>
<body>
    <div class="title-container">
        <h1>관광지 검색</h1>
    </div>

    <div class="search-form">
        <form id="searchForm" action="${pageContext.request.contextPath}/search" method="get">
            <div class="content-type-list">
                <label><input type="radio" name="contentTypeId" value="" data-title="전체" ${param.contentTypeId == '' ? 'checked' : ''}> 전체</label>
                <label><input type="radio" name="contentTypeId" value="12" data-title="관광지" ${param.contentTypeId == '12' ? 'checked' : ''}> 관광지</label>
                <label><input type="radio" name="contentTypeId" value="14" data-title="문화시설" ${param.contentTypeId == '14' ? 'checked' : ''}> 문화시설</label>
                <label><input type="radio" name="contentTypeId" value="15" data-title="행사/공연/축제" ${param.contentTypeId == '15' ? 'checked' : ''}> 행사/공연/축제</label>
                <label><input type="radio" name="contentTypeId" value="25" data-title="여행코스" ${param.contentTypeId == '25' ? 'checked' : ''}> 여행코스</label>
                <label><input type="radio" name="contentTypeId" value="28" data-title="레포츠" ${param.contentTypeId == '28' ? 'checked' : ''}> 레포츠</label>
                <label><input type="radio" name="contentTypeId" value="32" data-title="숙박" ${param.contentTypeId == '32' ? 'checked' : ''}> 숙박</label>
                <label><input type="radio" name="contentTypeId" value="38" data-title="쇼핑" ${param.contentTypeId == '38' ? 'checked' : ''}> 쇼핑</label>
                <label><input type="radio" name="contentTypeId" value="39" data-title="음식점" ${param.contentTypeId == '39' ? 'checked' : ''}> 음식점</label>
            </div>

            <div class="form-row">
                <div class="combo-container">
                    <select name="sido" id="sido">
                        <option value="">시/도 선택</option>
                        <option value="강원" ${param.sido == '강원' ? 'selected' : ''}>강원</option>
                        <option value="경기" ${param.sido == '경기' ? 'selected' : ''}>경기</option>
                        <option value="경남" ${param.sido == '경남' ? 'selected' : ''}>경남</option>
                        <option value="경북" ${param.sido == '경북' ? 'selected' : ''}>경북</option>
                        <option value="광주" ${param.sido == '광주' ? 'selected' : ''}>광주</option>
                        <option value="대구" ${param.sido == '대구' ? 'selected' : ''}>대구</option>
                        <option value="대전" ${param.sido == '대전' ? 'selected' : ''}>대전</option>
                        <option value="부산" ${param.sido == '부산' ? 'selected' : ''}>부산</option>
                        <option value="서울" ${param.sido == '서울' ? 'selected' : ''}>서울</option>
                        <option value="세종" ${param.sido == '세종' ? 'selected' : ''}>세종</option>
                        <option value="울산" ${param.sido == '울산' ? 'selected' : ''}>울산</option>
                        <option value="인천" ${param.sido == '인천' ? 'selected' : ''}>인천</option>
                        <option value="전남" ${param.sido == '전남' ? 'selected' : ''}>전남</option>
                        <option value="전북" ${param.sido == '전북' ? 'selected' : ''}>전북</option>
                        <option value="제주" ${param.sido == '제주' ? 'selected' : ''}>제주</option>
                        <option value="충남" ${param.sido == '충남' ? 'selected' : ''}>충남</option>
                        <option value="충북" ${param.sido == '충북' ? 'selected' : ''}>충북</option>
                    </select>
                    <select name="gungu" id="gungu" disabled>
                        <option value="">군/구 선택</option>
                    </select>
                    <button type="button" id="applyRegionBtn">적용</button>
                </div>
                <label for="mapX">경도(X):</label>
                <input type="text" name="mapX" id="mapX" value="${param.mapX}">
                <label for="mapY">위도(Y):</label>
                <input type="text" name="mapY" id="mapY" value="${param.mapY}">
            </div>

            <div class="button-row">
                <div class="combo-container">
                    <label for="radius">검색 반경(m):</label>
                    <input type="text" name="radius" id="radius" value="${param.radius != null ? param.radius : '4000'}">
                </div>
                <button type="button" id="getCurrentLocationBtn">현재위치로</button>
                <button type="button" id="showMapBtn">지도로선택</button>
                <div class="sort-group">
                    <div class="combo-container">
                        <label for="arrange">정렬:</label>
                        <select name="arrange" id="arrange">
                            <option value="A" ${param.arrange == 'A' ? 'selected' : ''}>제목순</option>
                            <option value="C" ${param.arrange == 'C' ? 'selected' : ''}>수정일순</option>
                            <option value="D" ${param.arrange == 'D' ? 'selected' : ''}>생성일순</option>
                            <option value="E" ${(param.arrange == null || param.arrange == 'E') ? 'selected' : ''}>거리순</option>
                        </select>
                    </div>
                    <button type="submit" id="searchBtn">검색</button>
                    <button type="button" id="festivalBtn">전국행사/예정</button>
                </div>
            </div>
        </form>
    </div>

    <div id="mapModal" class="modal">
        <div class="modal-content">
            <span class="close">×</span>
            <div id="map"></div>
            <div style="margin-top: 15px;">
                <label>경도(X): </label><input type="text" id="modalMapX" readonly>
                <label>위도(Y): </label><input type="text" id="modalMapY" readonly>
                <button type="button" id="submitCoordsBtn">전송</button>
            </div>
        </div>
    </div>

    <c:if test="${not empty error && error != '검색 결과가 없습니다.'}">
        <div class="error">
            <p>에러: ${error}</p>
            <c:if test="${not empty errorCode}">
                <p>에러 코드: ${errorCode}</p>
            </c:if>
            <c:if test="${not empty errorDescription}">
                <p>설명: ${errorDescription}</p>
            </c:if>
        </div>
    </c:if>

    <c:if test="${empty items && not empty param.mapX && error == '검색 결과가 없습니다.' && empty festivalItems}">
        <div class="no-results">
            <p>검색 결과가 없습니다.</p>
        </div>
    </c:if>

    <c:if test="${not empty items}">
        <div class="total-count">
            검색 결과 (총 ${totalCount}건)
        </div>

        <div class="results">
            <c:forEach var="item" items="${items}">
                <div class="result-item">
                    <a href="${pageContext.request.contextPath}/detail?contentId=${item.contentid}&contentTypeId=${item.contenttypeid}&searchContentTypeId=${param.contentTypeId}&mapX=${param.mapX}&mapY=${param.mapY}&radius=${param.radius}&pageNo=${param.pageNo != null ? param.pageNo : '1'}&arrange=${param.arrange}&tab=common&sido=${param.sido}&gungu=${param.gungu}&isFestival=false">
                        <c:choose>
                            <c:when test="${not empty item.firstimage}">
                                <img src="${item.firstimage}" alt="${item.title}"/>
                            </c:when>
                            <c:otherwise>
                                <div class="no-image">NO IMAGE</div>
                            </c:otherwise>
                        </c:choose>
                    </a>
                    <h3>
                        <a href="${pageContext.request.contextPath}/detail?contentId=${item.contentid}&contentTypeId=${item.contenttypeid}&searchContentTypeId=${param.contentTypeId}&mapX=${param.mapX}&mapY=${param.mapY}&radius=${param.radius}&pageNo=${param.pageNo != null ? param.pageNo : '1'}&arrange=${param.arrange}&tab=common&sido=${param.sido}&gungu=${param.gungu}&isFestival=false">
                            <div class="title">
                                <span class="title-text">${item.title}</span>
                            </div>
                        </a>
                        <div class="distance">
                            <fmt:formatNumber value="${item.dist / 1000}" maxFractionDigits="1"/>km
                        </div>
                    </h3>
                </div>
            </c:forEach>
        </div>
        
        <div class="pagination">
            <c:set var="currentPage" value="${param.pageNo != null && param.pageNo != '' ? param.pageNo : 1}" />
            <c:set var="itemsPerPage" value="12" />
            <c:set var="totalPagesCalc" value="${totalCount > 0 ? (totalCount + itemsPerPage - 1) / itemsPerPage : 1}" />
            <c:set var="totalPages" value="${totalPagesCalc.intValue()}" />
            <c:set var="pageGroupSize" value="12" />
            <c:set var="currentGroup" value="${((currentPage - 1) / pageGroupSize).intValue()}" />
            <c:set var="startPage" value="${currentGroup * pageGroupSize + 1}" />
            <c:set var="endPage" value="${startPage + pageGroupSize - 1}" />
            <c:if test="${endPage > totalPages}">
                <c:set var="endPage" value="${totalPages}" />
            </c:if>
    
            <c:if test="${currentPage > 1}">
                <a href="${pageContext.request.contextPath}/search?contentTypeId=${param.contentTypeId}&mapX=${param.mapX}&mapY=${param.mapY}&radius=${param.radius}&arrange=${param.arrange}&pageNo=1&sido=${param.sido}&gungu=${param.gungu}"><<</a>
            </c:if>
            <c:if test="${startPage > 1}">
                <a href="${pageContext.request.contextPath}/search?contentTypeId=${param.contentTypeId}&mapX=${param.mapX}&mapY=${param.mapY}&radius=${param.radius}&arrange=${param.arrange}&pageNo=${startPage - 1}&sido=${param.sido}&gungu=${param.gungu}"><</a>
            </c:if>
            <c:forEach begin="${startPage}" end="${endPage}" var="i">
                <c:choose>
                    <c:when test="${i == currentPage}">
                        <span class="current">${i}</span>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/search?contentTypeId=${param.contentTypeId}&mapX=${param.mapX}&mapY=${param.mapY}&radius=${param.radius}&arrange=${param.arrange}&pageNo=${i}&sido=${param.sido}&gungu=${param.gungu}">${i}</a>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
            <c:if test="${endPage < totalPages}">
                <a href="${pageContext.request.contextPath}/search?contentTypeId=${param.contentTypeId}&mapX=${param.mapX}&mapY=${param.mapY}&radius=${param.radius}&arrange=${param.arrange}&pageNo=${endPage + 1}&sido=${param.sido}&gungu=${param.gungu}">></a>
            </c:if>
            <c:if test="${currentPage < totalPages}">
                <a href="${pageContext.request.contextPath}/search?contentTypeId=${param.contentTypeId}&mapX=${param.mapX}&mapY=${param.mapY}&radius=${param.radius}&arrange=${param.arrange}&pageNo=${totalPages}&sido=${param.sido}&gungu=${param.gungu}">>></a>
            </c:if>
        </div>
    </c:if>

    <c:if test="${not empty festivalItems}">
        <div class="total-count">
            전국 행사 중 / 예정 (총 ${festivalTotalCount}건)
        </div>

        <div class="results">
            <c:forEach var="item" items="${festivalItems}">
                <div class="result-item">
                    <a href="${pageContext.request.contextPath}/detail?contentId=${item.contentid}&contentTypeId=${item.contenttypeid}&searchContentTypeId=${param.contentTypeId}&mapX=${param.mapX}&mapY=${param.mapY}&radius=${param.radius}&pageNo=${param.pageNo != null ? param.pageNo : '1'}&arrange=${param.arrange}&tab=common&sido=${param.sido}&gungu=${param.gungu}&isFestival=true">    
                        <c:choose>
                            <c:when test="${not empty item.firstimage}">
                                <img src="${item.firstimage}" alt="${item.title}"/>
                            </c:when>
                            <c:otherwise>
                                <div class="no-image">NO IMAGE</div>
                            </c:otherwise>
                        </c:choose>
                    </a>
                    <h3>
                        <a href="${pageContext.request.contextPath}/detail?contentId=${item.contentid}&contentTypeId=${item.contenttypeid}&searchContentTypeId=${param.contentTypeId}&mapX=${param.mapX}&mapY=${param.mapY}&radius=${param.radius}&pageNo=${param.pageNo != null ? param.pageNo : '1'}&arrange=${param.arrange}&tab=common&sido=${param.sido}&gungu=${param.gungu}&isFestival=true">    
                            <div class="title">
                                <span>
                                    <c:choose>
                                        <c:when test="${item.areacode == '1'}">서울</c:when>
                                        <c:when test="${item.areacode == '2'}">인천</c:when>
                                        <c:when test="${item.areacode == '3'}">대전</c:when>
                                        <c:when test="${item.areacode == '4'}">대구</c:when>
                                        <c:when test="${item.areacode == '5'}">광주</c:when>
                                        <c:when test="${item.areacode == '6'}">부산</c:when>
                                        <c:when test="${item.areacode == '7'}">울산</c:when>
                                        <c:when test="${item.areacode == '8'}">세종</c:when>
                                        <c:when test="${item.areacode == '31'}">경기</c:when>
                                        <c:when test="${item.areacode == '32'}">강원</c:when>
                                        <c:when test="${item.areacode == '33'}">충북</c:when>
                                        <c:when test="${item.areacode == '34'}">충남</c:when>
                                        <c:when test="${item.areacode == '35'}">경북</c:when>
                                        <c:when test="${item.areacode == '36'}">경남</c:when>
                                        <c:when test="${item.areacode == '37'}">전북</c:when>
                                        <c:when test="${item.areacode == '38'}">전남</c:when>
                                        <c:when test="${item.areacode == '39'}">제주</c:when>
                                        <c:otherwise>알 수 없음</c:otherwise>
                                    </c:choose>
                                </span>
                                <span>${item.title}</span>
                            </div>
                        </a>
                        <div class="date">
                            <fmt:parseDate value="${item.eventstartdate}" pattern="yyyyMMdd" var="parsedStartDate"/>
                            <fmt:formatDate value="${parsedStartDate}" pattern="yyyy-MM-dd"/> ~
                            <fmt:parseDate value="${item.eventenddate}" pattern="yyyyMMdd" var="parsedEndDate"/>
                            <fmt:formatDate value="${parsedEndDate}" pattern="yyyy-MM-dd"/>
                        </div>
                    </h3>
                </div>
            </c:forEach>
        </div>

        <div class="pagination">
            <c:set var="currentPage" value="${param.pageNo != null && param.pageNo != '' ? param.pageNo : 1}" />
            <c:set var="itemsPerPage" value="12" />
            <c:set var="totalPagesCalc" value="${festivalTotalCount > 0 ? (festivalTotalCount + itemsPerPage - 1) / itemsPerPage : 1}" />
            <c:set var="totalPages" value="${totalPagesCalc.intValue()}" />
            <c:set var="pageGroupSize" value="12" />
            <c:set var="currentGroup" value="${((currentPage - 1) / pageGroupSize).intValue()}" />
            <c:set var="startPage" value="${currentGroup * pageGroupSize + 1}" />
            <c:set var="endPage" value="${startPage + pageGroupSize - 1}" />
            <c:if test="${endPage > totalPages}">
                <c:set var="endPage" value="${totalPages}" />
            </c:if>
    
            <c:if test="${currentPage > 1}">
                <a href="${pageContext.request.contextPath}/festival?pageNo=1"><<</a>
            </c:if>
            <c:if test="${startPage > 1}">
                <a href="${pageContext.request.contextPath}/festival?pageNo=${startPage - 1}"><</a>
            </c:if>
            <c:forEach begin="${startPage}" end="${endPage}" var="i">
                <c:choose>
                    <c:when test="${i == currentPage}">
                        <span class="current">${i}</span>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/festival?pageNo=${i}">${i}</a>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
            <c:if test="${endPage < totalPages}">
                <a href="${pageContext.request.contextPath}/festival?pageNo=${endPage + 1}">></a>
            </c:if>
            <c:if test="${currentPage < totalPages}">
                <a href="${pageContext.request.contextPath}/festival?pageNo=${totalPages}">>></a>
            </c:if>
        </div>
    </c:if>

    <script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpKeyId=${naverClientId}&submodules=geocoder"></script>
    <script>
        window.navermap_authFailure = function () {
            console.error("Naver Map API 인증 실패: Client ID 또는 Referer 설정을 확인하세요.");
            alert("네이버 지도 API 인증에 실패했습니다. Client ID 또는 Referer 설정을 확인하세요.");
        };

        const modal = document.getElementById("mapModal");
        const showMapBtn = document.getElementById("showMapBtn");
        const closeBtn = document.getElementsByClassName("close")[0];
        const submitCoordsBtn = document.getElementById("submitCoordsBtn");
        const modalMapX = document.getElementById("modalMapX");
        const modalMapY = document.getElementById("modalMapY");
        const formMapX = document.getElementById("mapX");
        const formMapY = document.getElementById("mapY");
        const searchForm = document.getElementById("searchForm");
        const getCurrentLocationBtn = document.getElementById("getCurrentLocationBtn");
        const sidoSelect = document.getElementById("sido");
        const gunguSelect = document.getElementById("gungu");
        const applyRegionBtn = document.getElementById("applyRegionBtn");
        const festivalBtn = document.getElementById("festivalBtn");

        let regionData = [];
        const contextPath = '${pageContext.request.contextPath}';
        const jsonPath = contextPath + '/resources/data/regionData.json';
        console.log("Context path:", contextPath);
        console.log("Attempting to fetch region data from:", jsonPath);
        fetch(jsonPath, {
            method: 'GET',
            headers: {
                'Accept': 'application/json'
            }
        })
            .then(response => {
                console.log("Fetch response object:", response);
                console.log("Response status:", response.status, "StatusText:", response.statusText);
                console.log("Response ok:", response.ok);
                console.log("Response URL:", response.url);
                if (!response.ok) {
                    throw new Error(`HTTP error! Status: ${response.status}, StatusText: ${response.statusText}`);
                }
                return response.json();
            })
            .then(data => {
                regionData = data;
                console.log("Region data loaded successfully, length:", regionData.length);
                console.log("First few entries:", regionData.slice(0, 3));
                restoreSidoSelection();
            })
            .catch(error => {
                console.error("Error loading region data:", error);
                console.error("Error name:", error.name);
                console.error("Error message:", error.message);
                console.error("Error stack:", error.stack);
                alert("지역 데이터를 로드하지 못했습니다. 서버 설정 또는 파일 경로를 확인해주세요. 오류: " + error.message);
            });

        sidoSelect.addEventListener('change', function() {
            const selectedSido = this.value;
            gunguSelect.innerHTML = '<option value="">군/구 선택</option>';
            gunguSelect.disabled = true;

            if (selectedSido && regionData.length > 0) {
                const filteredGungu = regionData
                    .filter(item => item.sido === selectedSido)
                    .map(item => item.gungu)
                    .sort();
                console.log("Filtered gungu for", selectedSido, ":", filteredGungu);
                filteredGungu.forEach(gungu => {
                    const option = document.createElement('option');
                    option.value = gungu;
                    option.textContent = gungu;
                    if (gungu === '${param.gungu}') {
                        option.selected = true;
                    }
                    gunguSelect.appendChild(option);
                });
                gunguSelect.disabled = false;
            } else {
                console.warn("No region data available or no sido selected.");
            }
        });

        function restoreSidoSelection() {
            const selectedSido = '${param.sido}';
            if (selectedSido && regionData.length > 0) {
                sidoSelect.value = selectedSido;
                const event = new Event('change');
                sidoSelect.dispatchEvent(event);
            }
        }

        applyRegionBtn.addEventListener('click', function() {
            const selectedSido = sidoSelect.value;
            const selectedGungu = gunguSelect.value;

            if (selectedSido && selectedGungu) {
                const selectedRegion = regionData.find(
                    item => item.sido === selectedSido && item.gungu === selectedGungu
                );
                if (selectedRegion) {
                    formMapX.value = selectedRegion.longitude.toFixed(6);
                    formMapY.value = selectedRegion.latitude.toFixed(6);
                    console.log(`Applied coordinates - mapX: ${formMapX.value}, mapY: ${formMapY.value}`);
                } else {
                    alert("선택한 지역의 좌표를 찾을 수 없습니다.");
                }
            } else {
                alert("시/도와 군/구를 모두 선택해주세요.");
            }
        });

        async function getLocationByIP() {
            if (!formMapX || !formMapY) {
                console.error("Form elements not found");
                alert("페이지 요소를 찾을 수 없습니다. 기본값(서울)을 사용합니다.");
                formMapX.value = "126.983745";
                formMapY.value = "37.563446";
                return false;
            }
            try {
                console.log("Attempting to fetch IP location via ipapi...");
                const controller = new AbortController();
                const timeoutId = setTimeout(() => controller.abort(), 10000);
                const response = await fetch('${pageContext.request.contextPath}/api/proxy/ipapi.jsp', {
                    method: 'GET',
                    headers: {
                        'Accept': 'application/json'
                    },
                    signal: controller.signal
                });
                clearTimeout(timeoutId);
                if (!response.ok) {
                    throw new Error(`ipapi API error! Status: ${response.status}, StatusText: ${response.statusText}`);
                }
                const data = await response.json();
                if (data.latitude && data.longitude) {
                    formMapX.value = parseFloat(data.longitude).toFixed(7);
                    formMapY.value = parseFloat(data.latitude).toFixed(7);
                    console.log("IP-based location via ipapi:", formMapX.value, formMapY.value);
                    return true;
                } else {
                    throw new Error("ipapi API failed: No location data");
                }
            } catch (error) {
                console.error("IP Geolocation error (ipapi):", {
                    message: error.message,
                    name: error.name,
                    stack: error.stack
                });
                console.log("Falling back to ipinfo...");
                try {
                    const altController = new AbortController();
                    const altTimeoutId = setTimeout(() => altController.abort(), 10000);
                    const altResponse = await fetch('${pageContext.request.contextPath}/api/proxy/ipinfo.jsp', {
                        method: 'GET',
                        headers: {
                            'Accept': 'application/json'
                        },
                        signal: altController.signal
                    });
                    clearTimeout(altTimeoutId);
                    if (!altResponse.ok) {
                        throw new Error(`IPInfo API error! Status: ${altResponse.status}, StatusText: ${altResponse.statusText}`);
                    }
                    const altData = await altResponse.json();
                    if (altData.loc) {
                        const [lat, lon] = altData.loc.split(',');
                        formMapX.value = parseFloat(lon).toFixed(7);
                        formMapY.value = parseFloat(lat).toFixed(7);
                        console.log("IP-based location via ipinfo:", formMapX.value, formMapY.value);
                        return true;
                    } else {
                        throw new Error("IPInfo API failed: No location data");
                    }
                } catch (altError) {
                    console.error("IP Geolocation error (ipinfo):", {
                        message: altError.message,
                        name: altError.name,
                        stack: altError.stack
                    });
                    formMapX.value = "126.983745";
                    formMapY.value = "37.563446";
                    return false;
                }
            }
        }

        function getCurrentLocation() {
            if (!formMapX || !formMapY) {
                console.error("Form elements not found");
                alert("페이지 요소를 찾을 수 없습니다. 기본값(서울)을 사용합니다.");
                formMapX.value = "126.983745";
                formMapY.value = "37.563446";
                return;
            }

            const isHTTPS = window.location.protocol === 'https:';
            console.log("Protocol detected:", isHTTPS ? "HTTPS" : "HTTP");

            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(
                    function(position) {
                        const lat = position.coords.latitude;
                        const lng = position.coords.longitude;
                        formMapX.value = lng.toFixed(7);
                        formMapY.value = lat.toFixed(7);
                        console.log("Geolocation set - mapX:", formMapX.value, "mapY:", formMapY.value);
                    },
                    async function(error) {
                        console.error("Geolocation error:", error);
                        console.log("Falling back to IP-based location");
                        await getLocationByIP();
                    }
                );
            } else {
                console.log("Geolocation not supported, falling back to IP-based location");
                getLocationByIP();
            }
        }

        function getCurrentLocationcallb(callback) {
            if (!formMapX || !formMapY) {
                console.error("Form elements not found");
                alert("페이지 요소를 찾을 수 없습니다. 기본값(서울)을 사용합니다.");
                formMapX.value = "126.983745";
                formMapY.value = "37.563446";
                callback && callback();
                return;
            }

            const isHTTPS = window.location.protocol === 'https:';
            console.log("Protocol detected:", isHTTPS ? "HTTPS" : "HTTP");

            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(
                    function(position) {
                        const lat = position.coords.latitude;
                        const lng = position.coords.longitude;
                        formMapX.value = lng.toFixed(7);
                        formMapY.value = lat.toFixed(7);
                        console.log("Geolocation set - mapX:", formMapX.value, "mapY:", formMapY.value);
                        callback && callback();
                    },
                    async function(error) {
                        console.error("Geolocation error:", error);
                        console.log("Falling back to IP-based location");
                        await getLocationByIP();
                        callback && callback();
                    }
                );
            } else {
                console.log("Geolocation not supported, falling back to IP-based location");
                getLocationByIP().then(() => {
                    callback && callback();
                });
            }
        }

        searchForm.addEventListener('submit', function(event) {
            if (!formMapX.value || !formMapY.value || isNaN(parseFloat(formMapX.value)) || isNaN(parseFloat(formMapY.value))) {
                event.preventDefault();
                alert("유효한 좌표를 입력하거나 현재 위치를 설정해주세요.");
                formMapX.value = "126.983745";
                formMapY.value = "37.563446";
            }
        });

        showMapBtn.onclick = function() {
            console.log("Show Map button clicked");
            modal.style.display = "block";
            initMap();
        };

        closeBtn.onclick = function() {
            console.log("Modal closed");
            modal.style.display = "none";
        };

        window.onclick = function(event) {
            if (event.target == modal) {
                console.log("Modal closed by clicking outside");
                modal.style.display = "none";
            }
        };

        getCurrentLocationBtn.onclick = function() {
            console.log("Get Current Location button clicked");
            getCurrentLocation();
        };

        let map;
        let marker;
        function initMap() {
            console.log("Initializing Naver Map...");
            const defaultLat = parseFloat(formMapY.value) || 37.563446;
            const defaultLng = parseFloat(formMapX.value) || 126.983745;

            try {
                map = new naver.maps.Map('map', {
                    center: new naver.maps.LatLng(defaultLat, defaultLng),
                    zoom: 15
                });

                marker = new naver.maps.Marker({
                    position: new naver.maps.LatLng(defaultLat, defaultLng),
                    map: map
                });

                naver.maps.Event.addListener(map, 'click', function(e) {
                    const latlng = e.coord;
                    marker.setPosition(latlng);
                    modalMapX.value = latlng._lng.toFixed(7);
                    modalMapY.value = latlng._lat.toFixed(7);
                    console.log("Clicked coordinates - mapX:", modalMapX.value, "mapY:", modalMapY.value);
                });

                console.log("Naver Map initialized successfully");
            } catch (error) {
                console.error("Failed to initialize Naver Map:", error);
            }
        }

        submitCoordsBtn.onclick = function() {
            console.log("Submit coordinates button clicked");
            formMapX.value = modalMapX.value;
            formMapY.value = modalMapY.value;
            modal.style.display = "none";
            searchForm.submit();
        }

        function saveSearchState() {
            const selectedRadio = document.querySelector('input[name="contentTypeId"]:checked');
            const state = {
                contentTypeId: selectedRadio?.value || '',
                sido: sidoSelect.value,
                gungu: gunguSelect.value,
                mapX: document.getElementById('mapX').value,
                mapY: document.getElementById('mapY').value,
                radius: document.getElementById('radius').value || '4000',
                arrange: document.getElementById('arrange').value
            };
            sessionStorage.setItem('searchState', JSON.stringify(state));
        }

        function restoreSearchState() {
            const state = JSON.parse(sessionStorage.getItem('searchState')) || {};
            const urlParams = new URLSearchParams(window.location.search);

            const contentTypeId = urlParams.get('contentTypeId') || state.contentTypeId || '';
            document.querySelectorAll('input[name="contentTypeId"]').forEach(input => {
                input.checked = input.value === contentTypeId;
            });
            if (!contentTypeId) {
                document.querySelector('input[name="contentTypeId"][value=""]').checked = true;
            }

            const sido = urlParams.get('sido') || state.sido || '';
            sidoSelect.value = sido;

            const gungu = urlParams.get('gungu') || state.gungu || '';
            if (sido && regionData.length > 0) {
                const event = new Event('change');
                sidoSelect.dispatchEvent(event);
                if (gungu) {
                    const gunguOptions = Array.from(gunguSelect.options).map(opt => opt.value);
                    if (gunguOptions.includes(gungu)) {
                        gunguSelect.value = gungu;
                    }
                }
            }

            document.getElementById('mapX').value = urlParams.get('mapX') || state.mapX || '';
            document.getElementById('mapY').value = urlParams.get('mapY') || state.mapY || '';
            document.getElementById('radius').value = urlParams.get('radius') || state.radius || '4000';
            document.getElementById('arrange').value = urlParams.get('arrange') || state.arrange || 'E';
        }

        searchForm.addEventListener('submit', function(event) {
            event.preventDefault();
            saveSearchState();
            const selectedRadio = document.querySelector('input[name="contentTypeId"]:checked');
            const params = new URLSearchParams({
                contentTypeId: selectedRadio?.value || '',
                sido: sidoSelect.value,
                gungu: gunguSelect.value,
                mapX: document.getElementById('mapX').value,
                mapY: document.getElementById('mapY').value,
                radius: document.getElementById('radius').value || '4000',
                arrange: document.getElementById('arrange').value,
                pageNo: '1'
            });
            sessionStorage.setItem('isInitialLoad', 'false');
            window.location.href = '${pageContext.request.contextPath}/search?' + params.toString();
        });

        festivalBtn.addEventListener('click', function() {
            saveSearchState();
            const selectedRadio = document.querySelector('input[name="contentTypeId"]:checked');
            const params = new URLSearchParams({
                contentTypeId: selectedRadio?.value || '',
                sido: sidoSelect.value,
                gungu: gunguSelect.value,
                mapX: document.getElementById('mapX').value,
                mapY: document.getElementById('mapY').value,
                radius: document.getElementById('radius').value || '4000',
                arrange: document.getElementById('arrange').value,
                pageNo: '1'
            });
            sessionStorage.setItem('isInitialLoad', 'false');
            window.location.href = '${pageContext.request.contextPath}/festival?' + params.toString();
        });

        document.addEventListener('DOMContentLoaded', function() {
            const isInitialLoad = sessionStorage.getItem('isInitialLoad');
            if (isInitialLoad === null || isInitialLoad === 'true') {
                sessionStorage.setItem('isInitialLoad', 'true');
                getCurrentLocationcallb(() => {
                    festivalBtn.click();
                });
            } else {
                restoreSearchState();
            }

            const resultItems = document.querySelectorAll('.result-item');
            const isTouchDevice = 'ontouchstart' in window || navigator.maxTouchPoints > 0;

            resultItems.forEach(item => {
                if (!isTouchDevice) {
                    item.addEventListener('mouseenter', function() {
                        this.classList.add('hovered');
                    });
                    item.addEventListener('mouseleave', function() {
                        this.classList.remove('hovered');
                    });
                }

                if (isTouchDevice) {
                    let touchMoved = false;
                    let touchStartTime = 0;
                    let startX = 0;
                    let startY = 0;
                    const touchThreshold = 10;

                    item.addEventListener('touchstart', function(e) {
                        touchMoved = false;
                        touchStartTime = Date.now();
                        startX = e.touches[0].clientX;
                        startY = e.touches[0].clientY;
                        this.classList.add('touched');
                    }, { passive: true });

                    item.addEventListener('touchmove', function(e) {
                        const currentX = e.touches[0].clientX;
                        const currentY = e.touches[0].clientY;
                        const moveX = Math.abs(currentX - startX);
                        const moveY = Math.abs(currentY - startY);
                        if (moveX > touchThreshold || moveY > touchThreshold) {
                            touchMoved = true;
                        }
                    }, { passive: true });

                    item.addEventListener('touchend', function(e) {
                        const touchDuration = Date.now() - touchStartTime;
                        this.classList.remove('touched');

                        if (!touchMoved && touchDuration >= 300) {
                            const link = this.querySelector('a');
                            if (link) {
                                window.location.href = link.href;
                            }
                        }
                    }, { passive: false });
                }
            });
        });
    </script>
</body>
</html>