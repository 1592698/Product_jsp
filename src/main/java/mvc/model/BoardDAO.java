package mvc.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.TreeSet;

import mvc.database.DBConnection;

import javax.servlet.http.HttpServletRequest;

public class BoardDAO {
    /* DAO(Data Access Object)는 데이터베이스의 data에 접근하기 위한 객체 */
    /* 싱글턴 타입으로 작성. */
    private static BoardDAO instance;

    private BoardDAO() {

    }

    public static BoardDAO getInstance() {
        if (instance == null)
            instance = new BoardDAO();
        return instance;
    }

    // board 테이블의 레코드 개수
    public int getListCount(String items, String text) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        int x = 0; // 레코드 개수 저장할 변수.

        String sql;

        if (items == null && text == null)
            sql = "SELECT count(*) FROM `webMarketDB`.`board`";
        else
            sql = "select count(*) from `webMarketDB`.`board` where " + items + " like '%" + text + "%'";

        try {
            conn = DBConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            if (rs.next())
                x = rs.getInt(1);

        } catch (Exception ex) {
            System.out.println("getListCount() 에러: " + ex);
        } finally {
            try {
                if (rs != null)
                    rs.close();
                if (pstmt != null)
                    pstmt.close();
                if (conn != null)
                    conn.close();
            } catch (Exception ex) {
                throw new RuntimeException(ex.getMessage());
            }
        }
        return x;
    }

    // board 테이블의 레코드 가져오기
    public ArrayList<BoardDTO> getBoardList(int page, int limit, String items, String text) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        int total_record = getListCount(items, text);
        int start = (page - 1) * limit;
        int index = start + 1;

        String sql;

        if (items == null && text == null)
            sql = "select * from `webMarketDB`.`board` order by num desc";
        else
            sql = "select * from `webMarketDB`.`board` where " + items + " like '%" + text + "%' order by num desc ";

        ArrayList<BoardDTO> list = new ArrayList<BoardDTO>();

        try {
            conn = DBConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            // ResultSet.absolute(int index) : ResultSet 커서를 원하는 위치(Index)의 검색행으로 이동하는 메서드. 해당 인덱스가 존재하면 true반환. 없으면 false 반환.
            while (rs.absolute(index)) {
                BoardDTO board = new BoardDTO();
                board.setNum(rs.getInt("num"));
                board.setId(rs.getString("id"));
                board.setName(rs.getString("name"));
                board.setSubject(rs.getString("subject"));
                board.setContent(rs.getString("content"));
                board.setRegist_day(rs.getString("regist_day"));
                board.setHit(rs.getInt("hit"));
                board.setIp(rs.getString("ip"));
                list.add(board);

                if (index < (start + limit) && index <= total_record)
                    index++;
                else
                    break;
            }
            return list;
        } catch (Exception ex) {
            System.out.println("getBoardList() 에러 : " + ex);
        } finally {
            try {
                if (rs != null)
                    rs.close();
                if (pstmt != null)
                    pstmt.close();
                if (conn != null)
                    conn.close();
            } catch (Exception ex) {
                throw new RuntimeException(ex.getMessage());
            }
        }
        return null;
    }

    //member 테이블에서 인증된 id의 사용자명 가져오기
    public String getLoginNameById(String id) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        String name = null;
        String sql = "select * from `webMarketDB`.`member` where id = ? ";

        try {
            conn = DBConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);
            rs = pstmt.executeQuery();

            if (rs.next())
                name = rs.getString("name");
            return name;

        } catch (Exception ex) {
            System.out.println("getBoardByNum() 에러: " + ex);
        } finally {
            try {
                if (rs != null)
                    rs.close();
                if (pstmt != null)
                    pstmt.close();
                if (conn != null)
                    conn.close();
            } catch (Exception ex) {
                throw new RuntimeException(ex.getMessage());
            }
        }
        return name;
    }

    public void insertBoard(BoardDTO board) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DBConnection.getConnection();

            String sql = "insert into `webMarketDB`.`board` values (?, ?, ?, ?, ?, now(), ?, ?,?,?)";

            pstmt = conn.prepareStatement(sql);
            System.out.println(sql);
            pstmt.setInt(1, board.getNum());
            pstmt.setString(2, board.getId());
            pstmt.setString(3, board.getName());
            pstmt.setString(4, board.getSubject());
            pstmt.setString(5, board.getContent());
