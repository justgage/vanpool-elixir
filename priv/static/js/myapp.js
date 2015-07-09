var check_in = function (dir, keys) {
  $("#sticky-bottom-bar").toggleClass("sticky-up", true);
  window.dir = dir;
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


  check_in_disable();

  var promise = $.post(path, info);
  promise.done(function (data) { location.reload(); })
  promise.fail(function (data) { alert("Sorry there was an error on the server ⨂_⨂"); })
}
