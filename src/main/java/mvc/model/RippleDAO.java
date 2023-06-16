package mvc.model;

import mvc.database.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class RippleDAO {

    private static RippleDAO instance;

    private RippleDAO() {

    }


    public static RippleDAO getInstance() {
        if (instance == null)
            instance = new RippleDAO();
        return instance;
    }

    public boolean insertRipple(RippleDTO ripple) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        int flag =1;
        try {

            conn = DBConnection.getConnection();
            String sql = "insert into `webMarketDB`.`ripple` values (?, ?, ?, ?, ?, ?, now(), ?)";

            pstmt = conn.prepareStatement(sql);
            System.out.println(sql);
            pstmt.setInt(1, ripple.getRippleId());
            pstmt.setString(2, ripple.getBoardName());
            pstmt.setInt(3, ripple.getBoardNum());
            pstmt.setString(4, ripple.getMemberId());
            pstmt.setString(5, ripple.getName());

            pstmt.setString(6, ripple.getContent());
            //            pstmt.setString(6, ripple.getInsertDate());
            pstmt.setString(7, ripple.getIp());
            System.out.println(ripple.getName());

            flag=pstmt.executeUpdate();

            System.out.println(sql);
            System.out.println(ripple.getRippleId());

        } catch (Exception ex) {
            System.out.println("insertBoard() 에러 : " + ex);
        } finally {
            try {
                if (pstmt != null)
                    pstmt.close();
                if (conn != null)
                    conn.close();
            } catch (Exception ex) {
                throw new RuntimeException(ex.getMessage());
            }
        }
        return flag !=0;
    }

    public ArrayList<RippleDTO> getRippleList(String boardName, int boardNum){
        //게시판 종류와 게시글 번호 필요. 매개변수 2개
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        String sql = "SELECT * FROM `webMarketDB`.`ripple` WHERE boardName = ? AND boardNum = ?";
        ArrayList<RippleDTO> list = new ArrayList<>();
        try {
            connection = DBConnection.getConnection();
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, boardName);
            preparedStatement.setInt(2, boardNum);
            resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                RippleDTO ripple = new RippleDTO();
                ripple.setRippleId(resultSet.getInt("rippleId"));
                ripple.setBoardName(resultSet.getString("boardName"));
                ripple.setBoardNum(resultSet.getInt("boardNum"));
                ripple.setMemberId(resultSet.getString("memberId"));
                ripple.setName(resultSet.getString("name"));
                ripple.setContent(resultSet.getString("content"));
                ripple.setInsertDate(resultSet.getString("insertDate"));
                ripple.setIp(resultSet.getString("ip"));
                list.add(ripple);
             }
            } catch(Exception ex){
                System.out.println("insertBoard() 에러 : " + ex);
            } finally{
                try {
                    if (resultSet != null)
                        resultSet.close();
                    if (preparedStatement != null)
                        preparedStatement.close();
                    if (connection != null)
                        connection.close();
                } catch (Exception ex) {
                    throw new RuntimeException(ex.getMessage());
                }
            }
            return list;
        }

    public boolean deleteRipple(RippleDTO ripple) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        int flag = 0;
        String sql = "DELETE from `webMarketDB`.`ripple` where rippleId=? ";
        try {
            conn = DBConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, ripple.getRippleId());
            flag=pstmt.executeUpdate();

            System.out.println(sql);
            System.out.println(ripple.getRippleId());
        } catch (Exception ex) {
            System.out.println("deleteRipple() 에러 : " + ex);
        } finally {
            try {
                if (pstmt != null)
                    pstmt.close();
                if (conn != null)
                    conn.close();
            } catch (Exception ex) {
                throw new RuntimeException(ex.getMessage());
            }
        }
        return flag !=0;
    }
}
