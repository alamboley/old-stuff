package afp.services.vo
{
	/**
	 * @author lbineau
	 */
	public class AbstractVo
	{
		public function AbstractVo(initObj : Object)
		{
			// initialize properties from the value object.
			for (var i:String in initObj)
			{
				this[i] = initObj[i];
			}
		}
	}
}
