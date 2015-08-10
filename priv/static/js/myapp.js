var check_in = function (van, dir, keys) {
  $("#sticky-bottom-bar").toggleClass("sticky-up", true);
  window.dir = dir;
  window.vanid = van;
}

var check_in_disable = function () {
  $("#sticky-bottom-bar").toggleClass("sticky-up", false)
}

var check_in_key = function (keys) {

  keys = !!keys;


  var info = {
    "riding" : {
      "vanid" : vanid,
      "userid" : userid,
      "dir" : dir,
      "date" : date,
      "keys" : keys
    },
  };

  console.log(JSON.stringify(info));

  check_in_disable();

  var promise = $.post(window.path, info);
  promise.done(function (data) { location.reload(); })
  promise.fail(function (data) { alert("Sorry there was an error on the server ⨂_⨂"); })
}

var hideButton = function(id, state) {
  $(id).toggleClass("show-buttons", state);
  $(id).toggleClass("hide-buttons", !state);
}

function clear_ride(date) {
  var info = {
    userid : window.userid
  };
  var promise = $.post(window.path, info);
  promise.done(function (data) { location.reload(); })
  promise.fail(function (data) { alert("Sorry there was an error on the server ⨂_⨂"); })
}

function save_local_userid(user_id) {
  localStorage.setItem("user_id", user_id);
}

function send_local_userid(user_id) {
  var userid = localStorage.getItem("user_id");

  if (userid !== null) {
    var promise = $.get("/auth/userid_login/" + userid);
    promise.done(function (data) { location.reload(); })
    promise.fail(function (data) { alert("Sorry there was an error on the server ⨂_⨂"); })
  }

}

function try_login(path) {
    var token = localStorage.getItem("my-token");
    if(token) {
      login_with_token(path, localStorage.getItem("my-token"));
    }
}

function login_with_token(path, token) {
  var promise = $.post(path, info);
  promise.done(function (data) { location.reload(); })
  promise.fail(function (data) { alert("Sorry there was an error on the server ⨂_⨂"); })
}

function delete_all() {
     var info = {
       "riding" : {
         "userid" : userid,
         "date" : date,
       },
     };
    var promise = $.post("/api/riding/delete_all", info);
    promise.done(function (data) { location.reload(); })
    promise.fail(function (data) { alert("Sorry there was an error on the server ⨂_⨂"); })
}
