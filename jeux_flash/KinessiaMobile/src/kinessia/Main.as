package kinessia {

	import net.user1.reactor.Reactor;
	import net.user1.reactor.Room;

	import flash.display.Sprite;
	import flash.events.AccelerometerEvent;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.sensors.Accelerometer;
	import flash.utils.Timer;

	/**
	 * @author Aymeric
	 */
	public class Main extends Sprite {

		private var _reactor:Reactor = new Reactor();
		private var _room:Room;

		private var _accelX:Number, _accelY:Number;

		private var _fl_Accelerometer:Accelerometer;

		private var _currentHStatus:String, _currentVStatus:String;

		public function Main() {

			_reactor.connect("169.254.166.254", 9110);

			var timer:Timer = new Timer(3000, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, _connexionRoom);
			timer.start();
		}

		private function _connexionRoom(tEvt:TimerEvent):void {

			_room = _reactor.getRoomManager().joinRoom("Kinessia");

			_fl_Accelerometer = new Accelerometer();

			_fl_Accelerometer.addEventListener(AccelerometerEvent.UPDATE, _fl_AccelerometerUpdateHandler);

			this.addEventListener(Event.ENTER_FRAME, _ef);
		}

		private function _fl_AccelerometerUpdateHandler(aEvt:AccelerometerEvent):void {

			_accelX = aEvt.accelerationX;
			_accelY = aEvt.accelerationY;
		}

		protected function _ef(evt:Event):void {

			if ((_accelX > 0.7) && (_currentVStatus != "onground")) {
				_room.sendMessage("CHAT_MESSAGE", true, null, "onground");
				_currentVStatus = "onground";
			}

			if ((_accelX < -0.7) && (_currentVStatus != "jump")) {
				_room.sendMessage("CHAT_MESSAGE", true, null, "jump");
				_currentVStatus = "jump";
			}

			if ((_accelY > 0.7) && (_currentHStatus != "right")) {
				_room.sendMessage("CHAT_MESSAGE", true, null, "right");
				_currentHStatus = "right";
			}

			if ((_accelY < -0.7) && (_currentHStatus != "left")) {
				_room.sendMessage("CHAT_MESSAGE", true, null, "left");
				_currentHStatus = "left";
			}

			if (((_accelY < 0.7) && (_accelY > -0.7)) && (_currentHStatus != "immobile")) {
				_room.sendMessage("CHAT_MESSAGE", true, null, "immobile");
				_currentHStatus = "immobile";
			}

		}
	}
}