/**
 * http://usejsdoc.org/
 */
var module = require('./custom_module');

function test(){
	module.sum(100);
}
console.log('sum = %d',module.sum(100));
console.log('var1 = %s',module.var1);