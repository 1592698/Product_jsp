<%--
  Created by IntelliJ IDEA.
  User: parksohee
  Date: 2023/02/06
  Time: 11:52 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">

    <title>결제정보</title>
</head>
<body>
<jsp:include page="../../web_jsp/market/inc/menu.jsp" />
<div class="jumbotron">
    <div class="container">
        <h1 class="display-3">결제 정보</h1>
    </div>
</div>
<div class="container">
    <section>
        <h1>구매하기</h1>
        <h3>구매 상품 : ${orderProductName}</h3>
        <sapn>${totalPrice}원</sapn>
        ${info.orderName}
        <p>---------------------------</p>
        <div><label><input type="radio" name="method" value="카드" checked/>신용카드 </label></div>
        <div><label><input type="radio" name="method" value="가상계좌"/>가상계좌 </label></div>
        <p>---------------------------</p>
        <button id="payment-button">결제하기</button>
    </section>


<script src="https://js.tosspayments.com/v1"></script>
<script>
    var tossPayments = TossPayments("test_ck_D5GePWvyJnrK0W0k6q8gLzN97Eoq"); //클라이언트 키
    var button = document.getElementById("payment-button");

    // var orderId = new Date().getTime();
    //
    button.addEventListener("click", function () {
        var method = document.querySelector('input[name=method]:checked').value; // "카드" 혹은 "가상계좌"

        var paymentData = {
            amount: ${totalPrice},
            orderId: '${info.orderNo}',
            orderName: '${orderProductName}',
            customerName: '${info.orderName}',
            successUrl: window.location.origin + "/web_jsp/market/order/success.do", // 성공시 리턴될  주소
            failUrl: window.location.origin + "/web_jsp/market/order/order/fail.do",  // 실패시 리턴될 주소
        };

        if (method === '가상계좌') {
            paymentData.virtualAccountCallbackUrl = window.location.origin + '/order/virtualAccountCallback.do'
        }

        tossPayments.requestPayment(method, paymentData);
    });
</script>
</div>
<jsp:include page="../../web_jsp/market/inc/footer.jsp" />
</body>
</html>
