package mvc.controller;



import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;

import market.ver01.dao.CartDAO;
import market.ver01.dao.ProductDAO;
import market.ver01.dto.CartDTO;
import market.ver01.dto.Product;

@WebServlet(urlPatterns = {"/web_jsp/market/shop_db/addCart.jsp", "/web_jsp/market/shop_db/cart.jsp"})
public class CartController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String RequestURI = req.getRequestURI();
        String contextPath = req.getContextPath();

        String command = RequestURI.substring(contextPath.length()); // 전체 경로에서 프로젝트 Path 길이 만큼의 인덱스 이후의 문자열을 가져옴.

        resp.setContentType("text/html; charset=utf-8");
        req.setCharacterEncoding("utf-8");

        System.out.println("cart command : " + command);

        if(command.contains("addCart.jsp")) { // 장바구니 담기
            // 파라미터로 넘어온 아이디 값을 확인
            String productId = req.getParameter("id");
            if (productId == null || productId.trim().equals("")) {
                resp.sendRedirect("products.jsp");
                return;
            }

            ProductDAO productDAO = new ProductDAO();
            Product productDTO = productDAO.getProductById(productId);
            if (productDTO == null) {
                resp.sendRedirect("exceptionNoProductId.jsp");
            }

            HttpSession session = req.getSession();
            String orderNo= session.getId();
            String memberId = (String) session.getAttribute("sessionId");
            CartDAO cartDAO = new CartDAO();
            boolean flag = cartDAO.updateCart(productDTO, orderNo, memberId);

            resp.sendRedirect("product.jsp?id=" + productId);
        }
        else if (command.contains("cart.jsp")) {
            CartDAO cartDAO = new CartDAO();

            HttpSession session = req.getSession(); //세션 사용을 위해 생성
            String orderNo = session.getId();

            ArrayList<CartDTO> carts = cartDAO.getCartList(orderNo);
            req.setAttribute("carts", carts);
            RequestDispatcher requestDispatcher = req.getRequestDispatcher("/web_jsp/market/shop_db/@cart.jsp");
            requestDispatcher.forward(req, resp);
        }
    }
}
