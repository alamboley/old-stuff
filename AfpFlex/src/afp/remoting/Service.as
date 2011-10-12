package afp.remoting {

	import org.osflash.signals.Signal;

	import flash.events.AsyncErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;

	public dynamic class Service extends Proxy implements IEventDispatcher
	{
		private var _dispatcher : EventDispatcher;
		private var _connection : URLLoader;
		private var _servicePath : String;
		private var _type : String;
		private var _onResult : Signal;
		private var _onError : Signal;

		public function Service(service : String, type : String = 'GET')
		{
			_dispatcher = new EventDispatcher();
			_servicePath = service;
			_type = type;
			_onResult = new Signal(Object);
			_onError = new Signal(Object);
		}

		private function _onConnexionError(event : Event) : void
		{
			_removeListeners();
			_onError.dispatch(event.target.data);
		}

		private function _onSuccess(event : Event) : void
		{
			_removeListeners();
			_onResult.dispatch(event.target.data);
		}

		override flash_proxy function callProperty(methodName : *, ...params : *) : *
		{
			var requestVars : URLVariables = new URLVariables();
			var urlRequest : URLRequest = new URLRequest(_servicePath);
			if (methodName != 'nomethod') requestVars.method = methodName;
			var i : uint = params.length;
			if (i == 1)
			{
				trace('Object', params[0] is Object)
				requestVars['param'] = params[0];
			}
			else
				while (i--)
					requestVars['param' + i] = params[i];
			urlRequest.data = requestVars;
			urlRequest.method = _type;
			_connection = new URLLoader();
			_connection.dataFormat = URLLoaderDataFormat.TEXT;

			// écoute l'événements de la connexion
			_connection.addEventListener(Event.COMPLETE, _onSuccess);
			// écoute les différents événements d'échec de la connexion
			_connection.addEventListener(NetStatusEvent.NET_STATUS, _onConnexionError);
			_connection.addEventListener(IOErrorEvent.IO_ERROR, _onConnexionError);
			_connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, _onConnexionError);
			_connection.addEventListener(AsyncErrorEvent.ASYNC_ERROR, _onConnexionError);
			_connection.load(urlRequest);
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

		private function _removeListeners() : void
		{
			_connection.removeEventListener(Event.COMPLETE, _onSuccess);
			_connection.removeEventListener(NetStatusEvent.NET_STATUS, _onConnexionError);
			_connection.removeEventListener(IOErrorEvent.IO_ERROR, _onConnexionError);
			_connection.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, _onConnexionError);
			_connection.removeEventListener(AsyncErrorEvent.ASYNC_ERROR, _onConnexionError);
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

		public function get connection() : URLLoader
		{
			return _connection;
		}
	}
}