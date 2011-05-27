$(function(){
  window.SearchTerm = Backbone.Model.extend({
    initialize: function() {
      this.set({ "currentTerm" : "" });
    },

    updateCurrentTerm: function(term) {
      if (_.isUndefined(term)) { term = ''; }
      this.set({"currentTerm" : $.trim(term).toLowerCase()});
    },

    hasTerm: function() {
      return this.get("currentTerm").length > 0;
    },

    clear: function() {
      this.set({"currentTerm" : ""});
    }
  });

  window.searchTerm = new SearchTerm();

  window.SearchInput = Backbone.View.extend({
    el: $('#search_term'),

    initialize: function() {
      _.bindAll(this, 'render');
      this.model = window.searchTerm;
      this.model.bind("change", this.render);
    },

    render: function() {
      if (! this.model.hasTerm() ) {
        this.el.val("");
      }
    } 
  });

  window.HomophoneView = Backbone.View.extend({
    el: $('.homophone_set_list'),

    initialize: function() {
      _.bindAll(this, 'scrollSearch', 'searchJump');
      this.model = window.searchTerm;
      this.model.bind("change", this.scrollSearch);
    },

    scrollSearch: function() {
      if (this.model.hasTerm() ) {
        this.findMatchedHomSets();
        this.highlightHomSets();
        this.searchJump();
      } else {
        this.clearHighlighting();
        this.scrollToTop();
      }
    },

    searchJump: function() {
      if (this.matchedHomSets.length === 0) {
        return;
      }

      var firstMatch = this.matchedHomSets.first();
      this.el.scrollTo(firstMatch);
    },

    clearHighlighting: function() {
      _.map(this.el.find('.homophone_set'), function(el) {
        $(el).removeClass("highlighted");
        _.map($(el).find('span.name'), function(el) {
          $(el).removeClass("highlighted");
        });
      });
    },

    highlightHomSets: function(){
      this.clearHighlighting();

      _.map(this.matchedHomophones, function(el) {
        $(el).addClass("highlighted");
      });

      _.map(this.matchedHomSets, function(el) {
        $(el).addClass("highlighted");
      });
    },

    scrollToTop: function() {
      this.el.scrollTo(0);
    },

    findMatchedHomSets: function() {
      this.matchedHomophones = this.el.find('.homophone span[data^=' + escape(this.model.get('currentTerm')) + ']');
      this.matchedHomSets = this.matchedHomophones.closest('.homophone_set');
    }
  });

  window.homophoneView = new HomophoneView();

  window.searchInput = new SearchInput();

  window.SearchTermIndicator = Backbone.View.extend({
    el : $('#search_cancel'),

    initialize: function() {
      _.bindAll(this, 'render');
      this.model = window.searchTerm;
      this.model.bind('change', this.render);
    },

    render :function() {
      if (this.model.hasTerm()) {
        this.el.show();
      } else {
        this.el.hide();
      }
    }
  });

  window.searchTermIndicator = new SearchTermIndicator();

  $('#search_term').keyup(function(){
    var currentTerm = $('#search_term').val();
    window.searchTerm.updateCurrentTerm(currentTerm);
  });

  $('#search_cancel').click(function(){
    window.searchTerm.clear();
  });
});
