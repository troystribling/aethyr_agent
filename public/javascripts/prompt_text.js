var PromptText = Class.create({
 
  initialize: function(text_field, url, prompt_text)
  {
    this.prompt_text = prompt_text;
    this.url = url;
    text_field.observe('blur', this.textBlurred.bindAsEventListener(this));    
    text_field.observe('focus', this.textFocus.bindAsEventListener(this));    
    text_field.observe('keydown', this.submitRequest.bindAsEventListener(this));    
    this.initText(text_field)
  }, 
 
  initText: function(text_field) {
    var text_value = text_field.value;
    if (text_value == '')
    {
      text_field.value = this.prompt_text;
      text_field.addClassName('prompt-text-loaded')
    }
    else if (text_value == this.prompt_text)
    {
      text_field.value = '';
      text_field.removeClassName('prompt-text-loaded')
    }
  },    

  textFocus: function(event) {
    var text_field = event.element();
    var text_value = text_field.value;
    if (text_value == this.prompt_text)
    {
      text_field.value = '';
      text_field.removeClassName('prompt-text-loaded')
    }
  },    

  textBlurred: function(event) {
    var text_field = event.element();
    var text_value = text_field.value;
    if (text_value == '')
    {
      text_field.value = this.prompt_text;
      text_field.addClassName('prompt-text-loaded')
    }
  },    

  submitRequest: function(event) {
    var key = event.keyCode;
    var text_field = event.element();
    if (key == Event.KEY_RETURN) {
      var text_field = event.element();
      var params = {};
      params['search'] = encodeURIComponent(text_field.value);
      $('loading-indication').show();       
      new Ajax.Request(this.url, {onComplete:function(request){$('loading-indication').hide()}, 
        parameters: params});            
    }
  },    
 
}); 