//            pstmt.setString(6, board.getRegist_day());
            pstmt.setInt(6, board.getHit());
            pstmt.setString(7, board.getIp());
            pstmt.setString(8,board.getFilename());
            pstmt.setLong(9,board.getFilesize());

            pstmt.executeUpdate();
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
    }

    // 선택된 글 상세 내용 가져오기
    public BoardDTO getBoardByNum(int num, int page) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        BoardDTO board = null;

        updateHit(num);
        String sql = "select * from `webMarketDB`.`board` where num = ? ";

        try {
            conn = DBConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, num);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                board = new BoardDTO();
                board.setNum(rs.getInt("num"));
                board.setId(rs.getString("id"));
                board.setName(rs.getString("name"));
                board.setSubject(rs.getString("subject"));
                board.setContent(rs.getString("content"));
                board.setRegist_day(rs.getString("regist_day"));
                board.setHit(rs.getInt("hit"));
                board.setIp(rs.getString("ip"));
                board.setFilename(rs.getString("filename"));
            }
            return board;
        } catch (Exception ex) {
            System.out.println("getBoardByNum() 에러 : " + ex);
        } finally {
            try {
                if (rs != null)
                    rs.close();
                if (pstmt != null)
                    pstmt.close();
                if (conn != null)
                    conn.close();
            } catch (Exception ex) {
                throw new RuntimeException(ex.getMessage());
            }
        }
        return null;
    }

    // 선택된 글의 조회수 증가하기
    public void updateHit(int num) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
//            String sql = "update `webMarketDB`.`board` set hit = hit + 1 where num = ?";
            conn = DBConnection.getConnection();

//            pstmt = conn.prepareStatement(sql);
//            pstmt.setInt(1, num);

            String sql = "select `hit` from `webMarketDB`.`board` where num = ? ";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, num);
            rs = pstmt.executeQuery();
            int hit = 0;

            if (rs.next()) {
                hit = rs.getInt("hit") + 1;
            }

            sql = "update `webMarketDB`.`board` set hit = ? where num = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, hit);
            pstmt.setInt(2, num);
            pstmt.executeUpdate();
        } catch (Exception ex) {
            System.out.println("updateHit() 에러 : " + ex);
        } finally {
            try {
                if (rs != null)
                    rs.close();
                if (pstmt != null)
                    pstmt.close();
                if (conn != null)
                    conn.close();
            } catch (Exception ex) {
                throw new RuntimeException(ex.getMessage());
            }
        }
    }

    //선택된 글 내용 수정하기
    public void updateBoard(BoardDTO board){
        Connection conn = null;
        PreparedStatement pstmt = null;

        try{
            String sql = "UPDATE `webMarketDB`.`board` set name=?, subject=?, content=? where num=?";

            conn = DBConnection.getConnection();
            pstmt = conn.prepareStatement(sql);

            pstmt.setString(1, board.getName());
            pstmt.setString(2, board.getSubject());
            pstmt.setString(3, board.getContent());
            pstmt.setInt(4, board.getNum());

            pstmt.executeUpdate();

        } catch(Exception ex){
            System.out.println("updateBoard() 에러 : " + ex);

        } finally {
            try{
                if(pstmt !=null)
                    pstmt.close();
                if(conn!=null)
                    conn.close();
            } catch(Exception ex){
                throw new RuntimeException(ex.getMessage());
            }

        }
    }

    public void deleteBoard(int num){
        Connection conn = null;
        PreparedStatement pstmt = null;

        String sql = "DELETE from `webMarketDB`.`board` where num=? ";
        try{
            conn=DBConnection.getConnection();
            pstmt=conn.prepareStatement(sql);
            pstmt.setInt(1, num);
            pstmt.executeUpdate();
        } catch (Exception ex){
            System.out.println("deleteBoard() 에러 : " + ex);
        } finally {
            try{
                if(pstmt!=null)
                    pstmt.close();
                if(conn!=null)
                    conn.close();
            } catch(Exception ex){
                throw new RuntimeException(ex.getMessage());
            }
        }

    }
}
