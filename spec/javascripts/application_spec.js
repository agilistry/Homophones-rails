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

