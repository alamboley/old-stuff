package afp.services.vo
{
	/**
	 * @author lbineau
	 */
	public final class UserVO extends AbstractVo
	{
		private var _id : String;
		private var _nom : String;
		private var _prenom : String;

		public function UserVO(initObj : Object) : void
		{
			super(initObj);
		}

		public function get id() : String
		{
			return this._id;
		}

		public function get nom() : String
		{
			return this._nom;
		}

		public function get prenom() : String
		{
			return this._prenom;
		}

		public function set id(id : String) : void
		{
			_id = id;
		}

		public function set nom(nom : String) : void
		{
			_nom = nom;
		}

		public function set prenom(prenom : String) : void
		{
			_prenom = prenom;
		}
	}
}