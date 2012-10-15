<%-- 
/*
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS HEADER.
 *
 * Copyright (c) 2012 Oracle and/or its affiliates. All rights reserved.
 *
 * The contents of this file are subject to the terms of either the GNU
 * General Public License Version 2 only ("GPL") or the Common Development
 * and Distribution License("CDDL") (collectively, the "License").  You
 * may not use this file except in compliance with the License.  You can
 * obtain a copy of the License at
 * https://glassfish.dev.java.net/public/CDDL+GPL_1_1.html
 * or packager/legal/LICENSE.txt.  See the License for the specific
 * language governing permissions and limitations under the License.
 *
 * When distributing the software, include this License Header Notice in each
 * file and include the License file at packager/legal/LICENSE.txt.
 *
 * GPL Classpath Exception:
 * Oracle designates this particular file as subject to the "Classpath"
 * exception as provided by Oracle in the GPL Version 2 section of the License
 * file that accompanied this code.
 *
 * Modifications:
 * If applicable, add the following below the License Header, with the fields
 * enclosed by brackets [] replaced by your own identifying information:
 * "Portions Copyright [year] [name of copyright owner]"
 *
 * Contributor(s):
 * If you wish your version of this file to be governed by only the CDDL or
 * only the GPL Version 2, indicate your decision by adding "[Contributor]
 * elects to include this software in this distribution under the [CDDL or GPL
 * Version 2] license."  If you don't indicate a single choice of license, a
 * recipient has the option to distribute your version of this file under
 * either the CDDL, the GPL Version 2 or to extend the choice of license to
 * its licensees as provided above.  However, if you add GPL Version 2 code
 * and therefore, elected the GPL Version 2 license, then the option applies
 * only if the new code is made subject to such option by the copyright
 * holder.
 */
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>WebSocket Chat</title>
        <script language="javascript" type="text/javascript">
            var wsUri = "ws://localhost:8080/chat/chat";
            var websocket = new WebSocket(wsUri);
            
            var username;
            websocket.onopen = function(evt) { onOpen(evt) };
            websocket.onmessage = function(evt) { onMessage(evt) };
            websocket.onerror = function(evt) { onError(evt) };

            function init() {
                output = document.getElementById("output");
            }

            function join() {
                username = textField.value;
                websocket.send(username + " joined");
            }
            
            function send_message() {
                websocket.send(username + ": " + textField.value);
            }

            function onOpen(evt) {
                writeToScreen("CONNECTED");
            }

            function onMessage(evt) {
                writeToScreen("RECEIVED: " + evt.data);
                if (evt.data.indexOf("joined") != -1) {
                    userField.innerHTML += evt.data.substring(0, evt.data.indexOf(" joined")) + "\n";
                } else {
                    chatlogField.innerHTML += evt.data + "\n";
                }
            }

            function onError(evt) {
                writeToScreen('<span style="color: red;">ERROR:</span> ' + evt.data);
            }

            function writeToScreen(message) {
                var pre = document.createElement("p");
                pre.style.wordWrap = "break-word";
                pre.innerHTML = message;
                output.appendChild(pre);
            }

            window.addEventListener("load", init, false);
        </script>
    </head>
    <body>
        <h1>Chat!</h1>
        <div style="text-align: center;">
            <form action=""> 
                
                <table>
                    <tr>
                        <td>
                            Users<br/>
                            <textarea readonly="true" rows="6" cols="20" id="userField"></textarea>
                        </td>
                        <td>
                            Chat Log<br/>
                            <textarea readonly="true" rows="6" cols="50" id="chatlogField"></textarea> 
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <input id="textField" name="name" value="Duke" type="text"><br>
                            <input onclick="join()" value="Join" type="button"> 
                            <input onclick="send_message()" value="Chat" type="button"> 
                        </td>
                    </tr>
                </table>

            </form>
        </div>
        <div id="output"></div>

    </body>
</html>