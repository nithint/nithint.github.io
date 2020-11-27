---
title: jQuery Formhints plugin
date: 2009-11-29 04:56:00.000000000 -08:00
categories:
- javascript
- programming
permalink: "/2009/11/29/jquery-formhints-plugin/"
---

A very simple jquery plugin for showing hints right next to form inputs.
This is a jquery adaptation of the excellent javascript & css form hint
script
[here](http://www.askthecssguy.com/2007/03/form_field_hints_with_css_and.html).

I’ve made it where the form hints show up when you mouse over the input
elements. You can also make a small edit to the script so that the
formhints only show when the user actually clicks on an input element.
Just change the “input.mouseover” to an “input.click”.

~~~javascript
(function($){
  $.fn.formhints = function(params){
    $(":input", this).each(
      function(i)
      {
        var input = $(this);
        if(input.next("span").length &gt; 0)
        { // if this input element has a span next to it
          $(input.next("span")).hide();// initially hide all
          input.mouseover(function() {
            var pos = $(this).position();
            var left = pos.left + $(this).width() + 30;
            $(input.next("span")).css({'display':'inline', 'top':pos.top+'px','left':left+'px'});
          });
          input.mouseout(function() {
            $(input.next("span")).css('display','none');
          });
        }
      }
    );
  };
})(jQuery);
~~~

In order to use it, the form html needs to be modified. Each input
element with a hint must have an adjacent “span” element which contains
the hint text that will be displayed to the user. Here’s a sample input
element:

~~~html
<div class="input text required">
  <label for="ScriptName">Script name</label>
  <input id="ScriptName" maxlength="200" name="data[Script][name]" type="text" />
  <span class="hint">
    Name of the script
    <span class="hint-pointer"> </span>
  </span></div>
~~~

Note the span element after the input element. It will contain the hint
that will be displayed to the user on mouseover. You can apply css
styles to the hint to make it look nice. I’m just reusing the hint class
developed by askthecssguy for his script which looks quite nice.

Once you’ve gotten the span elements added to your form, add this one
line to your page load function to get your form ready for action.

~~~javascript
$(document).ready(function(){
  $("#formidhere").formhints();
});
~~~

And that’s it. Make sure to replace the “formidhere” with the id of your
form.

Here’s the css I used for my form hint and the final result.

~~~css
.hint {
  position: absolute;
  width: 200px;
  margin-top: -4px;
  border: 1px solid #c93;
  padding: 10px 12px;
  background: #ffc url(../img/hint_pointer.gif) no-repeat -100px -100px;
}

.hint .hint-pointer {
  position: absolute;
  left: -10px;
  top: 5px;
  width: 10px;
  height: 19px;
  background: url(../img/hint_pointer.gif) left top no-repeat;
}
~~~
