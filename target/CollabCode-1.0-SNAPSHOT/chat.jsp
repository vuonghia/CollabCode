<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page isErrorPage="true" language="java"
         contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored ="false" %>
<!-- Make sure they entered a user ID, or send them back to the login page -->
<c:if test="${UID == null}">
    <c:redirect url="index.jsp" />
</c:if>
<html>
    <head>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <title>Collab Code</title>
        <link href="css/chat.css" rel="stylesheet" type="text/css">
        <link href="chat.css" rel=stylesheet />
        <script type="text/javascript" src="chat.js"></script>
        
        <!--Below this line to head Matthew's Added code-->
        <meta charset="utf-8" />
        
        <!-- Firebase -->
        <script src="https://cdn.firebase.com/js/client/2.2.4/firebase.js"></script>
        
        <!-- CodeMirror and its JavaScript mode file -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.2.0/codemirror.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.2.0/mode/javascript/javascript.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.2.0/codemirror.css" />

        <!-- Firepad -->
        <link rel="stylesheet" href="https://cdn.firebase.com/libs/firepad/1.1.0/firepad.css" />
        <script src="https://cdn.firebase.com/libs/firepad/1.1.0/firepad.min.js"></script>

        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="http://fonts.googleapis.com/css?family=Droid+Sans">
        <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
        <script src="firepad-userlist.js"></script>
        <link rel="stylesheet" href="firepad-userlist.css" />
    </head>
    <body>
        <!-- HEADING TITLE -->
        <div class="container">
            <div class="row">
                <div class="col-md-2"></div>
                <div class="col-md-8 featureBottom">
                    <h1><b>=#%$*=>> Collab Code <<=*$%#=</b></h1>
                </div>
                <div class="col-md-2"></div>
            </div>
        </div>

        <hr/>

            <!-- BODY PART -->
            <div class="container">
            <div class="row">
                <div class="col-md-4" 
                     style="font-family:'Droid+Sans';font-size:15;">
                    <form action="logout.go" method="post">

                        <!-- USERS DISPLAY -->
                        <div class="featureLeft1">
                            <p id="text-title">Participants:</p>
                            <div class="panel panel-default" id="customized-border"
                                 style="overflow-x:auto;overflow-y:auto; height:75px;">
                                <div id="userlist" style="background-color:#FFFFFF;width:100%;
                                     padding-right: 7px;padding-left: 7px;">
                                </div>
                            </div>
                        </div>

                        
                        <!-- CHAT BOX -->
                        <div class="featureLeft2">
                            <p id="text-title">Chat:</p>
                            <div class="panel panel-default" id="scrolling"
                                 style="overflow-x:auto;overflow-y:auto; height:220px;
                                 padding-top: 7px;
                                 padding-right: 7px;
                                 padding-bottom: 7px;
                                 padding-left: 7px;
                                 word-break: break-word;">
                                <div class="content" id="content" TextWrapping="Wrap" overflow: scroll>
                                </div>
                            </div>
                        </div>

                        
                        <!-- CHAT INPUT -->
                        <div class="featureLeft3">
                            <div>
                                <!-- listen to keyup to send message if enter pressed -->
                                <textarea class="form-control msg-input" onkeyup="chat.dokeyup(event);"
                                          style="width:100%;height:70px" placeholder="Chat here ..."
                                          id="customized-border"></textarea>
                                <br/>
                                <!--            <input class="form-control input-sm"  onkeyup="chat.dokeyup(event);" type="text"/>-->
                            </div>
                            <input class="btn btn-primary btn-block" type="submit" value="Log Out" />
                        </div>
                    </form>
                </div>

                <!-- TEXT EDITOR -->
                <div class="col-md-8">
                    <div class="featureRight">
                        <p id="text-title">Text Editor:</p>
                        <div id="customized-border">
                            <div class="panel panel-default" id="firepad-container"
                                 style="margin-left:auto;margin-right:auto;width:100%">
                            </div>      
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <br/><hr/><br/>

        <%
            //In this section we are getting the userid and storing it as a cookie
            String username = (String) session.getAttribute("UID");
            //Declare a new Cookie Object
            Cookie cookie = new Cookie("username", username);
            //Set the cookie's expiration date
            cookie.setMaxAge(24 * 60 * 60);
            //Add the cookie
            response.addCookie(cookie);
        %>

    </body>
</html>