package afp.services.vo
{
	/**
	 * @author lbineau
	 */
	public final class UserVO
	{
		private var _id : uint;
		private var _nom : String;
		private var _prenom : String;

		public function UserVO(id : uint = 0, nom : String = null, prenom : String = null) : void
		{
			this._id = id;
			this._nom = nom;
			this._prenom = prenom;
		}

		public function get id() : uint
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
	}
}