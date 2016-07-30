package;

import haxe.Json;
import js.redis.Redis;
import buddy.*;
import utest.Assert;

class RunTests extends buddy.SingleSuite {
	public function new() {
		var client = Redis.createClient();
		
		describe("Test Redis", {
			it("Test get/set", function(done) {
				client.set('key', 'value');
				client.get('key', function(err, reply) { 
					Assert.equals('value', reply);
					done();
				});
			});
			it("Test incr", function(done) {
				
				client.incr('counter', function(err, reply) Assert.equals(1, reply));
				client.get('counter', function(err, reply) {
					Assert.equals('1', reply);
					done();
				});
			});
			it("Test hash", function(done) {
				
				client.hmset('hash', {a:1, b:2});
				client.hgetall('hash', function(err, reply) {
					Assert.equals('1', reply.a);
					Assert.equals('2', reply.b);
				});
				client.hget('hash', 'a', function(err, reply) {
					Assert.equals('1', reply);
					done();
				});
			});
			it("Test multi", function(done) {
				
				client.multi()
					.set('multi1', 'value1')
					.set('multi2', 'value2')
					.exec();
				client.get('multi1', function(err, reply) Assert.equals('value1', reply));
				client.get('multi2', function(err, reply) {
					Assert.equals('value2', reply);
					done();
				});
			});
		});
	}
}