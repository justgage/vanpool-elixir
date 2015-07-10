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
  var promise = $.post(window.path, info);
  data = {
    userid : window.userid
  };
  promise.done(function (data) { location.reload(); })
  promise.fail(function (data) { alert("Sorry there was an error on the server ⨂_⨂"); })
}
