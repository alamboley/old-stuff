package kinessia.network {

	import flash.display.Sprite;
	import net.user1.reactor.Reactor;
	import net.user1.reactor.Room;

	import flash.events.AccelerometerEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.sensors.Accelerometer;
	import flash.utils.Timer;

	/**
	 * @author Aymeric
	 */
	public class Network extends Sprite {

		private var _reactor:Reactor;
		private var _room:Room;

		private var _accelX:Number, _accelY:Number;

		private var _accelerometer:Accelerometer;

		private var _currentHStatus:String, _currentVStatus:String;
		
		private var _uniqueID:String;

		public function Network() {
			
			_reactor  = new Reactor();
			//_reactor.connect("169.254.170.39", 9110);
			//_reactor.connect("localhost", 9110);
			_reactor.connect("tryunion.com", 80);
			
			_uniqueID = "CHAT_MESSAGE";

			var timer:Timer = new Timer(5000, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, _connexionRoom);
			timer.start();
		}

		private function _connexionRoom(tEvt:TimerEvent):void {

			_room = _reactor.getRoomManager().joinRoom("Kinessia");

			_accelerometer = new Accelerometer();

			_accelerometer.addEventListener(AccelerometerEvent.UPDATE, _accelerometerHandler);
			
			this.addEventListener(Event.ENTER_FRAME, _ef);
			//_room.sendMessage(_uniqueID, true, null, "right");
		}

		private function _accelerometerHandler(aEvt:AccelerometerEvent):void {

			_accelX = aEvt.accelerationX;
			_accelY = aEvt.accelerationY;
		}

		private function _ef(evt:Event):void {

			if ((_accelX > 0.7) && (_currentVStatus != "onground")) {
				_room.sendMessage(_uniqueID, true, null, "onground");
				_currentVStatus = "onground";
			}

			if ((_accelX < -0.7) && (_currentVStatus != "jump")) {
				_room.sendMessage(_uniqueID, true, null, "jump");
				_currentVStatus = "jump";
			}

			if ((_accelY > 0.7) && (_currentHStatus != "right")) {
				_room.sendMessage(_uniqueID, true, null, "right");
				_currentHStatus = "right";
			}

			if ((_accelY < -0.7) && (_currentHStatus != "left")) {
				_room.sendMessage(_uniqueID, true, null, "left");
				_currentHStatus = "left";
			}

			if (((_accelY < 0.7) && (_accelY > -0.7)) && (_currentHStatus != "immobile")) {
				_room.sendMessage(_uniqueID, true, null, "immobile");
				_currentHStatus = "immobile";
			}

		}

		public function set uniqueID(uniqueID:String):void {
			_uniqueID = uniqueID;
		}
	}
}