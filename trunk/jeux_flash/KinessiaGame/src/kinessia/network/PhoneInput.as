package kinessia.network {

	import kinessia.network.NetworkEvent;

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
				
			} else {
				
				ce.removeEventListener(NetworkEvent.JUMP, _onPhoneJump);
				ce.removeEventListener(NetworkEvent.ONGROUND, _onPhoneJump);
				ce.removeEventListener(NetworkEvent.LEFT, _onPhoneDirection);
				ce.removeEventListener(NetworkEvent.RIGHT, _onPhoneDirection);
				ce.removeEventListener(NetworkEvent.IMMOBILE, _onPhoneDirection);
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
	}
}
