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
      var homophone = jQuery(homophone_set).find(".homophone .name");
      return punctuationlessCaseAgnosticStartsWith(homophone.text(), prefix);
    }
  );
  jQuery(matchingSets).show();
}
