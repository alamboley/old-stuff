package afp.pages
{

	/**
	 * @author lbineau
	 */
	public class PageDeBase extends APage
	{
		public function PageDeBase()
		{
			super();
			graphics.beginFill(0xff0000);
			graphics.drawRect(0, 0, 100, 100);
			graphics.endFill();
		}
	}
}
