package;

import haxe.macro.Expr;
import haxe.macro.Context;
import haxe.Json;
import sys.io.File;
using Lambda;

class Generator {
	static var commands = Json.parse(File.getContent('redis-commands.json'));
	
	static function main() {
		build('Multi', ['exec', 'execAtomic']);
		build('RedisClient', ['connected', 'commandQueueLength', 'offlineQueueLength', 'auth', 'quit', 'end', 'unref', 'multi', 'sendCommand', 'duplicate']);
	}
	
	static function build(name:String, ignores:Array<String>) {
		var pack = ['js', 'redis'];
		var ct = if(name == 'Multi') macro:Multi else macro:Void;
		var parent = {pack: pack, name: name + 'Base'};
		var cl = macro class $name extends $parent {}
		
		for(field in Reflect.fields(commands)) {
			if(field.indexOf('-') != -1 || ignores.indexOf(field) != -1) continue; // TODO: invalid characters
			cl.fields.push({
				name: field,
				pos: null,
				kind: FFun({
					args: [{
						name: 'args',
						type: macro:Array<String>,
					}, {
						name: 'callback',
						opt: true,
						type: macro:js.Error->Dynamic->Void,
					}],
					ret: ct,
					expr: null,
				}),
				access: [APublic],
				meta: [{
					name: ':overload',
					pos: null,
					params: [macro function(key:String, args:Array<String>, ?callback:js.Error->Dynamic->Void):$ct {}]
				}]
				.concat([for(i in 1...11) {
					name: ':overload',
					pos: null,
					params: [{
						expr: EFunction(null, {
							args: [for(j in 1...i + 1) {
								meta: null,
								name: 'param$j',
								opt: null,
								type: macro:String,
								value: null,
							}].concat([{
								meta: null,
								name: 'callback',
								opt: true,
								type: macro:js.Error->Dynamic->Void,
								value: null,
							}]),
							expr: macro {},
							params: null,
							ret: ct,
						}),
						pos: null,
					}],
				}])
				.concat(switch field {
					case 'hmset': [{
						name: ':overload',
						pos: null,
						params: [macro function(key:String, obj:{}, ?callback:js.Error->Dynamic->Void):$ct {}]
					}];
					default: [];
				}),
			});
		}
		
		cl.pack = pack;
		cl.isExtern = true;
		
		// add meta
		cl.meta = [{
			name: ':jsRequire',
			params: [
				macro 'redis',
				{
					expr: EConst(CString(name)),
					pos: null,
				}
			],
			pos: null,
		}];
		
		File.saveContent('../src/js/redis/$name.hx', '/* This is a generated file, do not edit */\n\n' + new haxe.macro.Printer().printTypeDefinition(cl));
		
	}
}

@:genericBuild(Macro.build())
class Build<T>{}