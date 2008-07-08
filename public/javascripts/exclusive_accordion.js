var ExclusiveAccordion = Class.create({
 
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
    var open_element = $$('.' + this.accordions + '-title.open').first();
    if (open_element) 
    {
      if (!element.hasClassName('open')) 
      {
        var options = $H({duration: 5.0, transition: Effect.Transitions.sinoidal});
        var content = '.' + this.accordions + '-content'
        new Effect.Parallel
        (
          [new Effect.BlindUp(open_element.next(content), options), new Effect.BlindDown(element.next(content), options)], 
          {
            afterFinish: function (e) 
            {
              open_element.removeClassName('open');
            }
          } 
        );
      }
    }
    element.addClassName('open');
  },    

}); 

Event.observe(window, 'load', loadExclusiveAccordion, false);
function loadAccordion() 
{			
  $$('[class$=accordion]').each(function(accordion) 
  {
			new ExclusiveAccordion($w(accordion.className).first());
  }); 
}
