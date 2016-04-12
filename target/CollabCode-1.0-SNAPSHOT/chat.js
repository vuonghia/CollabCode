window.chat = {};

/**********************************************************************************************
 * SEND MESSAGE
 * This function sends the string to chat.java
 * ********************************************************************************************/
chat.sendMsg = function (msg) {
    var request;
    msg = msg.replace(/&/g, '&amp;')
            .replace(/</g, '&lt;')
            .replace(/>/g, '&gt;')
            .replace(/"/g, '&quot;')
            .replace(/\n/g, '<br />');

    if (request = this.getXmlHttpRequest()) {
        request.open('POST', 'chat.do?action=send&msg=' + msg + '&time=' + new Date().getTime());
        request.send(null);
        
        //Display what you wrote to your own screen
        chat.updateChat('<div style="color:black"><b>You said: ' + msg + '</b></div>');
    }
};

/**********************************************************************************************
 * INIT
 * This function initializes all of the firepad information. The firebase reference is also
 * initialized here.
 * ********************************************************************************************/
function init() {
    // Initialize Firebase.
    var firepadRef = new Firebase('https://popping-inferno-9625.firebaseio.com/');

    //Retrieve username cookie
    var username = getCookie("username");

    //// Create CodeMirror (with lineWrapping on).
    var codeMirror = CodeMirror(document.getElementById('firepad-container'),
            {lineWrapping: true, lineNumbers: true, mode: 'javascript'});

    var userId = Math.floor(Math.random() * 9999999999).toString();

    //// Create Firepad (with rich text toolbar and shortcuts enabled).
    var firepad = Firepad.fromCodeMirror(firepadRef, codeMirror,
            {richTextToolbar: true, richTextShortcuts: true, userId: userId});

    var firepadUserList = FirepadUserList.fromDiv(firepadRef.child('users'),
            document.getElementById('userlist'), userId, username);

    //// Initialize contents.
    firepad.on('ready', function () {
        if (firepad.isHistoryEmpty()) {
            firepad.setHtml('<br/>Collaborative-editing made easy.\n');
        }
    });
}

/**********************************************************************************************
 * CHECK FOR UPDATES
 * This function listens to Chat.java for an updated JSON message. If one is received, then
 * it updates the chat content on the page.
 * ********************************************************************************************/
chat.checkForUpdates = function () {
    if (!chat.listen)
        chat.listen = setInterval(function () {
            var request;
            if (request = chat.getXmlHttpRequest()) {
                request.open('POST', 'chat.do?action=get&time=' + new Date().getTime());
                request.send(null);
                request.onreadystatechange = function () {
                    if (request.readyState === 4) {
                        if (request.status === 200) {
                            var json = request.responseText;

                            //Check for a new message
                            if (json && json.length) {
                                //Parse the message out
                                var obj = eval('(' + json + ')');
                                var msg = '';
                                for (var i = 0; i < obj.length; i++) {
                                    msg += '<div>' + obj[i] + '</div>';
                                }
                                //Update chat
                                chat.updateChat(msg);
                            }
                        } else if (request.status === 400 || request.status === 500)
                            document.location.href = 'index.jsp';
                    }
                };
            }
        }, 2000);
};

/**********************************************************************************************
 * UPDATE CHAT
 * This function takes a message and inserts it into the chat box. It also updates the box if
 * it is overflowed, so that it stays scrolled to the bottom for each new message that has come
 * in.
 * ********************************************************************************************/
chat.updateChat = function (msg) {
    var content = document.getElementById('content');
    
    //Add the message to the chat box
    content.innerHTML += msg;
    
    //Scroll chat to the bottom
    document.getElementById("scrolling").scrollTop = document.getElementById("scrolling").scrollHeight;
};

/**********************************************************************************************
 * DO KEY
 * This function listens for the key 13 (Enter) to be pressed in the chat input box. On the
 * event that it is pressed the message is passed to the Send Message function.
 * ********************************************************************************************/
chat.dokeyup = function (event) {
    if (!event)
        event = window.event;
    
    //Check for Enter Button to be pressed
    if (event.keyCode == 13 && !event.shiftKey) {
        var target = (event.currentTarget) ? event.currentTarget : event.srcElement,
                value = target.value;
        
        if (value && value.replace(/^\s\s*/, '').replace(/\s\s*$/, '').length > 0) {
        //Send the message
            this.sendMsg(target.value);
            target.value = '';
        }
    }
};

chat.getXmlHttpRequest = function () {
    if (window.XMLHttpRequest
            && (window.location.protocol !== 'file:'
                    || !window.ActiveXObject))
        return new XMLHttpRequest();
    try {
        return new ActiveXObject('Microsoft.XMLHTTP');
    } catch (e) {
        throw new Error('XMLHttpRequest not supported');
    }
};

/**********************************************************************************************
 * ON LOAD
 * This function will initialize the listener and start the firepad.
 * ********************************************************************************************/
onload = function () {
    chat.checkForUpdates();
    init();
};