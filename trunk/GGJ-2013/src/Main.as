package {

	import levels.Level1;
	import citrus.core.starling.StarlingCitrusEngine;

	[SWF(backgroundColor="#000000", frameRate="60", width="1024", height="768")]

	/**
	 * @author Aymeric
	 */
	public class Main extends StarlingCitrusEngine {

		public function Main() {
			super();
			
			setUpStarling(true);

			state = new Level1();
		}
	}
}
