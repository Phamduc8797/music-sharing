$(document).ready(function() {
  $('form').on('click', '.remove_fields', function(event) {
    $(this).prev('input[type=hidden]').val('1');
    $(this).closest('fieldset').hide();
    event.preventDefault();
  });
  $('form').on('click', '.add_fields', function(event) {
    var regexp, time;
    time = new Date().getTime();
    regexp = new RegExp($(this).data('id'), 'g');
    $(this).before($(this).data('fields').replace(regexp, time));
    event.preventDefault();
  });
});

// see more and compact lyric
function coLyric() {
  var x = document.getElementById("lyric_close");
  if (x.className === "lyric_open") {
    document.getElementById("coLyric").innerHTML = "v See more...";
    x.className = "closesd";
  } else {
    x.className = "lyric_open";
    document.getElementById("coLyric").innerHTML = "^ Compact";
  }
}

//choose song add to album
$(document).ready(function(){
  $("#myInputListSong").on("keyup", function() {
    var value = $(this).val().toLowerCase();
    $("#myListSong li").filter(function() {
      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
    });
  });
});
