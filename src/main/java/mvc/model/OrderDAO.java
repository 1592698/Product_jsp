package mvc.model;

import mvc.database.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;


public class OrderDAO {
    private static OrderDAO instance;

    public static OrderDAO getInstance() {
        if (instance == null)
            instance = new OrderDAO();
        return instance;
    }

    public void clearOrderData(String orderNo) {
//        주문 번호 기분으로 주문 데이터 삭제
//                중복 등록 방지
        String sql = "DELETE from `webMarketDB`.`order_data` where orderNo=? ";
        try (  Connection conn = DBConnection.getConnection();
            PreparedStatement  pstmt = conn.prepareStatement(sql)){
            pstmt.setString(1, orderNo);
            pstmt.executeUpdate();
        } catch (Exception ex) {
            System.out.println("deleteRipple() 에러 : " + ex);
        }
    }

    public boolean insertOrderData(OrderDataDTO dto) {
        int flag = 0;
        String sql = "INSERT INTO `webMarketDB`.`order_data` values(null, ?,?,?,?,?,?,?)";
        try(Connection conn = DBConnection.getConnection();
        PreparedStatement pstmt = conn.prepareStatement(sql)){
            pstmt.setString(1, dto.getOrderNo());
            pstmt.setInt(2, dto.getCartId());
            pstmt.setString(3, dto.getProductId());
            pstmt.setString(4, dto.getProductName());
            pstmt.setInt(5, dto.getUnitPrice());
            pstmt.setInt(6, dto.getCnt());
            pstmt.setInt(7, dto.getSumPrice());
            flag = pstmt.executeUpdate();
        }catch (Exception ex ){
            System.out.println("insertOrderData() 에러 : " + ex);
        }
        return flag != 0;
    }

    public ArrayList<OrderDataDTO> selectAllOrderData(String orderNo) {
        ArrayList<OrderDataDTO> dtos = new ArrayList<>();

        String sql = "select * from `webMarketDB`.`order_data` where orderNo = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, orderNo);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                OrderDataDTO dto = new OrderDataDTO();
                dto.setNum(rs.getInt("num"));
                dto.setOrderNo(rs.getString("orderNo"));
                dto.setCartId(rs.getInt("cartId"));
                dto.setProductId(rs.getString("productId"));
                dto.setProductName(rs.getString("productName"));
                dto.setUnitPrice(rs.getInt("unitPrice"));
                dto.setCnt(rs.getInt("cnt"));
                dto.setSumPrice(rs.getInt("sumPrice"));
                dtos.add(dto);
            }
        } catch (Exception ex) {
            System.out.println("selectAllOrderData() 에러 : " + ex);
        }
        return dtos;
    }

    public int getTotalPrice(String orderNo) {
        // 3. 주문된 금액을 가지고 옴
        int totalPrice = 0;
        String sql = "SELECT SUM(sumPrice) FROM `webMarketDB`.`order_data` WHERE orderNo = '" + orderNo + "'";
        try(Connection conn = DBConnection.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();) {
            if(rs.next()) {
                totalPrice = rs.getInt(1);
            }
        } catch (Exception ex) {
            System.out.println("getTotalPrice() 에러 : " + ex);
        }
        return totalPrice;
    }


    public void clearOrderInfo(String orderNo) {
        /*주문번호 기준으로 주문 정보 데이터 삭제
        * 중복 등록 방지*/
        String sql = "delete from `webMarketDB`.`order_info` where orderNo = ?";
        try(Connection conn = DBConnection.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)){
            pstmt.setString(1, orderNo);
            pstmt.executeUpdate();
        }catch(Exception ex){
            System.out.println("clearOrderInfo() 에러 : " + ex);
        }
    }

    public boolean insertOrderInfo(OrderInfoDTO dto) {
        int flag = 0;
        String sql = "insert into order_info values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, now(), ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, dto.getOrderNo());
            pstmt.setString(2, dto.getMemberId());
            pstmt.setString(3, dto.getOrderName());
            pstmt.setString(4, dto.getOrderTel());
            pstmt.setString(5, dto.getOrderEmail());
            pstmt.setString(6, dto.getReceiveName());
            pstmt.setString(7, dto.getReceiveTel());
            pstmt.setString(8, dto.getReceiveAddress());
            pstmt.setInt(9, dto.getPayAmount());
            pstmt.setString(10, dto.getPayMethod());
            pstmt.setString(11, dto.getCarryNo());
            pstmt.setString(12, "orderFail");
            pstmt.setString(13, dto.getDatePay());
            pstmt.setString(14, dto.getDateCarry());
            pstmt.setString(15, dto.getDateDone());
            flag = pstmt.executeUpdate();

        } catch (Exception ex) {
            System.out.println("insertOrderData() 에러 : " + ex);
        }
        return flag != 0;

    }

    public OrderInfoDTO getOrderInfo(String orderNo) {
        OrderInfoDTO dto = new OrderInfoDTO();
        String sql = "SELECT * FROM order_info WHERE orderNo = '" + orderNo + "'";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);
             ResultSet resultSet = preparedStatement.executeQuery();
        ) {
            if (resultSet.next()) {
                dto.setOrderNo(resultSet.getString(1));
                dto.setMemberId(resultSet.getString(2));
                dto.setOrderName(resultSet.getString(3));
                dto.setOrderTel(resultSet.getString(4));
                dto.setOrderEmail(resultSet.getString(5));

                dto.setReceiveName(resultSet.getString(6));
                dto.setReceiveTel(resultSet.getString(7));
                dto.setReceiveAddress(resultSet.getString(8));
                dto.setPayAmount(resultSet.getInt(9));
                dto.setPayMethod(resultSet.getString(10));

                dto.setCarryNo(resultSet.getString(11));
                dto.setOrderStep(resultSet.getString(12));
                dto.setDateOrder(resultSet.getString(13));
                dto.setDatePay(resultSet.getString(14));
                dto.setDateCarry(resultSet.getString(15));

                dto.setDateDone(resultSet.getString(16));
            }
        } catch (Exception ex) {
            System.out.println("getOrderInfo() : " + ex);
        }
        return dto;
    }

    public String getOrderProductName(String orderNo) {
        String orderProductName = null;
        int orderProductCnt = 0;
        String sql = "SELECT * FROM order_data WHERE orderNo = '" + orderNo + "'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet resultSet = pstmt.executeQuery();) {
            while (resultSet.next()) {
                if (orderProductCnt == 0) {
                    orderProductName = resultSet.getString("productName");
                }
                orderProductCnt++;
            }
            System.out.println(orderProductName);
            orderProductName += "외" + (orderProductCnt - 1) + "개";
        } catch (Exception ex) {
            System.out.println("selectAllOrderData() 02: " + ex);
        }
        return orderProductName;
    }

    public boolean updateOrderInfoWhenProcessSuccess(OrderInfoDTO dto) {

        // 성공시에 주문 정보 업데이트
        int flag = 0;
        String sql = "UPDATE order_info SET payMethod = ?, orderStep =?, datePay = now() WHERE orderNo = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);) {
            pstmt.setString(1, dto.getPayMethod());
            pstmt.setString(2, dto.getOrderStep());
            pstmt.setString(3, dto.getOrderNo());
            flag = pstmt.executeUpdate();
        } catch (Exception ex) {
            System.out.println("updateOrderInfoWhenProcessSuccess() 에러 : " + ex);
        }
        return flag == 1;
    }
}
