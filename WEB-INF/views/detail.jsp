<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>상세 정보</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.4/dist/chart.umd.min.js"></script>
    <style>
        /* 숨김 클래스 추가 */
        .hidden {
            display: none;
        }

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
    background-color: #e6f3ff; /* 대비용 배경색 */
    padding: clamp(8px, 2vw, 12px);
    border: 1px solid #ddd;
    border-radius: 8px;
    margin-bottom: 10px; /* index.jsp와 동일 */
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    box-sizing: border-box;
    max-height: 100px; /* index.jsp와 동일 */
    min-height: 80px; /* index.jsp와 동일 */
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


        .header-container {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-bottom: 20px;
            width: clamp(300px, 90vw, 1200px);
        }

        .tabs {
            display: flex;
            gap: 10px;
            align-items: center;
            flex-wrap: wrap;
        }

        .tabs a, .back-link {
            padding: 8px 12px;
            text-decoration: none;
            color: #007bff;
            border: 1px solid #ddd;
            border-radius: 4px;
            background-color: #fff;
            font-size: 16px;
            font-weight: 400;
            line-height: 1.5;
            white-space: nowrap;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            height: 34px;
            box-sizing: border-box;
            vertical-align: middle;
        }

        .tabs a.active {
            background-color: #007bff;
            color: white;
            border-color: #007bff;
        }

        .back-link {
            margin-left: 1px;
            transform: translateY(-2px);
        }

        .back-link:hover {
            background-color: #f0f0f0;
        }

        .content {
            background-color: #fff;
            padding: clamp(15px, 3vw, 25px);
            border: 1px solid #ddd;
            border-radius: 8px;
            width: clamp(300px, 90vw, 1200px);
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin-bottom: 10px;
            box-sizing: border-box;
        }

        .content img.main-image {
            width: 33.33%;
            height: auto;
            border-radius: 5px;
            margin-bottom: 15px;
            float: left;
        }

        .info-right {
            float: right;
            width: 60%;
            padding-left: 15px;
        }

        .info-right p {
            margin: 8px 0;
            line-height: 1.6;
            font-size: clamp(14px, 2.5vw, 18px);
        }

        .content p {
            margin: 8px 0;
            line-height: 1.6;
            font-size: clamp(14px, 2.5vw, 18px);
        }

        .content ul {
            list-style: none;
            padding: 0;
            margin: 8px 0;
        }

        .content ul li {
            margin: 8px 0;
            font-size: clamp(14px, 2.5vw, 18px);
            line-height: 1.6;
        }

        .content ul li strong {
            font-size: clamp(14px, 2.5vw, 18px);
        }

        .error {
            color: red;
            margin-bottom: 20px;
            font-size: clamp(14px, 2.5vw, 18px);
        }

        .image-gallery {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
        }

        .image-gallery img {
            width: 120px;
            height: 80px;
            object-fit: cover;
            cursor: pointer;
            transition: transform 0.2s;
        }

        .image-gallery img:hover {
            transform: scale(1.05);
        }

        .enlarged-image-container {
            margin-top: 15px;
            width: 100%;
            text-align: center;
        }

        .enlarged-image {
            max-width: 100%;
            height: auto;
            border-radius: 5px;
            display: none;
        }

        .map-button {
            padding: 5px 10px;
            text-decoration: none;
            color: #007bff;
            border: 1px solid #007bff;
            border-radius: 3px;
            background-color: #fff;
            cursor: pointer;
            font-size: clamp(14px, 2.5vw, 16px);
        }

        .map-button:hover {
            background-color: #e6f0ff;
        }

        #map {
            width: 100%;
            height: 400px;
            margin-top: 15px;
            display: none;
        }

        #ageRatioChart {
            width: 400px !important;
            height: 300px !important;
            margin: 0 0 15px 0;
            display: block;
            box-sizing: border-box;
        }

        canvas#ageRatioChart {
            width: 400px !important;
            height: 300px !important;
            transform: none !important;
            scale: none !important;
        }

        .content h3 {
            margin: 0;
            line-height: 1.2;
        }

        .clear {
            clear: both;
        }

        a.back-link:last-child {
            margin-top: 5px;
        }

        @media (max-width: 768px) {
            body {
                padding: 10px;
            }

            .title-container {
        max-height: 83px; /* index.jsp와 동일 */
        min-height: 70px; /* index.jsp와 동일 */
        padding: 6px;
        margin-bottom: 10px; /* index.jsp와 동일 */
    }

    .title-container h1 {
        font-size: clamp(20px, 4vw, 24px);
    }

    
            .header-container {
                flex-direction: row;
                flex-wrap: wrap;
                align-items: center;
                justify-content: center;
            }

            .tabs {
                justify-content: center;
                align-items: center;
            }

            .back-link {
                margin-left: 5px;
                margin-top: 0;
            }

            .tabs a, .back-link {
                padding: 6px 10px;
                font-size: 14px;
                height: 30px;
            }

            .content {
                padding: 10px;
                margin-bottom: 10px;
            }

            .content img.main-image {
                width: 100%;
                float: none;
                margin-bottom: 10px;
            }

            .info-right {
                float: none;
                width: 100%;
                padding-left: 0;
            }

            .image-gallery img {
                width: 100px;
                height: 70px;
            }

            .map-button {
                font-size: clamp(12px, 2.5vw, 14px);
            }

            #map {
                height: 300px;
            }

            #ageRatioChart {
                width: 400px !important;
                height: 300px !important;
                margin: 0 0 15px 0;
                display: block;
            }

            canvas#ageRatioChart {
                width: 400px !important;
                height: 300px !important;
            }

            .content h3 {
                margin: 0;
                line-height: 1.2;
            }

            a.back-link:last-child {
                margin-top: 5px;
            }
        }
    </style>
