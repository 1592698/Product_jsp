package market.ver01.dto;

public class CartDTO {

    private int p_cartId;
    private String p_memberId;
    private String p_orderNo;
    private String p_productId;
    private String p_name;
    private int p_unitPrice;
    private int p_cnt;
    private String p_insertDate;


    public CartDTO() {
        super();
    }

    public int getP_cartId() {
        return p_cartId;
    }
    public void setP_cartId(int p_cartId) {
        this.p_cartId = p_cartId;
    }
    public String getP_memberId() {
        return p_memberId;
    }
    public void setP_memberId(String p_memberId) {
        this.p_memberId = p_memberId;
    }
    public String getP_orderNo() {
        return p_orderNo;
    }
    public void setP_orderNo(String p_orderNo) {
        this.p_orderNo = p_orderNo;
    }
    public String getP_productId() {
        return p_productId;
    }
    public void setP_productId(String p_productId) {
        this.p_productId = p_productId;
    }
    public String getP_name() {
        return p_name;
    }
    public void setP_name(String p_name) {
        this.p_name = p_name;
    }
    public int getP_unitPrice() {
        return p_unitPrice;
    }
    public void setP_unitPrice(int p_unitPrice) {
        this.p_unitPrice = p_unitPrice;
    }
    public int getP_cnt() {
        return p_cnt;
    }
    public void setP_cnt(int p_cnt) {
        this.p_cnt = p_cnt;
    }
    public String getP_insertDate() {
        return p_insertDate;
    }
    public void setP_insertDate(String p_insertDate) {
        this.p_insertDate = p_insertDate;
    }


}