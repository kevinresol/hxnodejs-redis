package js.redis;

import js.node.events.EventEmitter;

extern class RedisClientBase extends EventEmitter<RedisClientBase> {
	
	public var connected:Bool;
	public var commandQueueLength:Int;
	public var offlineQueueLength:Int;
	
	public function auth(password:String, ?callback:js.Error->Dynamic->Void):Dynamic;
	public function quit():Dynamic;
	public function end(flush:Bool):Dynamic;
	public function unref():Dynamic;
	public function multi():Multi;
	public function sendCommand(commandName:String, ?args:Dynamic, ?callback:js.Error->Dynamic->Void):Void;
	public function duplicate(?options:RedisClientOptions, ?callback:js.Error->Dynamic->Void):RedisClient;
}