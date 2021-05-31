<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<!DOCTYPE HTML>
<html>
<head>
    <meta charset="UTF-8">
    <title>새늘봄 / 매출분석 - 정기구독</title>
    <%@ include file="../main/b_import.jspf"%>
    <script src="/static/chartjs/dist/chart.js"></script>
    <script src="/static/chartjs/dist/chartjs-plugin-datalabels.js"></script>
</head>
<body>
<%@ include file="../main/b_header.jspf"%>
<div id="container" class="mx-auto d-flex flex-column p-3 bg-white">
    <!-- 버튼 영역 -->
    <div class="d-flex">
        <!-- 최근6개월 / 이번달 -->
        <div class="col-4 d-flex row-cols-2 btn-group" role="group">
            <label class="row-cols-1 pe-1">
                <input type="radio" class="btn-check" name="period" checked onchange="search(searchSales)">
                <span class="col btn btn-outline-secondary">최근 6개월</span>
            </label>
            <label class="row-cols-1 ps-1">
                <input type="radio" class="btn-check" name="period" onchange="search(searchThisMonth)">
                <span class="col btn btn-outline-secondary">이번 달</span>
            </label>
        </div>

    </div>

    <!-- 매출 현황 그래프 -->
    <div style="height: 500px" class="d-flex">
        <canvas id="salesChart"></canvas>
    </div>

    <!-- 기간별 매출 상세 현황 -->
    <div class="pt-3 d-flex flex-column">
        <!-- 헤더 -->
        <div class="d-flex text-center bg-secondary text-white">
            <span class="col-1 p-3 border-end">기간</span>
            <span class="col-1 p-3 border-end">판매수</span>
            <span class="col-2 p-3 border-end">정기구독</span>
            <span class="col-2 p-3 border-end">꽃다발</span>
            <span class="col-2 p-3 border-end">클래스</span>
            <span class="col-2 p-3 border-end">소품샵</span>
            <span class="col-2 p-3">총계</span>
        </div>
    </div>
    <ul id="salesTable" class="list-unstyled p-0 m-0 d-flex flex-column text-center">
    </ul>
</div>
<%@ include file="../main/b_footer.jspf"%>
<script>
    /**
     * @param {String} html representing a single element
     * @return {ChildNode}
     */
    function htmlToElement(html) {
        const template = document.createElement("template");
        template.innerHTML = html.trim();
        return template.content.firstChild;
    }

    document.querySelectorAll("[name=period]").forEach($period => {
        $period.addEventListener("change", function () {

        })
    })

    const data = {
        labels: "",
        datasets: [
            {
                label: '판매량',
                backgroundColor: '#c237ff',
                borderColor: '#c237ff',
                yAxisID: 'right-y-axis'
            },
            {
                label: '정기구독 판매금액',
                backgroundColor: '#4983e5',
                borderColor: '#4983e5',
                yAxisID: 'left-y-axis'
            },
            {
                label: '꽃다발 판매금액',
                backgroundColor: '#4ef1d1',
                borderColor: '#4ef1d1',
                yAxisID: 'left-y-axis'
            },
            {
                label: '소품샵 판매금액',
                backgroundColor: '#84ea43',
                borderColor: '#84ea43',
                yAxisID: 'left-y-axis'
            },
            {
                label: '클래스 판매금액',
                backgroundColor: '#ffc531',
                borderColor: '#ffc531',
                yAxisID: 'left-y-axis'
            },
            {
                label: '총계',
                backgroundColor: '#FF6631',
                borderColor: '#FF6631',
                yAxisID: 'left-y-axis'
            },
        ]
    }

    const config = {
        type: 'line',
        data: data,
        plugins: [],
        options: {
            maintainAspectRatio: false,
            scales: {
                'left-y-axis': {
                    display: true,
                    type: 'linear',
                    position: 'left',
                    title: {
                        display: true,
                        text: '판매금액'
                    }
                },
                'right-y-axis': {
                    display: true,
                    type: 'linear',
                    position: 'right',
                    title: {
                        display: true,
                        text: '판매량'
                    }
                }
            },
            plugins: {
                title: {
                    display: true,
                    text: '매출 통계'
                }
            }
        }
    }
    let myChart = new Chart(document.querySelector("#salesChart"), config);

    function search(fn) {
        fn().then(function (result) {
            console.log(result);
            makeTable(result);
        })
    }

    function makeTable(result) {
        const $salesTable = document.querySelector("#salesTable");
        $salesTable.innerHTML = "";
        for (let row of result) {

            let li = "" +
                "<li class='border border-top-0 border-secondary d-flex'>" +
                "    <span class='col-1 p-3 border-end border-secondary d-flex justify-content-center align-items-center'>" + row.period + "</span>" +
                "    <span class='col-1 p-3 border-end border-secondary d-flex justify-content-center align-items-center'>" + row.salesCount + "</span>" +
                "    <span class='col-2 p-3 border-end border-secondary d-flex justify-content-center align-items-center'>" + row.subsAmount.toLocaleString('ko-KR') + "</span>" +
                "    <span class='col-2 p-3 border-end border-secondary d-flex justify-content-center align-items-center'>" + row.flowerAmount.toLocaleString('ko-KR') + "</span>" +
                "    <span class='col-2 p-3 border-end border-secondary d-flex justify-content-center align-items-center'>" + row.classAmount.toLocaleString('ko-KR') + "</span>" +
                "    <span class='col-2 p-3 border-end border-secondary d-flex justify-content-center align-items-center'>" + row.productAmount.toLocaleString('ko-KR') + "</span>" +
                "    <span class='col-2 p-3 d-flex justify-content-center align-items-center'>" + row.totalAmount.toLocaleString('ko-KR') + "</span>" +
                "</li>";

            $salesTable.appendChild(htmlToElement(li));
        }
    }

    search(searchSales);

    function updateChart(result) {
        const periods = result.map(({period}) => period);
        const salesCounts = result.map(({salesCount}) => salesCount);
        const subsAmounts = result.map(({subsAmount}) => subsAmount);
        const flowerAmounts = result.map(({flowerAmount}) => flowerAmount);
        const productAmounts = result.map(({productAmount}) => productAmount);
        const classAmounts = result.map(({classAmount}) => classAmount);
        const totalAmounts = result.map(({totalAmount}) => totalAmount);

        data.labels = periods;
        data.datasets[0].data = salesCounts;
        data.datasets[1].data = subsAmounts;
        data.datasets[2].data = flowerAmounts;
        data.datasets[3].data = productAmounts;
        data.datasets[4].data = classAmounts;
        data.datasets[5].data = totalAmounts;

        myChart.update();
    }

    function searchSales() {
        return fetch("/statistics/api/sales").then(response => {
            return response.json().then(result => {
                updateChart(result);
                return result;
            });
        });
    }

    function searchThisMonth() {
        return fetch("/statistics/api/sales?type=thisMonth").then(response => {
            return response.json().then(result => {
                updateChart(result);
                return result;
            });
        });
    }

</script>
</body>
</html>
