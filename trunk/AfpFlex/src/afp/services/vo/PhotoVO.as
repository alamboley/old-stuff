package afp.services.vo
{
	import afp.services.vo.AbstractVO;

	/**
	 * @author lbineau
	 */
	public class PhotoVO extends AbstractVO
	{
		private var _id : String;
		private var _prenom:String;
		private var _dateprise : String;
		private var _url : String;
		private var _etat : String;
		private var _idevent : String;
		private var _iduser : String;
		private var _geoloc:String;
		private var _place:String;
		private var _description : String;

		public function PhotoVO(initObj : Object)
		{
			super(initObj);
		}

		public function get id() : String
		{
			return _id;
		}

		public function set id(id : String) : void
		{
			_id = id;
		}

		public function get description() : String
		{
			return _description;
		}

		public function set description(description : String) : void
		{
			_description = description;
		}

		public function get dateprise() : String
		{
			return _dateprise;
		}

		public function set dateprise(dateprise : String) : void
		{
			_dateprise = dateprise;
		}

		public function get url() : String
		{
			return _url;
		}

		public function set url(url : String) : void
		{
			_url = url;
		}

		public function get etat() : String
		{
			return _etat;
		}

		public function set etat(etat : String) : void
		{
			_etat = etat;
		}

		public function get idevent() : String
		{
			return _idevent;
		}

		public function set idevent(idevent : String) : void
		{
			_idevent = idevent;
		}

		public function get iduser() : String
		{
			return _iduser;
		}

		public function set iduser(iduser : String) : void
		{
			_iduser = iduser;
		}

		public function get geoloc():String {
			return _geoloc;
		}

		public function set geoloc(geoloc:String):void {
			_geoloc = geoloc;
		}

		public function get prenom():String {
			return _prenom;
		}

		public function set prenom(prenom:String):void {
			_prenom = prenom;
		}

		public function get place():String {
			return _place;
		}

		public function set place(place:String):void {
			_place = place;
		}
	}
}
