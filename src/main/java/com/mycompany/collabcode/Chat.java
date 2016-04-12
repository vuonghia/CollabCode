package com.mycompany.collabcode;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.json.JSONArray;

@WebServlet(name = "ChatServlet", urlPatterns = {"/chat.do"},
        loadOnStartup = 1)

/**********************************************************************************************
 * CHAT
 * This class handles all chat functionality sent in from chat.js
 * ********************************************************************************************/
public class Chat extends HttpServlet {
    private static final long serialVersionUID = 113880057049845876L;
    private static Map<String, List<String>> _chat = new HashMap<String, List<String>>();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        
        //Send the message
        if ("send".equals(action)) {
            
            //Get the message
            String message = new String(req.getParameter("msg").getBytes("ISO-8859-1"), "UTF-8");
            
            //Get the user name
            String userName = (String) req.getSession().getAttribute("UID");
            
            //Verify string and send it
            for (String tempString : _chat.keySet()) {
                if (!tempString.equals(userName)) {
                    synchronized (_chat.get(tempString)) {
                        //Send the message to other users
                        _chat.get(tempString).add("<div style=\"color:black\">"
                                + userName  + " said: " + message + "</div>");
                    }
                }
            }
        } else if ("get".equals(action)) { 
            String userName = (String) req.getSession().getAttribute("UID");
            if (userName == null) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST);
            }
            List<String> list = _chat.get(userName);
            synchronized (list) {
                if (list.size() > 0) {
                    resp.setCharacterEncoding("UTF-8");
                    PrintWriter out = resp.getWriter();
                    
                    //Initiate JSON
                    JSONArray jsna = new JSONArray();
                    
                    //Fill the JSON object with the messages
                    while (list.size() > 0) {
                        jsna.add(list.remove(0));
                    }

                    out.println(jsna);
                    out.close();
                }
            }
        }
    }

    public static Map<String, List<String>> getChatMap() {
        return _chat; }
}