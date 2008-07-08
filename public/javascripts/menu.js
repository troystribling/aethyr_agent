var Menu = Class.create({
 
  initialize: function() 
  {
    $$('li.menu').each(function(menu) 
    {
      menu.observe('click', this.useMenu.bindAsEventListener(this));
    }.bind(this)); 
  }, 
 
  useMenu: function(event) {
    var menu = event.element();    
    if (menu.hasClassName('menu')) 
    {
      if (menu.hasClassName('menu-open')) 
      {
        MenuMgr.closeMenuContent(menu);
      } 
      else 
      {
        MenuMgr.openMenuContent(menu);
      }
      event.stop();
    }
  },    

}); 

var MenuMgr = {

  duration: 0.25,

  closeAllMenuContents: function() {
    $$('li.menu-open').each(function(menu)
    {
      this.closeMenuContent(menu);
    }.bind(this));
  },

  closeMenuContent: function(menu) {
    var content = menu.down();
    var options = {duration: this.duration, afterFinish: function () {menu.removeClassName('menu-open');}};
    new Effect.BlindUp(content, options); 
  },

  openMenuContent: function(menu) {
      this.closeAllMenuContents();
      var content = menu.down();
      var options = {duration: this.duration, afterFinish: function () {menu.addClassName('menu-open');}};
      new Effect.BlindDown(content, options);
  },

  closeMenuContentOnDocumentClick: function(event) {
      this.closeAllMenuContents();
  },

  loadMenus: function() {
    new Menu();
  },

};
