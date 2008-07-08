Event.addBehavior.reassignAfterAjax = true;
Event.addBehavior({
    'div.pagination a' : Remote.Link
})

var ApplicationMgr = {

  load: function(event) {
    MenuMgr.loadMenus();
  },

  click: function(event) {
    MenuMgr.closeMenuContentOnDocumentClick();
  },

};

var SearchInputMgr = {

  loadSearchInput: function(url) {
    new PromptText($('search'), url, 'apply filter');
  }, 
    
};

document.observe('click', ApplicationMgr.click.bind(ApplicationMgr));
document.observe('dom:loaded', ApplicationMgr.load.bind(ApplicationMgr));
