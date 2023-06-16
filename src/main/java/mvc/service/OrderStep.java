package mvc.service;

public enum OrderStep {
    orderReceive("주문접수"),
    payReceive("입금확인"),
    shippingPrepare("배송준비중"),
    shippingDelay("배송대기"),
    shippingComplete("배송완료"),
    orderCancel("주문취소"),
    exchangeRequest("교환요청"),
    exchangeComplete("교환완료"),
    refundRequest("환불요청"),
    refundComplete("환불완료"),
    orderFail("주문실패");

    private final String step;
    OrderStep(String step){
        this.step = step;
    }
    public String getStep() {
        return step;
    }
}
