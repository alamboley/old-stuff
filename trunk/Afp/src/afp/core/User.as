package afp.core
{
	/**
	 * @author lbineau
	 */
	public final class User
	{
		private static var instance : User = new User();
		private var _id : String;
		private var _nom : String;
		private var _prenom : String;

		public function User()
		{
			if ( instance ) throw new Error("Singleton and can only be accessed through Singleton.getInstance()");
		}

		public static function getInstance() : User
		{
			return instance;
		}

		public function get id() : String
		{
			return _id;
		}

		public function set id(id : String) : void
		{
			_id = id;
		}

		public function get nom() : String
		{
			return _nom;
		}

		public function set nom(nom : String) : void
		{
			_nom = nom;
		}

		public function get prenom() : String
		{
			return _prenom;
		}

		public function set prenom(prenom : String) : void
		{
			_prenom = prenom;
		}
	}
}
