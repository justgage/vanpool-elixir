// import {Socket} from "phoenix"
// let socket = new Socket("/ws")
// socket.connect()
// let chan = socket.chan("topic:subtopic", {})
// chan.join().receive("ok", chan => {
//   console.log("Success!")
// })
"use strict";


function save_local(user_id, token) {
  localStorage.setItem("user_id", user_id);
  localStorage.setItem("token", token);
}

var App = {
  init: function init() {
    $('body').append('App initialized.');
  }
};


module.exports = App;
