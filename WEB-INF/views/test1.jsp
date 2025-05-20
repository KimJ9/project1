<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>테스트 그래프</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.4/dist/chart.umd.min.js"></script>
    <style>
        body { 
            font-family: 'Malgun Gothic', Arial, sans-serif; 
            margin: 20px; 
            background-color: #f5f5f5; 
        }
        h1 { 
            font-size: 24px; 
            margin-bottom: 20px; 
        }
        #ageRatioChart { 
            max-width: 900px; 
            height: 400px !important; /* 세로 높이 증가 */
            margin: 20px auto; 
        }
    </style>
</head>
<body>
    <h1>테스트 그래프: 연령별 방문 비율</h1>
    <canvas id="ageRatioChart"></canvas>
    <script>
        (function() {
            Chart.defaults.font.size = 14;
            Chart.defaults.font.family = "'Malgun Gothic', Arial, sans-serif";

            // 원본 데이터 유지
            const ageRatioData = {
                under10Male: 1.9,
                under10Female: 2.3,
                age20Male: 8.5,
                age20Female: 8.2,
                age30Male: 9.5,
                age30Female: 5.9,
                age40Male: 7.3,
                age40Female: 5.8,
                age50Male: 11.6,
                age50Female: 11.3,
                age60Male: 10.7,
                age60Female: 10.1,
                age70PlusMale: 3.3,
                age70PlusFemale: 3.8
            };

            // 데이터 추출 및 정규화 (원본 로직 유지)
            const normalizeValue = (value) => Math.max(0, Math.min(100, value));
            const maleData = Object.values(ageRatioData)
                .filter((_,i) => i%2 === 0)
                .map(normalizeValue);
            const femaleData = Object.values(ageRatioData)
                .filter((_,i) => i%2 === 1)
                .map(normalizeValue);

            // 차트 생성
            const ctx = document.getElementById('ageRatioChart').getContext('2d');
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
                    indexAxis: 'y',
                    plugins: {
                        legend: { position: 'top' }, // 기본 범례 사용
                        title: { display: false } // 커스텀 타이틀 제거
                    },
                    scales: {
                        x: { 
                            max: 100,
                            title: { display: true, text: '%' },
                            ticks: { stepSize: 10 }
                        },
                        y: { 
                            title: { display: true, text: '연령대' },
                            ticks: { autoSkip: false }
                        }
                    },
                    layout: {
                        padding: { top: 30, bottom: 30, left: 40, right: 40 }
                    }
                }
            });
        })();
    </script>
</body>
</html>
