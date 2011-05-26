//fake browser window
jasmine = require("jasmine-node");
global.jsdom = require("jquery/node_modules/jsdom");
global.window = jsdom
                .jsdom()
                .createWindow();
global.jQuery = require("jquery");

require("../../public/javascripts/application.js");

describe("Hello World", function() {
	
	it("can say hi", function(){
	  var foo = jQuery();
	  expect(foo.sayhi()).toEqual("Hi!");
	});
	
});
