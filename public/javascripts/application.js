function punctuationlessCaseAgnosticStartsWith(word, prefix) {
  removePunctuationAndApostrophe = function(string) {
    return string.toLowerCase().replace(/'/g, "");
  }
  return removePunctuationAndApostrophe(word).indexOf(
          removePunctuationAndApostrophe(prefix)
         ) == 0;
}

function displayMatchingHomophoneSets(prefix) {
  var homophoneSets = $('#homophone_navigation .homophone_set');
  if(prefix == '' || prefix == null) {
    homophoneSets.show();
    return;
  }

  homophoneSets.hide();
  var matchingSets = jQuery.grep($('#homophone_navigation .homophone_set'),
    function(homophone_set, index) {
      var homophones = $(homophone_set).find(".homophone .name");
      var matchingHomophones = jQuery.grep(homophones, function(homophone, indexOfHomophone) {
        return punctuationlessCaseAgnosticStartsWith($(homophone).text(), prefix);
      });
      return matchingHomophones.length > 0;
    }
  );
  jQuery(matchingSets).show();
}

$(document).ready(function() {
  $('#homophone_entry .homophone .name:first').keyup(function(event) {
    displayMatchingHomophoneSets($(this).val());
  });
});
