<%--
  Created by IntelliJ IDEA.
  User: parksohee
  Date: 2023/02/07
  Time: 12:22 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">

    <title>Title</title>
</head>
<body>
<jsp:include page="../../web_jsp/market/inc/menu.jsp" />
<div class="jumbotron">
    <div class="container">
        <h1 class="display-3">배송 정보</h1>
    </div>
</div>

<div class="container">
    <table class="table table-hover">
        <tr>
            <th>상품</th>
            <th>가격</th>
            <th>수량</th>
            <th>소계</th>
        </tr>

        <c:forEach var="data" items="${datas }">
            <tr>
                <td>${data.productId} - ${data.productName}</td>
                <td>${data.unitPrice}</td>
                <td>${data.cnt}</td>
                <td>${data.sumPrice}</td>
            </tr>
        </c:forEach>

        <tr>
            <th></th>
            <th></th>
            <th>총액</th>
            <th>${totalPrice}</th>
            <th></th>
        </tr>
    </table>

    <div class="form-group row">
        <label class="col-sm-2">결제 단계</label>
        <div class="col-sm-3">
            ${info.orderStep}
        </div>
    </div>
    <div class="form-group row">
        <label class="col-sm-2">결제 방법</label>
        <div class="col-sm-3">
            ${info.payMethod}
        </div>

    </div>
    <div class="form-group row">
        <label class="col-sm-2">결제 금액</label>
        <div class="col-sm-3">
            ${info.payAmount}
        </div>
    </div>
    <div class="form-group row">
        <label class="col-sm-2">주문자 이름</label>
        <div class="col-sm-3">
            ${info.orderName}
        </div>
    </div>
    <div class="form-group row">
        <label class="col-sm-2">주문자 연락처</label>
        <div class="col-sm-3">
            ${info.orderTel}
        </div>
    </div>
    <div class="form-group row">
        <label class="col-sm-2">주문자 이메일</label>
        <div class="col-sm-3">
            ${info.orderEmail}
        </div>
    </div>
    <div class="form-group row">
        <label class="col-sm-2">받는 사람 이름</label>
        <div class="col-sm-3">
            ${info.receiveName}
        </div>
    </div>

    <div class="form-group row">
        <label class="col-sm-2">받는 사람 연락처</label>
        <div class="col-sm-3">
            ${info.receiveTel}
        </div>
    </div>

    <div class="form-group row">
        <label class="col-sm-2">받는 사람 주소</label>
        <div class="col-sm-3">
            ${info.receiveAddress}
        </div>
    </div>
</div>
<jsp:include page="../../web_jsp/market/inc/footer.jsp" />
</body>
</html>
