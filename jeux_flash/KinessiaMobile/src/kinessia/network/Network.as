package kinessia.network {

	import kinessia.art.ArtEvent;

	import net.user1.reactor.IClient;
	import net.user1.reactor.Reactor;
	import net.user1.reactor.ReactorEvent;
	import net.user1.reactor.Room;

	import com.greensock.TweenMax;

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.AccelerometerEvent;
	import flash.events.Event;
	import flash.events.TouchEvent;
	import flash.sensors.Accelerometer;

	/**
	 * @author Aymeric
	 */
	public class Network extends Sprite {

		private var _reactor:Reactor;
		private var _room:Room;
		
		private var _home:MovieClip;

		private var _accelX:Number, _accelY:Number;

		private var _accelerometer:Accelerometer;

		private var _currentHStatus:String, _currentVStatus:String;
		
		private var _uniqueID:String;

		public function Network(home:MovieClip) {
			
			_reactor  = new Reactor();
			_reactor.connect("169.254.59.137", 9110);
			//_reactor.connect("localhost", 9110);
			//_reactor.connect("tryunion.com", 80);
			
			_home = home;
			
			_reactor.addEventListener(ReactorEvent.READY, _connexionRoom);
		}

		private function _connexionRoom(rEvt:ReactorEvent):void {

			_room = _reactor.getRoomManager().joinRoom("Kinessia");
			
			TweenMax.to(_home, 0.3, {alpha:0, onComplete:function():void{_home.gotoAndStop("login");}});
			TweenMax.to(_home, 0.3, {alpha:1, delay:0.3, onComplete:function():void {_home.login_btn.addEventListener(TouchEvent.TOUCH_TAP, _connectedToRoom);}});

			_accelerometer = new Accelerometer();

			_accelerometer.addEventListener(AccelerometerEvent.UPDATE, _accelerometerHandler);
			
			this.addEventListener(Event.ENTER_FRAME, _ef);
		}

		private function _connectedToRoom(tEvt:TouchEvent):void {
			
			_uniqueID = _home.login_txt.text;
			_room.addMessageListener(_uniqueID, _messageFromGame);
			
			_home.login_btn.removeEventListener(TouchEvent.TOUCH_TAP, _connectedToRoom);
			
			this.dispatchEvent(new ArtEvent(ArtEvent.REMOVE_HOME));
		}
		
		private function _messageFromGame(fromClient:IClient, message:String):void {
			
			trace("iPhone reçoit : " + message);
			
			this.dispatchEvent(new NetworkEvent(message));
		}

		private function _accelerometerHandler(aEvt:AccelerometerEvent):void {

			_accelX = aEvt.accelerationX;
			_accelY = aEvt.accelerationY;
		}

		private function _ef(evt:Event):void {

			if ((_accelX > 0.7) && (_currentVStatus != "onground")) {
				_room.sendMessage(_uniqueID, true, null, NetworkEvent.ONGROUND);
				_currentVStatus = "onground";
			}

			if ((_accelX < -0.7) && (_currentVStatus != "jump")) {
				_room.sendMessage(_uniqueID, true, null, NetworkEvent.JUMP);
				_currentVStatus = "jump";
			}
			
			if (((_accelX < 0.7) && (_accelX > -0.7)) && (_currentVStatus != "stationary")) {
				_room.sendMessage(_uniqueID, true, null, NetworkEvent.STATIONARY);
				_currentVStatus = "stationary";
			}

			if ((_accelY > 0.7) && (_currentHStatus != "right")) {
				_room.sendMessage(_uniqueID, true, null, NetworkEvent.RIGHT);
				_currentHStatus = "right";
			}

			if ((_accelY < -0.7) && (_currentHStatus != "left")) {
				_room.sendMessage(_uniqueID, true, null, NetworkEvent.LEFT);
				_currentHStatus = "left";
			}

			if (((_accelY < 0.7) && (_accelY > -0.7)) && (_currentHStatus != "immobile")) {
				_room.sendMessage(_uniqueID, true, null, NetworkEvent.IMMOBILE);
				_currentHStatus = "immobile";
			}

		}
		
		public function drawCircleForCatapulte():void {
			_room.sendMessage(_uniqueID, true, null, NetworkEvent.CIRCLE_DRAW);
		}
		
		public function pauseGame(tEvt:TouchEvent):void {
			_room.sendMessage(_uniqueID, true, null, NetworkEvent.PAUSE_GAME);
		}
	}
}