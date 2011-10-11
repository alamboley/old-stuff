package afp.services.vo {

	/**
	 * @author Aymeric
	 */
	public class EventVO extends AbstractVO {

		private var _id:String;
		private var _nom:String;
		private var _description:String;

		public function EventVO(initObj:Object) {

			super(initObj);
		}

		public function get id():String {
			return _id;
		}

		public function get nom():String {
			return _nom;
		}

		public function get description():String {
			return _description;
		}

		public function set id(id:String):void {
			_id = id;
		}

		public function set nom(nom:String):void {
			_nom = nom;
		}

		public function set description(description:String):void {
			_description = description;
		}
	}
}
