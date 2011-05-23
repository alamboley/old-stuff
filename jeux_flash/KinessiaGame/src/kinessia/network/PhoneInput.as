package kinessia.network {

	import com.citrusengine.core.CitrusEngine;
	import com.citrusengine.core.Input;

	/**
	 * @author Aymeric
	 */
	public class PhoneInput extends Input {

		private var _enabled:Boolean = true;

		private var _phoneJump:Boolean;
		private var _firstJump:Boolean;
		private var _phoneDirection:String;
		private var _fly:Boolean;

		public function PhoneInput() {
			super();
		}

		override public function set enabled(value:Boolean):void {
			
			super.enabled = value;

			var ce:CitrusEngine = CitrusEngine.getInstance();
			
			if (_enabled) {
				
				ce.addEventListener(NetworkEvent.JUMP, _onPhoneJump);
				ce.addEventListener(NetworkEvent.ONGROUND, _onPhoneJump);
				
				ce.addEventListener(NetworkEvent.LEFT, _onPhoneDirection);
				ce.addEventListener(NetworkEvent.RIGHT, _onPhoneDirection);
				ce.addEventListener(NetworkEvent.IMMOBILE, _onPhoneDirection);
				
				ce.addEventListener(NetworkEvent.FLY, _onMicroFly);
				ce.addEventListener(NetworkEvent.NOT_FLY, _onMicroFly);
				
			} else {
				
				ce.removeEventListener(NetworkEvent.JUMP, _onPhoneJump);
				ce.removeEventListener(NetworkEvent.ONGROUND, _onPhoneJump);
				
				ce.removeEventListener(NetworkEvent.LEFT, _onPhoneDirection);
				ce.removeEventListener(NetworkEvent.RIGHT, _onPhoneDirection);
				ce.removeEventListener(NetworkEvent.IMMOBILE, _onPhoneDirection);
				
				ce.removeEventListener(NetworkEvent.FLY, _onMicroFly);
				ce.removeEventListener(NetworkEvent.NOT_FLY, _onMicroFly);
			}
		}

		override public function initialize():void {
			
			super.initialize();

			var ce:CitrusEngine = CitrusEngine.getInstance();
			
			ce.addEventListener(NetworkEvent.JUMP, _onPhoneJump);
			ce.addEventListener(NetworkEvent.ONGROUND, _onPhoneJump);
			
			ce.addEventListener(NetworkEvent.LEFT, _onPhoneDirection);
			ce.addEventListener(NetworkEvent.RIGHT, _onPhoneDirection);
			ce.addEventListener(NetworkEvent.IMMOBILE, _onPhoneDirection);
			
			ce.addEventListener(NetworkEvent.FLY, _onMicroFly);
			ce.addEventListener(NetworkEvent.NOT_FLY, _onMicroFly);
		}
		
		public function justJumped():Boolean {
			
			if (_phoneJump == true) {
				
				if (_firstJump == true) {
					_firstJump = false;
					return true;
				}
			}
			
			return false;
		}

		public function get phoneJump():Boolean {
			return _phoneJump;
		}

		public function get phoneDirecton():String {
			return _phoneDirection;
		}
		
		public function get phoneMicroFly():Boolean {
			return _fly;
		}

		private function _onPhoneJump(nEvt:NetworkEvent):void {

			if (nEvt.type == "JUMP") {
				_phoneJump = _firstJump = true;
			} else {
				_phoneJump = _firstJump = false;
			}
		}

		private function _onPhoneDirection(nEvt:NetworkEvent):void {

			switch (nEvt.type) {

				case "LEFT":
					_phoneDirection = "left";
					break;

				case "RIGHT":
					_phoneDirection = "right";
					break;

				case "IMMOBILE":
					_phoneDirection = "immobile";
					break;
			}
		}
		
		private function _onMicroFly(nEvt:NetworkEvent):void {

			switch (nEvt.type) {
				
				case "FLY":
					_fly = true;
					break;
				
				case "NOT_FLY":
					_fly = false;
					break;
			}
		}
	}
}
