// import {Socket} from "phoenix"
// let socket = new Socket("/ws")
// socket.connect()
// let chan = socket.chan("topic:subtopic", {})
// chan.join().receive("ok", chan => {
//   console.log("Success!")
// })
"use strict";


var App = {
  init: function init() {
    $('body').append('App initialized.');
  }
};


module.exports = App;
