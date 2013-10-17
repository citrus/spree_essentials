// -------------------------------------------------------------------
// markItUp!
// -------------------------------------------------------------------
// Copyright (C) 2008 Jay Salvat
// http://markitup.jaysalvat.com/
// -------------------------------------------------------------------
// MarkDown tags example
// http://en.wikipedia.org/wiki/Markdown
// http://daringfireball.net/projects/markdown/
// -------------------------------------------------------------------
// Feel free to add more tags
// -------------------------------------------------------------------
var qualifySpreePath = function(target_path) {
  var r = window.location.href.match(/(https?:\/\/[^\/]+.*\/admin)/);
  if (r)
    return r[1]+target_path;
  else
    return "/admin"+target_path;
};

markdownSettings = {
	previewParserPath:	qualifySpreePath('/markdown/preview?authenticity_token='+encodeURIComponent($('meta[name="csrf-token"]').attr("content"))),
	onShiftEnter:		{keepDefault:false, openWith:'\n\n'},
	markupSet: [
		{name:'First Level Heading', key:'1', placeHolder:'Your title here...', closeWith:function(markItUp) { return miu.markdownTitle(markItUp, '=') } },
		{name:'Second Level Heading', key:'2', placeHolder:'Your title here...', closeWith:function(markItUp) { return miu.markdownTitle(markItUp, '-') } },
		{name:'Heading 3', key:'3', openWith:'### ', placeHolder:'Your title here...' },
		{name:'Heading 4', key:'4', openWith:'#### ', placeHolder:'Your title here...' },
		{name:'Heading 5', key:'5', openWith:'##### ', placeHolder:'Your title here...' },
		{name:'Heading 6', key:'6', openWith:'###### ', placeHolder:'Your title here...' },
		{separator:'---------------' },		
		{name:'Bold', key:'B', openWith:'**', closeWith:'**'},
		{name:'Italic', key:'I', openWith:'_', closeWith:'_'},
		{separator:'---------------' },
		{name:'Bulleted List', openWith:'- ' },
		{name:'Numeric List', openWith:function(markItUp) {
			return markItUp.line+'. ';
		}},
		{separator:'---------------' },
		{name:'Picture', key:'P', replaceWith:'![[![Alternative text]!]]([![Url:!:http://]!] "[![Title]!]")'},
		{name:'Link', key:'L', openWith:'[', closeWith:']([![Url:!:http://]!] "[![Title]!]")', placeHolder:'Your text to link here...' },
		{separator:'---------------'},	
		{name:'Quotes', openWith:'> '},
		{name:'Code Block / Code', openWith:'(!(\t|!|`)!)', closeWith:'(!(`)!)'},
		{separator:'---------------'},
		{name:'More Tag', openWith:'<!-- more -->'},
		{name:'Image Browser', call:'miu.launch_image_picker'},
		{name:'Preview', call:'preview'}
	]
}

// mIu nameSpace to avoid conflict.
miu = {

  hide_image_picker: function() {
    miu.image_picker.animate({
      'height': 0
    }, 250, function() {  
      miu.image_picker.remove();
      miu.image_picker = null;
    });
  },

  launch_image_picker: function() {
    if (miu.image_picker) {
      miu.hide_image_picker();
      return;
    }
    var f = $('.markItUpEditor');
    var w = f.outerWidth();
    var h = f.outerHeight();
    miu.image_picker = $('<div class="image-picker"></div>').css('width', w).css(f.position()).load(qualifySpreePath('/uploads'), function(res) {
      miu.image_picker.find('li a').click(function(evt) {
        evt.preventDefault();
        var size, value, start, src = this.href;
        var li = $(this).css('opacity', 0.3).parent().append('<span class="sizes"><a href="#sm">small</a><a href="#med">medium</a><a href="#lrg">large</a></span>');
        li.find('.sizes a').click(function(evt) {
          evt.preventDefault();
          size = this.innerHTML;
          value = f.val();
          start = f.get(0).selectionStart;
          value = value.substr(0, start) + '![REPLACE-WITH-ALT](' + src.replace('original', size) + ' "REPLACE-WITH-TITLE")' + value.substr(start, value.length);
          f.val(value);
          miu.hide_image_picker();
        });
          
      });
      miu.image_picker.appendTo('.markItUpContainer').animate({
        'height': h
      }, 250);
    });
  },
  
  
	markdownTitle: function(markItUp, char) {
		heading = '';
		n = $.trim(markItUp.selection||markItUp.placeHolder).length;
		for(i = 0; i < n; i++) {
			heading += char;
		}
		return '\n'+heading;
	}
}
