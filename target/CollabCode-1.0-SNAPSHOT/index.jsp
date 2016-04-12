<%@ page isErrorPage="true" language="java"
    contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored ="false" %>

<html>
    <head>
        <meta http-equiv="Content-Type" 
            content="text/html; charset=UTF-8"/>
        <link rel="stylesheet" type="text/css" href="http://fonts.googleapis.com/css?family=Shadows+Into+Light">
        <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
        <link href="index.css" rel=stylesheet />
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
        <title>Login</title>
    </head>
    <body>
        <div class="col-lg-4 col-md-3 col-ms-2 col-xs-1"></div>
        <div class="col-lg-4 col-md-6 col-ms-8 col-xs-10" >
            <div class=animatable id=hero>
            <form action="login.go" method="post"
                  style="font-family:'Shadows Into Light';">
                <h1 style="text-align:center;color:#43749E;line-height: 100px;">
                    <br/><b/>Collab Code<b/><br/>
                </h1>
                <br/>
                <input class="form-control input-lg input" id="userId" 
                       type="text" value="" name="uid" 
                       placeholder="Your ID" required/>
                <br/><br/><br/>
                <input class="btn btn-primary btn-lg" type="submit" value="login"/>
            </form>
            </div>
        </div>
        <div class="col-lg-4 col-md-3 col-ms-2 col-xs-1"></div>
    </body>
</html>


