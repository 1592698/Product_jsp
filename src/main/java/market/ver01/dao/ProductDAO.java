package market.ver01.dao;

import market.ver01.dto.Product;
import mvc.database.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ProductDAO {

    private Connection connection = null;
    private PreparedStatement preparedStatement = null;
    private ResultSet resultSet = null;

    //db연결 메서드
    void connect() {
        try {
            connection = DBConnection.getConnection();
        } catch(Exception e) {
            e.printStackTrace();
        }
    }
    public ProductDAO() {
        connect();
    }


    public Product getProductById(String id) {

        //전달된 id에 해당하는 상품을 디비에서 조회해서
        //1) 있는 경우 객체에 담아서 전달
        //2) 없는 경우 null전달

        Product product = null;
        String sql = "SELECT * FROM product WHERE p_id = ?";
        try {
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, id);
            resultSet=preparedStatement.executeQuery();

            if (resultSet.next()) {
                product = new Product(resultSet.getString("p_id"),
                        resultSet.getString("p_name"), resultSet.getInt("p_unitPrice"));
                product.setDescription (resultSet.getString("p_description"));
                product.setCategory (resultSet.getString("p_category"));
                product.setManufacturer (resultSet.getString("p_manufacturer"));
                product.setUnitsInStock (resultSet.getInt("p_unitsInstock"));
                product.setCondition (resultSet.getString("p_condition"));
                product. setFilename (resultSet.getString("p_fileName"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return product;
    }

}