</head>
<body>
    <div class="title-container">
        <h1>상세 정보</h1>
    </div>

    <!-- 탭 메뉴와 상단 [목록으로] 버튼 -->
    <!--<a href="${pageContext.request.contextPath}/list?contentTypeId=${param.prevContentTypeId}&sido=${param.sido}&gungu=${param.gungu}&mapX=${param.mapX}&mapY=${param.mapY}&radius=${param.radius}&arrange=${param.arrange}&pageNo=${param.pageNo}">목록으로</a>-->
    <div class="header-container">
        <div class="tabs">
            <a href="${pageContext.request.contextPath}/detail?contentId=${contentId}&mapX=${mapX}&mapY=${mapY}&radius=${radius}&pageNo=${pageNo}&tab=common&contentTypeId=${contentTypeId}&searchContentTypeId=${searchContentTypeId}&arrange=${arrange}&sido=${param.sido}&gungu=${param.gungu}" class="${tab == 'common' ? 'active' : ''}">공통정보</a>
            <a href="${pageContext.request.contextPath}/detail?contentId=${contentId}&mapX=${mapX}&mapY=${mapY}&radius=${radius}&pageNo=${pageNo}&tab=intro&contentTypeId=${contentTypeId}&searchContentTypeId=${searchContentTypeId}&arrange=${arrange}&sido=${param.sido}&gungu=${param.gungu}" class="${tab == 'intro' ? 'active' : ''}">소개정보</a>
            <a href="${pageContext.request.contextPath}/detail?contentId=${contentId}&mapX=${mapX}&mapY=${mapY}&radius=${radius}&pageNo=${pageNo}&tab=info&contentTypeId=${contentTypeId}&searchContentTypeId=${searchContentTypeId}&arrange=${arrange}&sido=${param.sido}&gungu=${param.gungu}" class="${tab == 'info' ? 'active' : ''}">반복정보</a>
            <a href="${pageContext.request.contextPath}/detail?contentId=${contentId}&mapX=${mapX}&mapY=${mapY}&radius=${radius}&pageNo=${pageNo}&tab=image&contentTypeId=${contentTypeId}&searchContentTypeId=${searchContentTypeId}&arrange=${arrange}&sido=${param.sido}&gungu=${param.gungu}" class="${tab == 'image' ? 'active' : ''}">추가이미지</a>
            <a href="${pageContext.request.contextPath}/${param.isFestival == 'true' ? 'festival' : 'search'}?contentTypeId=${searchContentTypeId}&mapX=${mapX}&mapY=${mapY}&radius=${radius != '' ? radius : '4000'}&pageNo=${pageNo}&arrange=${arrange}&sido=${param.sido}&gungu=${param.gungu}" class="back-link">목록으로</a>
            
        </div>
    </div>

    <!-- 에러 메시지 -->
    <c:if test="${not empty error}">
        <div class="error">
            <p>${error}</p>
        </div>
    </c:if>

    <!-- 콘텐츠 영역 -->
    <div class="content">
        <c:choose>
            <c:when test="${tab == 'common' && not empty commonItem}">
                <h2>${commonItem.title}</h2>
                <c:if test="${not empty commonItem.firstimage}">
                    <img src="${commonItem.firstimage}" alt="${commonItem.title}" class="main-image">
                </c:if>
                <!-- Right-side information -->
                <div class="info-right">
                    <p><strong>주소:</strong> ${commonItem.addr1} ${commonItem.addr2}</p>
                    <p><strong>우편번호:</strong> ${commonItem.zipcode}</p>
                    <p><strong>전화번호:</strong> ${commonItem.tel} (${commonItem.telname})</p>
                    <p><strong>홈페이지:</strong>
                        <c:choose>
                            <c:when test="${not empty commonItem.homepage}">
                                <c:set var="homepage" value="${fn:trim(commonItem.homepage)}"/>
                                <c:choose>
                                    <c:when test="${fn:contains(homepage, '<a ')}">
                                        <c:set var="hrefStart" value="${fn:indexOf(homepage, 'href=\"') + 6}"/>
                                        <c:if test="${hrefStart >= 6}">
                                            <c:set var="tempHref" value="${fn:substring(homepage, hrefStart, fn:length(homepage))}"/>
                                            <c:set var="hrefEnd" value="${fn:indexOf(tempHref, '\"')}"/>
                                            <c:set var="url" value="${fn:substring(tempHref, 0, hrefEnd)}"/>
                                        </c:if>
                                        <c:set var="textStart" value="${fn:indexOf(homepage, '>') + 1}"/>
                                        <c:if test="${textStart > 0}">
                                            <c:set var="tempText" value="${fn:substring(homepage, textStart, fn:length(homepage))}"/>
                                            <c:set var="textEnd" value="${fn:indexOf(tempText, '</a>')}"/>
                                            <c:set var="linkText" value="${fn:substring(tempText, 0, textEnd)}"/>
                                        </c:if>
                                        <c:choose>
                                            <c:when test="${not empty url and fn:startsWith(url, 'http')}">
                                                <a href="${url}" target="_blank">${not empty linkText ? linkText : '홈페이지'}</a>
                                            </c:when>
                                            <c:otherwise>
                                                없음
                                            </c:otherwise>
                                        </c:choose>
                                    </c:when>
                                    <c:otherwise>
                                        <c:choose>
                                            <c:when test="${fn:startsWith(homepage, 'http')}">
                                                <a href="${homepage}" target="_blank">${homepage}</a>
                                            </c:when>
                                            <c:otherwise>
                                                없음
                                            </c:otherwise>
                                        </c:choose>
                                    </c:otherwise>
                                </c:choose>
                            </c:when>
                            <c:otherwise>
                                없음
                            </c:otherwise>
                        </c:choose>
                    </p>
                    <p class="hidden"><strong>지역코드:</strong> ${commonItem.areacode}</p>
                    <p class="hidden"><strong>시군구코드:</strong> ${commonItem.sigungucode}</p>
                    <p class="hidden"><strong>분류:</strong> ${commonItem.cat1} > ${commonItem.cat2} > ${commonItem.cat3}</p>
                    <p class="hidden"><strong>좌표:</strong> X: ${commonItem.mapx}, Y: ${commonItem.mapy} (레벨: ${commonItem.mlevel})</p>
                </div>
                <div class="clear"></div>
                <!-- Below-image information -->
                <p>
                    <a href="#" class="map-button" onclick="toggleMap('${commonItem.mapx}', '${commonItem.mapy}', '${commonItem.title}'); return false;">[지도보기]</a>
                </p>
                <div id="map"></div>
                <p><strong>개요:</strong> ${commonItem.overview}</p>
                <p><strong>등록일:</strong> ${commonItem.createdtime}</p>
                <p><strong>수정일:</strong> ${commonItem.modifiedtime}</p>
                <p><strong>교과서여행지:</strong> ${commonItem.booktour == '1' ? '예' : '아니오'}</p>
                <!-- Graph at the bottom if data exists -->
                <c:if test="${not empty commonItem && dbConnected && not empty ageRatio}">
                    <h3>연령별 방문 비율</h3>
                    <canvas id="ageRatioChart"></canvas>
                    <script>
                        (function() {
                            Chart.defaults.font.size = 14;
                            Chart.defaults.font.family = "'Malgun Gothic', Arial, sans-serif";
                        
                            const ageRatioData = {
                                under10Male: parseFloat('${ageRatio.under10Male != null ? ageRatio.under10Male : 0}'),
                                under10Female: parseFloat('${ageRatio.under10Female != null ? ageRatio.under10Female : 0}'),
                                age20Male: parseFloat('${ageRatio.age20Male != null ? ageRatio.age20Male : 0}'),
                                age20Female: parseFloat('${ageRatio.age20Female != null ? ageRatio.age20Female : 0}'),
                                age30Male: parseFloat('${ageRatio.age30Male != null ? ageRatio.age30Male : 0}'),
                                age30Female: parseFloat('${ageRatio.age30Female != null ? ageRatio.age30Female : 0}'),
                                age40Male: parseFloat('${ageRatio.age40Male != null ? ageRatio.age40Male : 0}'),
                                age40Female: parseFloat('${ageRatio.age40Female != null ? ageRatio.age40Female : 0}'),
                                age50Male: parseFloat('${ageRatio.age50Male != null ? ageRatio.age50Male : 0}'),
                                age50Female: parseFloat('${ageRatio.age50Female != null ? ageRatio.age50Female : 0}'),
                                age60Male: parseFloat('${ageRatio.age60Male != null ? ageRatio.age60Male : 0}'),
                                age60Female: parseFloat('${ageRatio.age60Female != null ? ageRatio.age60Female : 0}'),
                                age70PlusMale: parseFloat('${ageRatio.age70PlusMale != null ? ageRatio.age70PlusMale : 0}'),
                                age70PlusFemale: parseFloat('${ageRatio.age70PlusFemale != null ? ageRatio.age70PlusFemale : 0}')
                            };

                            const isMobile = window.innerWidth <= 768;
                            const xAxisMax = isMobile ? 50 : 70;
                            const layoutPadding = isMobile 
                                ? { top: 10, bottom: 10, left: 2, right: 95 }
                                : { top: 10, bottom: 10, left: 10, right: 20 };
                        
                            const normalizeValue = (value) => Math.max(0, Math.min(xAxisMax, value));
                        
                            const maleData = [
                                normalizeValue(ageRatioData.under10Male),
                                normalizeValue(ageRatioData.age20Male),
                                normalizeValue(ageRatioData.age30Male),
                                normalizeValue(ageRatioData.age40Male),
                                normalizeValue(ageRatioData.age50Male),
                                normalizeValue(ageRatioData.age60Male),
                                normalizeValue(ageRatioData.age70PlusMale)
                            ];
                            const femaleData = [
                                normalizeValue(ageRatioData.under10Female),
                                normalizeValue(ageRatioData.age20Female),
                                normalizeValue(ageRatioData.age30Female),
                                normalizeValue(ageRatioData.age40Female),
                                normalizeValue(ageRatioData.age50Female),
                                normalizeValue(ageRatioData.age60Female),
                                normalizeValue(ageRatioData.age70PlusFemale)
                            ];
                        
                            const ctx = document.getElementById('ageRatioChart').getContext('2d');
                            const canvas = document.getElementById('ageRatioChart');
                            canvas.width = 450;
                            canvas.height = 300;
                        
                            new Chart(ctx, {
                                type: 'bar',
                                data: {
                                    labels: ['10대이하', '20대', '30대', '40대', '50대', '60대', '70대이상'],
                                    datasets: [
                                        {
                                            label: '남성 (%)',
                                            data: maleData,
                                            backgroundColor: 'rgba(54, 162, 235, 0.8)',
                                            borderWidth: 1
                                        },
                                        {
                                            label: '여성 (%)',
                                            data: femaleData,
                                            backgroundColor: 'rgba(255, 99, 132, 0.8)',
                                            borderWidth: 1
                                        }
                                    ]
                                },
                                options: {
                                    responsive: false,
                                    indexAxis: 'y',
                                    plugins: {
                                        legend: {
                                            position: 'top',
                                            labels: {
                                                font: {
                                                    size: 14
                                                }
                                            }
                                        },
                                        title: { display: false }
                                    },
                                    scales: {
                                        x: { 
                                            max: xAxisMax,
                                            title: {
                                                display: true,
                                                text: '%',
                                                font: {
                                                    size: 14
                                                }
                                            },
                                            ticks: {
                                                stepSize: 5,
                                                font: {
                                                    size: 12
                                                }
                                            }
                                        },
                                        y: { 
                                            title: {
                                                display: true,
                                                text: '연령대',
                                                font: {
                                                    size: 14
                                                }
                                            },
                                            ticks: {
                                                autoSkip: false,
                                                font: {
                                                    size: 12
                                                }
                                            }
                                        }
                                    },
                                    layout: {
                                        padding: layoutPadding
                                    }
                                }
                            });
                        })();
                    </script>
                </c:if>
            </c:when>
            <c:when test="${tab == 'intro' && not empty introItem}">
                <h2>소개정보</h2>
                <c:choose>
                    <c:when test="${contentTypeId == '12'}">
                        <p><strong>문의 및 안내:</strong> ${introItem.infocenter}</p>
                        <p><strong>개장일:</strong> ${introItem.opendate}</p>
                        <p><strong>쉬는 날:</strong> ${introItem.restdate}</p>
                        <p><strong>이용 시간:</strong> ${introItem.usetime}</p>
                        <p><strong>주차 시설:</strong> ${introItem.parking}</p>
                        <p><strong>수용 인원:</strong> ${introItem.accomcount}</p>
                        <p><strong>유모차 대여:</strong> ${introItem.chkbabycarriage}</p>
                        <p><strong>신용카드 가능:</strong> ${introItem.chkcreditcard}</p>
                        <p><strong>애완동물 동반:</strong> ${introItem.chkpet}</p>
                        <p><strong>체험 가능 연령:</strong> ${introItem.expagerange}</p>
                        <p><strong>체험 안내:</strong> ${introItem.expguide}</p>
                        <p><strong>세계문화유산:</strong> ${introItem.heritage1}</p>
                        <p><strong>세계자연유산:</strong> ${introItem.heritage2}</p>
                        <p><strong>세계기록유산:</strong> ${introItem.heritage3}</p>
                        <p><strong>이용 시기:</strong> ${introItem.useseason}</p>
                    </c:when>
                    <c:when test="${contentTypeId == '14'}">
                        <p><strong>문의 및 안내:</strong> ${introItem.infocenterculture}</p>
                        <p><strong>쉬는 날:</strong> ${introItem.restdateculture}</p>
                        <p><strong>이용 시간:</strong> ${introItem.usetimeculture}</p>
                        <p><strong>주차 시설:</strong> ${introItem.parkingculture}</p>
                        <p><strong>주차 요금:</strong> ${introItem.parkingfee}</p>
                        <p><strong>수용 인원:</strong> ${introItem.accomcountculture}</p>
                        <p><strong>유모차 대여:</strong> ${introItem.chkbabycarriageculture}</p>
                        <p><strong>신용카드 가능:</strong> ${introItem.chkcreditcardculture}</p>
                        <p><strong>애완동물 동반:</strong> ${introItem.chkpetculture}</p>
                        <p><strong>할인 정보:</strong> ${introItem.discountinfo}</p>
                        <p><strong>이용 요금:</strong> ${introItem.usefee}</p>
                        <p><strong>규모:</strong> ${introItem.scale}</p>
                        <p><strong>관람 소요 시간:</strong> ${introItem.spendtime}</p>
                    </c:when>
                    <c:when test="${contentTypeId == '15'}">
                        <p><strong>행사 시작일:</strong> ${introItem.eventstartdate}</p>
                        <p><strong>행사 종료일:</strong> ${introItem.eventenddate}</p>
                        <p><strong>행사 장소:</strong> ${introItem.eventplace}</p>
                        <p><strong>행사 홈페이지:</strong> ${introItem.eventhomepage}</p>
                        <p><strong>주최자 정보:</strong> ${introItem.sponsor1}</p>
                        <p><strong>주최자 연락처:</strong> ${introItem.sponsor1tel}</p>
                        <p><strong>주관사 정보:</strong> ${introItem.sponsor2}</p>
                        <p><strong>주관사 연락처:</strong> ${introItem.sponsor2tel}</p>
                        <p><strong>관람 가능 연령:</strong> ${introItem.agelimit}</p>
                        <p><strong>예매처:</strong> ${introItem.bookingplace}</p>
                        <p><strong>할인 정보:</strong> ${introItem.discountinfofestival}</p>
                        <p><strong>축제 등급:</strong> ${introItem.festivalgrade}</p>
                        <p><strong>행사 장소 안내:</strong> ${introItem.placeinfo}</p>
                        <p><strong>공연 시간:</strong> ${introItem.playtime}</p>
                        <p><strong>행사 프로그램:</strong> ${introItem.program}</p>
                        <p><strong>관람 소요 시간:</strong> ${introItem.spendtimefestival}</p>
                        <p><strong>이용 요금:</strong> ${introItem.usetimefestival}</p>
                        <p><strong>부대 행사:</strong> ${introItem.subevent}</p>
                    </c:when>
                    <c:when test="${contentTypeId == '25'}">
                        <p><strong>문의 및 안내:</strong> ${introItem.infocentertourcourse}</p>
                        <p><strong>코스 총 거리:</strong> ${introItem.distance}</p>
                        <p><strong>코스 일정:</strong> ${introItem.schedule}</p>
                        <p><strong>코스 총 소요 시간:</strong> ${introItem.taketime}</p>
                        <p><strong>코스 테마:</strong> ${introItem.theme}</p>
                    </c:when>
                    <c:when test="${contentTypeId == '28'}">
                        <p><strong>문의 및 안내:</strong> ${introItem.infocenterleports}</p>
                        <p><strong>개장 기간:</strong> ${introItem.openperiod}</p>
                        <p><strong>쉬는 날:</strong> ${introItem.restdateleports}</p>
                        <p><strong>이용 시간:</strong> ${introItem.usetimeleports}</p>
                        <p><strong>주차 시설:</strong> ${introItem.parkingleports}</p>
                        <p><strong>주차 요금:</strong> ${introItem.parkingfeeleports}</p>
                        <p><strong>수용 인원:</strong> ${introItem.accomcountleports}</p>
                        <p><strong>유모차 대여:</strong> ${introItem.chkbabycarriageleports}</p>
                        <p><strong>신용카드 가능:</strong> ${introItem.chkcreditcardleports}</p>
                        <p><strong>애완동물 동반:</strong> ${introItem.chkpetleports}</p>
                        <p><strong>체험 가능 연령:</strong> ${introItem.expagerangeleports}</p>
                        <p><strong>예약 안내:</strong> ${introItem.reservation}</p>
                        <p><strong>규모:</strong> ${introItem.scaleleports}</p>
                        <p><strong>입장료:</strong> ${introItem.usefeeleports}</p>
                    </c:when>
                    <c:when test="${contentTypeId == '32'}">
                        <p><strong>문의 및 안내:</strong> ${introItem.infocenterlodging}</p>
                        <p><strong>입실 시간:</strong> ${introItem.checkintime}</p>
                        <p><strong>퇴실 시간:</strong> ${introItem.checkouttime}</p>
                        <p><strong>주차 시설:</strong> ${introItem.parkinglodging}</p>
                        <p><strong>수용 가능 인원:</strong> ${introItem.accomcountlodging}</p>
                        <p><strong>객실 수:</strong> ${introItem.roomcount}</p>
                        <p><strong>객실 유형:</strong> ${introItem.roomtype}</p>
                        <p><strong>규모:</strong> ${introItem.scalelodging}</p>
                        <p><strong>예약 안내:</strong> ${introItem.reservationlodging}</p>
                        <p><strong>예약 안내 홈페이지:</strong> ${introItem.reservationurl}</p>
                        <p><strong>객실 내 취사 여부:</strong> ${introItem.chkcooking}</p>
                        <p><strong>픽업 서비스:</strong> ${introItem.pickup}</p>
                        <p><strong>식음료장:</strong> ${introItem.foodplace}</p>
                        <p><strong>바비큐장 여부:</strong> ${introItem.barbecue}</p>
                        <p><strong>뷰티 시설:</strong> ${introItem.beauty}</p>
                        <p><strong>음료 시설:</strong> ${introItem.beverage}</p>
                        <p><strong>자전거 대여:</strong> ${introItem.bicycle}</p>
                        <p><strong>캠프파이어:</strong> ${introItem.campfire}</p>
                        <p><strong>휘트니스 센터:</strong> ${introItem.fitness}</p>
                        <p><strong>노래방:</strong> ${introItem.karaoke}</p>
                        <p><strong>공용 샤워실:</strong> ${introItem.publicbath}</p>
                        <p><strong>공용 PC실:</strong> ${introItem.publicpc}</p>
                        <p><strong>사우나실:</strong> ${introItem.sauna}</p>
                        <p><strong>세미나실:</strong> ${introItem.seminar}</p>
                        <p><strong>스포츠 시설:</strong> ${introItem.sports}</p>
                        <p><strong>환불 규정:</strong> ${introItem.refundregulation}</p>
                        <p><strong>베니키아 여부:</strong> ${introItem.benikia}</p>
                        <p><strong>굿스테이 여부:</strong> ${introItem.goodstay}</p>
                        <p><strong>한옥 여부:</strong> ${introItem.hanok}</p>
                        <p><strong>부대 시설 (기타):</strong> ${introItem.subfacility}</p>
                    </c:when>
                    <c:when test="${contentTypeId == '38'}">
                        <p><strong>문의 및 안내:</strong> ${introItem.infocentershopping}</p>
                        <p><strong>개장일:</strong> ${introItem.opendateshopping}</p>
                        <p><strong>영업 시간:</strong> ${introItem.opentime}</p>
                        <p><strong>쉬는 날:</strong> ${introItem.restdateshopping}</p>
                        <p><strong>주차 시설:</strong> ${introItem.parkingshopping}</p>
                        <p><strong>유모차 대여:</strong> ${introItem.chkbabycarriageshopping}</p>
                        <p><strong>신용카드 가능:</strong> ${introItem.chkcreditcardshopping}</p>
                        <p><strong>애완동물 동반:</strong> ${introItem.chkpetshopping}</p>
                        <p><strong>규모:</strong> ${introItem.scaleshopping}</p>
                        <p><strong>판매 품목:</strong> ${introItem.saleitem}</p>
                        <p><strong>판매 품목별 가격:</strong> ${introItem.saleitemcost}</p>
                        <p><strong>매장 안내:</strong> ${introItem.shopguide}</p>
                        <p><strong>문화센터 바로가기:</strong> ${introItem.culturecenter}</p>
                        <p><strong>장서는 날:</strong> ${introItem.fairday}</p>
                        <p><strong>화장실 설명:</strong> ${introItem.restroom}</p>
                    </c:when>
                    <c:when test="${contentTypeId == '39'}">
                        <p><strong>문의 및 안내:</strong> ${introItem.infocenterfood}</p>
                        <p><strong>개업일:</strong> ${introItem.opendatefood}</p>
                        <p><strong>영업 시간:</strong> ${introItem.opentimefood}</p>
                        <p><strong>쉬는 날:</strong> ${introItem.restdatefood}</p>
                        <p><strong>주차 시설:</strong> ${introItem.parkingfood}</p>
                        <p><strong>신용카드 가능:</strong> ${introItem.chkcreditcardfood}</p>
                        <p><strong>할인 정보:</strong> ${introItem.discountinfofood}</p>
                        <p><strong>대표 메뉴:</strong> ${introItem.firstmenu}</p>
                        <p><strong>취급 메뉴:</strong> ${introItem.treatmenu}</p>
                        <p><strong>예약 안내:</strong> ${introItem.reservationfood}</p>
                        <p><strong>규모:</strong> ${introItem.scalefood}</p>
                        <p><strong>좌석 수:</strong> ${introItem.seat}</p>
                        <p><strong>포장 가능:</strong> ${introItem.packing}</p>
                        <p><strong>금연/흡연 여부:</strong> ${introItem.smoking}</p>
                        <p><strong>어린이 놀이방 여부:</strong> ${introItem.kidsfacility}</p>
                        <p><strong>인허가 번호:</strong> ${introItem.lcnsno}</p>
                    </c:when>
                    <c:otherwise>
                        <p>지원되지 않는 contentTypeId입니다.</p>
                    </c:otherwise>
                </c:choose>
            </c:when>
            <c:when test="${tab == 'info' && not empty infoItems}">
                <h2>반복정보</h2>
                <ul>
                    <c:forEach var="info" items="${infoItems}">
                        <li>
                            <c:choose>
                                <c:when test="${contentTypeId == '25'}">
                                    <strong>${info.subname} (코스 ${info.subnum}):</strong>
                                    <p>하위 콘텐츠 ID: ${info.subcontentid}</p>
                                    <c:if test="${not empty info.subdetailimg}">
                                        <p>이미지: <img src="${info.subdetailimg}" alt="${info.subdetailalt}"></p>
                                    </c:if>
                                    <c:if test="${not empty info.subdetailoverview}">
                                        <p>개요: ${info.subdetailoverview}</p>
                                    </c:if>
                                </c:when>
                                <c:when test="${contentTypeId == '32'}">
                                    <strong>${info.roomtitle} (객실 코드: ${info.roomcode}):</strong>
                                    <c:if test="${info.roomsize1 != null || info.roomsize2 != null}">
                                        <p>객실 크기: 
                                            <c:if test="${info.roomsize1 != null}">${info.roomsize1} 평</c:if>
                                            <c:if test="${info.roomsize2 != null}"> (${info.roomsize2} 평방미터)</c:if>
                                        </p>
                                    </c:if>
                                    <c:if test="${info.roomcount != null}">
                                        <p>객실 수: ${info.roomcount}</p>
                                    </c:if>
                                    <c:if test="${info.roombasecount != null || info.roommaxcount != null}">
                                        <p>인원: 
                                            <c:if test="${info.roombasecount != null}">기준 ${info.roombasecount}</c:if>
                                            <c:if test="${info.roommaxcount != null}"> / 최대 ${info.roommaxcount}</c:if>
                                        </p>
                                    </c:if>
                                    <c:if test="${info.roomoffseasonminfee1 != null || info.roomoffseasonminfee2 != null || info.roompeakseasonminfee1 != null || info.roompeakseasonminfee2 != null}">
                                        <p>요금:
                                            <c:if test="${info.roomoffseasonminfee1 != null}"> 비수기 주중: ${info.roomoffseasonminfee1}원</c:if>
                                            <c:if test="${info.roomoffseasonminfee2 != null}">, 주말: ${info.roomoffseasonminfee2}원</c:if>
                                            <c:if test="${info.roompeakseasonminfee1 != null}"> / 성수기 주중: ${info.roompeakseasonminfee1}원</c:if>
                                            <c:if test="${info.roompeakseasonminfee2 != null}">, 주말: ${info.roompeakseasonminfee2}원</c:if>
                                        </p>
                                    </c:if>
                                    <c:if test="${not empty info.roomintro}">
                                        <p>소개: ${info.roomintro}</p>
                                    </c:if>
                                    <p>시설:
                                        <c:set var="facilities" value="" />
                                        <c:if test="${info.roombathfacility == 'Y'}"><c:set var="facilities" value="${facilities}목욕시설, " /></c:if>
                                        <c:if test="${info.roombath == 'Y'}"><c:set var="facilities" value="${facilities}욕조, " /></c:if>
                                        <c:if test="${info.roomhometheater == 'Y'}"><c:set var="facilities" value="${facilities}홈시어터, " /></c:if>
                                        <c:if test="${info.roomaircondition == 'Y'}"><c:set var="facilities" value="${facilities}에어컨, " /></c:if>
                                        <c:if test="${info.roomtv == 'Y'}"><c:set var="facilities" value="${facilities}TV, " /></c:if>
                                        <c:if test="${info.roompc == 'Y'}"><c:set var="facilities" value="${facilities}PC, " /></c:if>
                                        <c:if test="${info.roomcable == 'Y'}"><c:set var="facilities" value="${facilities}케이블, " /></c:if>
                                        <c:if test="${info.roominternet == 'Y'}"><c:set var="facilities" value="${facilities}인터넷, " /></c:if>
                                        <c:if test="${info.roomrefrigerator == 'Y'}"><c:set var="facilities" value="${facilities}냉장고, " /></c:if>
                                        <c:if test="${info.roomtoiletries == 'Y'}"><c:set var="facilities" value="${facilities}세면도구, " /></c:if>
                                        <c:if test="${info.roomsofa == 'Y'}"><c:set var="facilities" value="${facilities}소파, " /></c:if>
                                        <c:if test="${info.roomcook == 'Y'}"><c:set var="facilities" value="${facilities}취사용품, " /></c:if>
                                        <c:if test="${info.roomtable == 'Y'}"><c:set var="facilities" value="${facilities}테이블, " /></c:if>
                                        <c:if test="${info.roomhairdryer == 'Y'}"><c:set var="facilities" value="${facilities}드라이기, " /></c:if>
                                        <c:choose>
                                            <c:when test="${not empty facilities}">
                                                ${fn:substring(facilities, 0, fn:length(facilities) - 2)}
                                            </c:when>
                                            <c:otherwise>없음</c:otherwise>
                                        </c:choose>
                                    </p>
                                    <c:if test="${not empty info.roomimg1}">
                                        <p>객실 사진 1: <img src="${info.roomimg1}" alt="${info.roomimg1alt}">
                                            <c:if test="${not empty info.cpyrhtDivCd1}">(저작권: ${info.cpyrhtDivCd1})</c:if>
                                        </p>
                                    </c:if>
                                    <c:if test="${not empty info.roomimg2}">
                                        <p>객실 사진 2: <img src="${info.roomimg2}" alt="${info.roomimg2alt}">
                                            <c:if test="${not empty info.cpyrhtDivCd2}">(저작권: ${info.cpyrhtDivCd2})</c:if>
                                        </p>
                                    </c:if>
                                    <c:if test="${not empty info.roomimg3}">
                                        <p>객실 사진 3: <img src="${info.roomimg3}" alt="${info.roomimg3alt}">
                                            <c:if test="${not empty info.cpyrhtDivCd3}">(저작권: ${info.cpyrhtDivCd3})</c:if>
                                        </p>
                                    </c:if>
                                    <c:if test="${not empty info.roomimg4}">
                                        <p>객실 사진 4: <img src="${info.roomimg4}" alt="${info.roomimg4alt}">
                                            <c:if test="${not empty info.cpyrhtDivCd4}">(저작권: ${info.cpyrhtDivCd4})</c:if>
                                        </p>
                                    </c:if>
                                    <c:if test="${not empty info.roomimg5}">
                                        <p>객실 사진 5: <img src="${info.roomimg5}" alt="${info.roomimg5alt}">
                                            <c:if test="${not empty info.cpyrhtDivCd5}">(저작권: ${info.cpyrhtDivCd5})</c:if>
                                        </p>
                                    </c:if>
                                </c:when>
                                <c:otherwise>
                                    <strong>${info.infoname}:</strong> ${info.infotext}
                                </c:otherwise>
                            </c:choose>
                        </li>
                    </c:forEach>
                </ul>
            </c:when>
            <c:when test="${tab == 'image' && not empty imageItems}">
                <h2>추가 이미지</h2>
                <div class="image-gallery">
                    <c:forEach var="image" items="${imageItems}">
                        <img src="${image.originimgurl}" alt="${image.imgname}" onclick="showEnlargedImage('${image.originimgurl}', '${image.imgname}')">
                    </c:forEach>
                </div>
                <div class="enlarged-image-container">
                    <img id="enlargedImage" class="enlarged-image" src="" alt="">
                </div>
            </c:when>
            <c:otherwise>
                <p>데이터가 없습니다.</p>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- 하단 [목록으로] 버튼 -->
    <a href="${pageContext.request.contextPath}/${param.isFestival == 'true' ? 'festival' : 'search'}?contentTypeId=${searchContentTypeId}&mapX=${mapX}&mapY=${mapY}&radius=${radius != '' ? radius : '4000'}&pageNo=${pageNo}&arrange=${arrange}&sido=${param.sido}&gungu=${param.gungu}" class="back-link">목록으로 돌아가기</a>
    <!-- JavaScript for enlarged image functionality -->
    <script>
        function showEnlargedImage(src, alt) {
            const enlargedImage = document.getElementById('enlargedImage');
            enlargedImage.src = src;
            enlargedImage.alt = alt;
            enlargedImage.style.display = 'block';
        }
    </script>
    
    <!-- Naver Maps API 스크립트 -->
    <script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpKeyId=${naverClientId}"></script>
    <script>
        let mapInstance = null;

        function toggleMap(mapx, mapy, title) {
            const mapDiv = document.getElementById('map');
            if (mapDiv.style.display === 'block') {
                mapDiv.style.display = 'none';
                return;
            }

            if (!mapx || !mapy) {
                alert('지도 좌표가 유효하지 않습니다.');
                return;
            }

            const longitude = parseFloat(mapx);
            const latitude = parseFloat(mapy);

            if (isNaN(longitude) || isNaN(latitude)) {
                alert('지도 좌표 형식이 올바르지 않습니다.');
                return;
            }

            mapDiv.style.display = 'block';

            if (!mapInstance) {
                mapInstance = new naver.maps.Map('map', {
                    center: new naver.maps.LatLng(latitude, longitude),
                    zoom: 15
                });

                const marker = new naver.maps.Marker({
                    position: new naver.maps.LatLng(latitude, longitude),
                    map: mapInstance,
                    title: title
                });

                const infoWindow = new naver.maps.InfoWindow({
                    content: '<div style="padding:10px;"><h4>' + title + '</h4></div>'
                });

                naver.maps.Event.addListener(marker, 'click', function() {
                    infoWindow.open(mapInstance, marker);
                });
            } else {
                mapInstance.setCenter(new naver.maps.LatLng(latitude, longitude));
            }
        }
    </script>

    <script>
        console.log("Naver Client ID in JSP: ${naverClientId}");
        console.log("Homepage data: ${commonItem.homepage}");
    </script>
</body>
</html>
