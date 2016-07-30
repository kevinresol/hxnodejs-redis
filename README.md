# hxnodejs-redis

## Usage

```haxe
import js.redis.Redis;

class Main
{
  static function main()
  {
    var client = Redis.createClient();
    client.set('key', 'value');
    client.get('key', function(err, reply) trace(reply)); // 'value'
    client.incr('counter');
    client.get('counter', function(err, reply) trace(reply)); // '1'
  }
}
```
