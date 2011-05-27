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

var HomsetView = function(event) {
  this.homset = $(event.target).parents('.homophone_set');
};
HomsetView.prototype.edit = function(form) {
  this.homset.find('.display').hide();
  this.homset.append(form);
}
HomsetView.prototype.id = function() {
  return this.homset.attr('data');
};
HomsetView.prototype.editUrl = function() {
  return '/homophone_sets/' + this.id() + '/edit'
};
HomsetView.prototype.display = function() {
  this.homset.find('.edit').remove();
  this.homset.find('.display').show();
};
HomsetView.prototype.editForm = function() {
  return $(event.target).parents('form');
};
HomsetView.prototype.updateUrl = function() {
  return this.editForm().attr('action');
};
HomsetView.prototype.updateData = function() {
  return this.editForm().serialize();
};
HomsetView.prototype.finishEditing = function(data) {
  this.homset.find('.display').html(data);
  this.display();
};


jQuery(function($) {
  
  $(".editable .homophone_set .display").dblclick(function(event) {
    var homset = new HomsetView(event);
    $.get(homset.editUrl(), function(form) {
      homset.edit(form);
    });
  });

  $('.cancel').live('click', function(event) {
    new HomsetView(event).display();
    return false;
  });

  $('.edit_homophone_set .submit').live('click', function(event) {
    var homset = new HomsetView(event);
    $.post(homset.updateUrl(), homset.updateData(), function(data){
      homset.finishEditing(data);
    });
    return false;
  });
  
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
});

(function($) {
  jQuery.fn.sayhi = function() {
    return "Hi!";
  }
})(jQuery);

get_keys = function(obj) {
    var keys = [];
    for (var key in obj) {
        keys.push(key);
    }
    return keys;
}
