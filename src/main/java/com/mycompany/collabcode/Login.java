package com.mycompany.collabcode;

import static com.sun.corba.se.spi.presentation.rmi.StubAdapter.request;
import java.io.IOException;
import java.util.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login.go"},
        loadOnStartup = 1)

/**********************************************************************************************
 * LOGIN
 * This class handles logging in a user based off the post from the login page.
 * ********************************************************************************************/
public class Login extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        //Start a session
        HttpSession session = req.getSession(true);
        
        //Get the username
        String userName = new String(req.getParameter("uid").getBytes("ISO-8859-1"), "UTF-8");
        String newUserName = userName;
        int i = 2;
        Map chat = Chat.getChatMap();
        
        synchronized (chat) {
            //Check for the same user name
            if ("you".equalsIgnoreCase(newUserName)) {
                newUserName = userName;
            }
            //If there's a same user name, add + increment to the name (Jeff -> Jeff2)
            while (chat.containsKey(newUserName)) {
                newUserName = userName + i++;
            }
            userName = newUserName;
            chat.put(userName, new ArrayList<String>());

            //Set session variables
            session.setAttribute("UID", userName);
            req.getSession().setAttribute("UID", userName);
            resp.sendRedirect("chat.jsp");
        }
    }
}
