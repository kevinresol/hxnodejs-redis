package js.redis;

import js.redis.RedisClient;

@:jsRequire('redis')
extern class Redis {
	
	public static function createClient(?options:RedisClientOptions):RedisClient;
	
}

