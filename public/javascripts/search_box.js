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
    }
  });

  window.searchTerm = new SearchTerm();

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
    window.searchTerm.updateCurrentTerm("");
  });

});
