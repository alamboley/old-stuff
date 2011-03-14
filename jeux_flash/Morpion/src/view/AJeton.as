package view {

	import flash.display.Shape;
	import flash.display.Sprite;

	/**
	 * @author Aymeric
	 */
	public class AJeton extends Sprite {

		protected var jeton:Shape;
		
		private var _type:String;

		public function AJeton() {

		}
		
		public function get type():String {
			return _type;
		}
		
		public function set type(valeur:String):void {
			_type = valeur;
		}

	}
}
