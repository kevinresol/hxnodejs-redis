package js.redis;

import js.node.events.EventEmitter;

extern class MultiBase extends EventEmitter<MultiBase> {
	
	public function exec(?callback:js.Error->Array<Dynamic>):Void;
	public function execAtomic(?callback:js.Error->Array<Dynamic>):Void;
}