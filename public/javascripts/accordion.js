var InclusiveAccordion = Class.create({
 
  initialize: function(accordions) 
  {
    this.accordions = accordions
    $$('.' + accordions + '-title').each(function(accordion) 
    {
      accordion.observe('click', this.useAccordion.bindAsEventListener(this));
    }.bind(this)); 
  }, 
 
  useAccordion: function(event) {
    var element = event.element();
    var duration = 0.5;
    var content = '.' + this.accordions + '-content'
    if (element.hasClassName('open')) 
    {
      options = {duration: duration, afterFinish: function () {element.removeClassName('open');}};
      new Effect.BlindUp(element.next(content), options); 
    } 
    else 
    {
      options = {duration: duration, afterFinish: function () {element.addClassName('open');}};
      new Effect.BlindDown(element.next(content), options);
    }
  },    

}); 

Event.observe(window, 'load', loadInclusiveAccordion, false);
function loadInclusiveAccordion() 
{			
  $$('[class$=accordion]').each(function(accordion) 
  {
			new InclusiveAccordion($w(accordion.className).first());
  }); 
}
