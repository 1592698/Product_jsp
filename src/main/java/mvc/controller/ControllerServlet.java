package mvc.controller;

import model.LoginBean;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class ControllerServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html; charset=utf-8");

        String id = req.getParameter("id");
        String password = req.getParameter("passwd");

        LoginBean bean = new LoginBean();
        bean.setId(id);
        bean.setPassword(password);
        req.setAttribute("bean", bean);

        boolean status = bean.validate();

        if (status) {
            RequestDispatcher rd = req.getRequestDispatcher("mvc_success.jsp");
            rd.forward(req, resp);
        } else {
            RequestDispatcher rd = req.getRequestDispatcher("mvc_error.jsp");
            rd.forward(req, resp);
        }
    }
}
