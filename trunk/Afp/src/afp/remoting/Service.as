package afp.remoting
{
	import org.osflash.signals.Signal;

	import flash.events.AsyncErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;

	public dynamic class Service extends Proxy implements IEventDispatcher
	{
		private var _dispatcher : EventDispatcher;
		private var _connection : URLLoader;
		private var _servicePath : String;
		private var _onResult : Signal;
		private var _onError : Signal;

		public function Service(service : String)
		{
			_dispatcher = new EventDispatcher();
			_servicePath = service;
			_onResult = new Signal(Object);
			_onError = new Signal(Object);
		}

		private function _onConnexionError(event : Event) : void
		{
			_onError.dispatch(event.target.data);
		}

		private function _onSuccess(event : Object) : void
		{
			_onResult.dispatch(event.target.data);
		}

		override flash_proxy function callProperty(methodName : *, ...params : *) : *
		{
			var url : String = _servicePath + '?method=' + methodName;
			var i : uint = params.length;
			if (i == 1)
				url += '&param' + '=' + params[0];
			else
				while (i--)
					url += '&param' + i + '=' + params[i];
			_connection = new URLLoader();
			// écoute l'événements de la connexion
			_connection.addEventListener(Event.COMPLETE, _onSuccess);
			// écoute les différents événements d'échec de la connexion
			_connection.addEventListener(NetStatusEvent.NET_STATUS, _onConnexionError);
			_connection.addEventListener(IOErrorEvent.IO_ERROR, _onConnexionError);
			_connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, _onConnexionError);
			_connection.addEventListener(AsyncErrorEvent.ASYNC_ERROR, _onConnexionError);
			trace(url);
			_connection.load(new URLRequest(url));
			return _connection;
		}

		override flash_proxy function hasProperty(name : *) : Boolean
		{
			return false;
		}

		override flash_proxy function getProperty(name : *) : *
		{
			return undefined;
		}

		public function toString() : String
		{
			return "[object Service]";
		}

		public function addEventListener(type : String, listener : Function, useCapture : Boolean = false, priority : int = 0, useWeakReference : Boolean = false) : void
		{
			_dispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}

		public function dispatchEvent(event : Event) : Boolean
		{
			return _dispatcher.dispatchEvent(event);
		}

		public function hasEventListener(type : String) : Boolean
		{
			return _dispatcher.hasEventListener(type);
		}

		public function removeEventListener(type : String, listener : Function, useCapture : Boolean = false) : void
		{
			_dispatcher.removeEventListener(type, listener, useCapture);
		}

		public function willTrigger(type : String) : Boolean
		{
			return _dispatcher.willTrigger(type);
		}

		public function get onResult() : Signal
		{
			return _onResult;
		}

		public function get onError() : Signal
		{
			return _onError;
		}
	}
}