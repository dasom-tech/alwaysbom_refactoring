<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<!DOCTYPE HTML>
<html>
<head>
    <meta charset="UTF-8">
    <title>새늘봄 / 매출분석 - 정기구독</title>
    <%@ include file="../main/b_import.jspf"%>
    <script src="/static/chartjs/dist/chart.js"></script>
    <script src="/static/chartjs/dist/chartjs-plugin-datalabels.js"></script>
<%--    <script src="https://cdn.jsdelivr.net/npm/chart.js@2.9.4/dist/Chart.min.js"></script>--%>
<%--    <script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@0.7.0"></script>--%>

</head>
<body>
<%@ include file="../main/b_header.jspf"%>
<div id="container" class="mx-auto d-flex p-3 bg-white">
    <div class="col-8 p-4">
        <canvas id="subsByMonth"></canvas>
    </div>
    <div class="col-4 p-4">
        <canvas id="subsBySize"></canvas>
    </div>
</div>
<%@ include file="../main/b_footer.jspf"%>
<script>
    fetch("/statistics/api/subsByMonth").then(response => {
        response.json().then(result => {
            const labels = result.map(v => v.label);
            const values = result.map(v => v.value);
            const data = {
                labels: labels,
                datasets: [{
                    label: '월별 구독 수 추이',
                    backgroundColor: '#ff6384',
                    border: 'none',
                    data: values
                }]
            }

            const config = {
                type: 'bar',
                data: data,
                plugins: [ChartDataLabels],
                options: {
                    plugins: {
                        title: {
                            display: true,
                            text: '월별 구독 수 추이'
                        },
                        datalabels: {
                            font: {
                                size: 20
                            },
                            color: '#FFFFFF'
                        }
                    }
                }
            }

            const ctxMonth = document.querySelector("#subsByMonth");
            const subsByMonth = new Chart(ctxMonth, config);

        })
    });

    fetch("/statistics/api/subsBySize").then(response => {
        response.json().then(result => {
            const labels = result.map(v => v.label);
            const values = result.map(v => v.value);
            const data = {
                labels: labels,
                datasets: [
                    {
                        backgroundColor: ['rgb(127,145,232)', 'rgb(97,198,73)', 'rgb(226,224,94)', 'rgb(35,69,226)'],
                        border: 'none',
                        data: values
                    }
                ]
            }
            const sizeConfig = {
                type: 'doughnut',
                data: data,
                plugins: [ChartDataLabels],
                options: {
                    plugins: {
                        title: {
                            display: true,
                            text: '사이즈별 구독 수량'
                        },
                        datalabels: {
                            font: {
                                size: 20
                            },
                            color: function (ctx) {
                                if (ctx.dataIndex !== 2) {
                                    return '#FFFFFF';
                                } else {
                                    return '#333333';
                                }
                            },
                            formatter: function (value, ctx) {
                                return ctx.chart.data.labels[ctx.dataIndex];
                            }
                        }
                    }
                }
            }
            const ctxSize = document.querySelector("#subsBySize");
            const subsMySize = new Chart(ctxSize, sizeConfig);
        });
    });
</script>
</body>
</html>
