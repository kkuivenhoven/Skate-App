!function(t,e,o){function n(t){return t}function r(t){return i(decodeURIComponent(t.replace(p," ")))}function i(t){return 0===t.indexOf('"')&&(t=t.slice(1,-1).replace(/\\"/g,'"').replace(/\\\\/g,"\\")),t}function s(t){return a.json?JSON.parse(t):t}var p=/\+/g,a=t.cookie=function(i,p,u){if(p!==o){if(u=t.extend({},a.defaults,u),null===p&&(u.expires=-1),"number"==typeof u.expires){var c=u.expires,h=u.expires=new Date;h.setDate(h.getDate()+c)}return p=a.json?JSON.stringify(p):String(p),e.cookie=[encodeURIComponent(i),"=",a.raw?p:encodeURIComponent(p),u.expires?"; expires="+u.expires.toUTCString():"",u.path?"; path="+u.path:"",u.domain?"; domain="+u.domain:"",u.secure?"; secure":""].join("")}for(var l=a.raw?n:r,d=e.cookie.split("; "),f=i?null:{},_=0,v=d.length;_<v;_++){var m=d[_].split("="),b=l(m.shift()),S=l(m.join("="));if(i&&i===b){f=s(S);break}i||(f[b]=s(S))}return f};a.defaults={},t.removeCookie=function(e,o){return null!==t.cookie(e)&&(t.cookie(e,null,o),!0)}}(jQuery,document),function(){!function(t,e){var o,n;n=e.document,o=function(){function o(e){this._options=t.extend({name:"tour",labels:{end:"End tour",next:"Next &raquo;",prev:"&laquo; Prev"},template:"<div class='popover tour'>            <div class='arrow'></div>            <h3 class='popover-title'></h3>            <div class='popover-content'></div>          </div>",container:"body",keyboard:!0,useLocalStorage:!1,debug:!1,backdrop:!1,redirect:!0,basePath:"",afterSetState:function(){},afterGetState:function(){},afterRemoveState:function(){},onStart:function(){},onEnd:function(){},onShow:function(){},onShown:function(){},onHide:function(){},onHidden:function(){},onNext:function(){},onPrev:function(){}},e),this._options.useLocalStorage||t.cookie||this._debug("jQuery.cookie is not loaded."),this._steps=[],this.setCurrentStep(),this.backdrop={overlay:null,step:null,background:null}}return o.prototype.setState=function(o,n){return o=this._options.name+"_"+o,this._options.useLocalStorage?e.localStorage.setItem(o,n):t.cookie(o,n,{expires:36500,path:"/"}),this._options.afterSetState(o,n)},o.prototype.removeState=function(o){return o=this._options.name+"_"+o,this._options.useLocalStorage?e.localStorage.removeItem(o):t.removeCookie(o,{path:"/"}),this._options.afterRemoveState(o)},o.prototype.getState=function(o){var n;return void 0!==(n=this._options.useLocalStorage?e.localStorage.getItem(this._options.name+"_"+o):t.cookie(this._options.name+"_"+o))&&"null"!==n||(n=null),this._options.afterGetState(o,n),n},o.prototype.addSteps=function(t){var e,o,n,r;for(r=[],o=0,n=t.length;o<n;o++)e=t[o],r.push(this.addStep(e));return r},o.prototype.addStep=function(t){return this._steps.push(t)},o.prototype.getStep=function(e){if(null!=this._steps[e])return t.extend({path:"",placement:"right",title:"",content:"",id:"step-"+e,next:e===this._steps.length-1?-1:e+1,prev:e-1,animation:!0,backdrop:this._options.backdrop,redirect:this._options.redirect,onShow:this._options.onShow,onShown:this._options.onShown,onHide:this._options.onHide,onHidden:this._options.onHidden,onNext:this._options.onNext,onPrev:this._options.onPrev,template:this._options.template,container:this._options.container},this._steps[e])},o.prototype.start=function(e){var o,r=this;return null==e&&(e=!1),this.ended()&&!e?this._debug("Tour ended, start prevented."):(t(n).off("click.bootstrap-tour",".popover .next").on("click.bootstrap-tour",".popover .next",function(t){return t.preventDefault(),r.next()}),t(n).off("click.bootstrap-tour",".popover .prev").on("click.bootstrap-tour",".popover .prev",function(t){return t.preventDefault(),r.prev()}),t(n).off("click.bootstrap-tour",".popover .end").on("click.bootstrap-tour",".popover .end",function(t){return t.preventDefault(),r.end()}),this._onresize(function(){return r.showStep(r._current)}),this._setupKeyboardNavigation(),o=this._makePromise(null!=this._options.onStart?this._options.onStart(this):void 0),this._callOnPromiseDone(o,this.showStep,this._current))},o.prototype.next=function(){var t;return t=this.hideStep(this._current),this._callOnPromiseDone(t,this.showNextStep)},o.prototype.prev=function(){var t;return t=this.hideStep(this._current),this._callOnPromiseDone(t,this.showPrevStep)},o.prototype.end=function(){var o,r,i=this;return o=function(){if(t(n).off("click.bootstrap-tour"),t(n).off("keyup.bootstrap-tour"),t(e).off("resize.bootstrap-tour"),i.setState("end","yes"),i._hideBackdrop(),null!=i._options.onEnd)return i._options.onEnd(i)},r=this.hideStep(this._current),this._callOnPromiseDone(r,o)},o.prototype.ended=function(){return!!this.getState("end")},o.prototype.restart=function(){return this.removeState("current_step"),this.removeState("end"),this.setCurrentStep(0),this.start()},o.prototype.hideStep=function(e){var o,n,r,i=this;return r=this.getStep(e),n=this._makePromise(null!=r.onHide?r.onHide(this):void 0),o=function(){var e;if(e=t(r.element).popover("hide"),r.reflex&&e.css("cursor","").off("click.boostrap-tour"),r.backdrop&&i._hideBackdrop(),null!=r.onHidden)return r.onHidden(i)},this._callOnPromiseDone(n,o),n},o.prototype.showStep=function(e){var o,r,i,s=this;if(i=this.getStep(e))return o=this._makePromise(null!=i.onShow?i.onShow(this):void 0),r=function(){var o,r;if(s.setCurrentStep(e),r="function"==typeof i.path?i.path.call():s._options.basePath+i.path,o=[n.location.pathname,n.location.hash].join(""),!s._isRedirect(r,o))return null!=i.element&&0!==t(i.element).length&&t(i.element).is(":visible")?(i.backdrop&&s._showBackdrop(i.element),s._showPopover(i,e),null!=i.onShown&&i.onShown(s),s._debug("Step "+(s._current+1)+" of "+s._steps.length)):(s._debug("Skip the step "+(s._current+1)+". The element does not exist or is not visible."),void s.showNextStep());s._redirect(i,r)},this._callOnPromiseDone(o,r)},o.prototype.setCurrentStep=function(t){return null!=t?(this._current=t,this.setState("current_step",t)):(this._current=this.getState("current_step"),null===this._current?this._current=0:this._current=parseInt(this._current))},o.prototype.showNextStep=function(){var t,e,o,n=this;return o=this.getStep(this._current),e=function(){return n.showStep(o.next)},t=this._makePromise(null!=o.onNext?o.onNext(this):void 0),this._callOnPromiseDone(t,e)},o.prototype.showPrevStep=function(){var t,e,o,n=this;return o=this.getStep(this._current),e=function(){return n.showStep(o.prev)},t=this._makePromise(null!=o.onPrev?o.onPrev(this):void 0),this._callOnPromiseDone(t,e)},o.prototype._debug=function(t){if(this._options.debug)return e.console.log("Bootstrap Tour '"+this._options.name+"' | "+t)},o.prototype._isRedirect=function(t,e){return null!=t&&""!==t&&t.replace(/\?.*$/,"").replace(/\/?$/,"")!==e.replace(/\/?$/,"")},o.prototype._redirect=function(t,e){return"function"==typeof t.redirect?t.redirect.call(this,e):!0===t.redirect?(this._debug("Redirect to "+e),n.location.href=e):void 0},o.prototype._renderNavigation=function(t,e){var o;return o=[],t.prev>=0&&o.push("<a href='#"+t.prev+"' class='prev'>"+e.labels.prev+"</a>"),t.next>=0&&o.push("<a href='#"+t.next+"' class='next'>"+e.labels.next+"</a>"),o.join(" | ")+"<a href='#' class='pull-right end'>"+e.labels.end+"</a>"},o.prototype._showPopover=function(e){var o,n,r,i=this;return n=e.content+"<br /><p>",r=t.extend({},this._options),e.options&&t.extend(r,e.options),e.reflex&&t(e.element).css("cursor","pointer").on("click.bootstrap-tour",function(){return i.next()}),n+=this._renderNavigation(e,r),t(e.element).popover("destroy").popover({placement:e.placement,trigger:"manual",title:e.title,content:n,html:!0,animation:e.animation,container:e.container,template:e.template}).popover("show"),(o=t(e.element).data("popover").tip()).attr("id",e.id),this._reposition(o,e),this._scrollIntoView(o)},o.prototype._reposition=function(e,o){var r,i,s,p,a,u,c;if(a=e[0].offsetWidth,p=e[0].offsetHeight,s=(c=e.offset()).left,u=c.top,(r=t(n).outerHeight()-c.top-t(e).outerHeight())<0&&(c.top=c.top+r),(i=t("html").outerWidth()-c.left-t(e).outerWidth())<0&&(c.left=c.left+i),c.top<0&&(c.top=0),c.left<0&&(c.left=0),e.offset(c),"bottom"===o.placement||"top"===o.placement){if(s!==c.left)return this._replaceArrow(e,2*(c.left-s),a,"left")}else if(u!==c.top)return this._replaceArrow(e,2*(c.top-u),p,"top")},o.prototype._replaceArrow=function(t,e,o,n){return t.find(".arrow").css(n,e?50*(1-e/o)+"%":"")},o.prototype._scrollIntoView=function(o){var n;if(!((n=o.get(0).getBoundingClientRect()).top>=0&&n.bottom<t(e).height()&&n.left>=0&&n.right<t(e).width()))return o.get(0).scrollIntoView(!0)},o.prototype._onresize=function(o,n){return t(e).on("resize.bootstrap-tour",function(){return clearTimeout(n),n=setTimeout(o,100)})},o.prototype._setupKeyboardNavigation=function(){var e=this;if(this._options.keyboard)return t(n).on("keyup.bootstrap-tour",function(t){if(t.which)switch(t.which){case 39:return t.preventDefault(),e._current<e._steps.length-1?e.next():e.end();case 37:if(t.preventDefault(),e._current>0)return e.prev();break;case 27:return t.preventDefault(),e.end()}})},o.prototype._makePromise=function(e){return e&&t.isFunction(e.then)?e:null},o.prototype._callOnPromiseDone=function(t,e,o){var n=this;return t?t.then(function(){return e.call(n,o)}):e.call(this,o)},o.prototype._showBackdrop=function(t){if(null===this.backdrop.overlay)return this._showOverlay(),this._showOverlayElement(t)},o.prototype._hideBackdrop=function(){if(null!==this.backdrop.overlay)return this._hideOverlayElement(),this._hideOverlay()},o.prototype._showOverlay=function(){return this.backdrop=t("<div/>"),this.backdrop.addClass("tour-backdrop"),this.backdrop.height(t(n).innerHeight()),t("body").append(this.backdrop)},o.prototype._hideOverlay=function(){return this.backdrop.remove(),this.backdrop.overlay=null},o.prototype._showOverlayElement=function(e){var o,n,r,i;return r=5,(n=(i=t(e)).offset()).top=n.top-r,n.left=n.left-r,(o=t("<div/>")).width(i.innerWidth()+r).height(i.innerHeight()+r).addClass("tour-step-background").offset(n),i.addClass("tour-step-backdrop"),t("body").append(o),this.backdrop.step=i,this.backdrop.background=o},o.prototype._hideOverlayElement=function(){return this.backdrop.step.removeClass("tour-step-backdrop"),this.backdrop.background.remove(),this.backdrop.step=null,this.backdrop.background=null},o}(),e.Tour=o}(jQuery,window)}.call(this);