package js.redis;

typedef RedisClientOptions = {
	?host:String,
	?port:Int,
	?path:String,
	?url:String,
	?parser:Dynamic,
	?stringNumbers:Bool,
	?returnBuffers:Bool,
	?detectBuffers:Bool,
	?socketKeepalive:Bool,
	?noReadyCheck:Bool,
	?enableOfflineQueue:Bool,
	?retryMaxDelay:Int, // milliseconds
	?connectTimeout:Int,
	?maxAttempts:Int,
	?retryUnfulfilledCommands:Bool,
	?password:String,
	?db:String,
	?family:String,
	?disableResubscribing:Bool,
	?renameCommands:Dynamic,
	?tls:Dynamic,
	?prefix:String,
	?retryStrategy:Dynamic->Dynamic,
}