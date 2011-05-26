$(function(){
  window.SearchTerm = Backbone.Model.extend({
    initialize: function() {
      this.set({ "currentTerm" : "" });
    },

    updateCurrentTerm: function(term) {
      if (_.isUndefined(term)) { term = ''; }
      this.set({"currentTerm" : $.trim(term)});
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
        this.searchJump();
      } else {
        this.scrollToTop();
      }
    },

    searchJump: function() {
      var matchedHomSets = this.el.find('.homophone span[data^=' + escape(this.model.get('currentTerm')) + ']').closest('.homophone_set');

      if (matchedHomSets.length === 0) {
        return;
      }

      var firstMatch = matchedHomSets.first();
      this.el.scrollTo(firstMatch);
    },

    scrollToTop: function() {
      this.el.scrollTo(0);
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
