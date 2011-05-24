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
  var noMatchingHomophones = $('#no_matching_homophones');
  if(prefix == '' || prefix == null) {
    homophoneSets.show();
    noMatchingHomophones.hide();
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
  if(matchingSets.length > 0) {
    noMatchingHomophones.hide();
    jQuery(matchingSets).show();
  } else {
    noMatchingHomophones.show();
  }
}

$(document).ready(function() {
    $("#twitter").getTwitter({
        userName: "mrhomophone",
        numTweets: 5,
        loaderText: "Loading tweets...",
        slideIn: true,
        showHeading: true,
        headingText: "Latest Tweets",
        showProfileLink: true
    });
});

$(document).ready(function() {
  $('#homophone_entry .homophone .name:first').keyup(function(event) {
    displayMatchingHomophoneSets($(this).val());
  });
});
