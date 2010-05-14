require("spec_helper.js");
require("../../public/javascripts/application.js");

Screw.Unit(function(){
  describe("Your application javascript", function(){
    it("does something", function(){
      expect("hello").to(equal, "hello");
    });

    it("accesses the DOM from fixtures/application.html", function(){
      expect($('.select_me').length).to(equal, 2);
    });
  });
});

Screw.Unit(function(){
  describe("punctuationlessCaseAgnosticStartsWith(word1, word2)", function(){
    it("checks basic equality", function(){
      expect(punctuationlessCaseAgnosticStartsWith('hello', 'hello')).
        to(be_true);

      expect(punctuationlessCaseAgnosticStartsWith('hello', 'hola')).
        to(be_false);
    });

    it("is case agnostic", function(){
      expect(punctuationlessCaseAgnosticStartsWith('HeLlO', 'hElLo')).
        to(be_true);
    });

    it("ignores apostrophes", function(){
      expect(punctuationlessCaseAgnosticStartsWith("h'ello", "he'll'o")).
        to(be_true);
    });
    
    it("checks that the word starts with the prefix", function() {
      expect(punctuationlessCaseAgnosticStartsWith('hello', 'he')).
        to(be_true);

      expect(punctuationlessCaseAgnosticStartsWith('hello', 'hek')).
        to(be_false);      

      expect(punctuationlessCaseAgnosticStartsWith('hello', 'el')).
        to(be_false);      
    });
  });
});

Screw.Unit(function(){
  describe("displayMatchingHomophoneSets(prefix)", function(){
    it("hides homophone sets that don't match", function() {
      displayMatchingHomophoneSets('turk');
      expect($('#homophone_navigation .homophone_set .name:contains("bar")').
        parents('.homophone_set').is(':hidden')).to(be_true);
    });

    it("shows homophone sets that do match", function() {
      displayMatchingHomophoneSets('turk');
      expect($('#homophone_navigation .homophone_set .name:contains("turkey")').
        parents('.homophone_set').is(':hidden')).to(be_false);
    });

    it("looks at all homophones in a set for a match", function() {
      displayMatchingHomophoneSets('bo');
      expect($('#homophone_navigation .homophone_set .name:contains("bor")').
        parents('.homophone_set').is(':hidden')).to(be_false);
    });

    it("shows all homophone sets when passed an empty string", function() {
      $('#homophone_navigation .homophone_set').hide();
      displayMatchingHomophoneSets('');
      expect($('#homophone_navigation .homophone_set .name:contains("turkey")').
        parents('.homophone_set').is(':hidden')).to(be_false);
    });

    it("shows all homophone sets when passed null", function() {
      $('#homophone_navigation .homophone_set').hide();
      displayMatchingHomophoneSets(null);
      expect($('#homophone_navigation .homophone_set .name:contains("turkey")').
        parents('.homophone_set').is(':hidden')).to(be_false);
    });

    it("displays 'No matching homophones' when none match", function() {
      displayMatchingHomophoneSets('this will never match');
      expect($('#no_matching_homophones').is(':hidden')).to(be_false);
    })

    it("hides 'No matching homophones' there is a match", function() {
      $('#no_matching_homophones').show();
      displayMatchingHomophoneSets('tur');
      expect($('#no_matching_homophones').is(':hidden')).to(be_true);
    })

    it("hides 'No matching homophones' when passed an empty string", function() {
      $('#no_matching_homophones').show();
      displayMatchingHomophoneSets('');
      expect($('#no_matching_homophones').is(':hidden')).to(be_true);
    })

    it("hides 'No matching homophones' when passed null", function() {
      $('#no_matching_homophones').show();
      displayMatchingHomophoneSets(null);
      expect($('#no_matching_homophones').is(':hidden')).to(be_true);
    })
  });
});
