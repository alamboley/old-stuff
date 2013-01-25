package {

	import citrus.core.starling.StarlingCitrusEngine;

	import levels.Level1;

	import starling.events.Event;
	import starling.utils.AssetManager;

	import flash.filesystem.File;

	[SWF(backgroundColor="#000000", frameRate="60", width="1024", height="768")]

	/**
	 * @author Aymeric
	 */
	public class Main extends StarlingCitrusEngine {

		static public var assets:AssetManager;

		public function Main() {
			super();

			setUpStarling(true);
		}

		override protected function _context3DCreated(evt:Event):void {
			super._context3DCreated(evt);

			assets = new AssetManager();

			var appDir:File = File.applicationDirectory;

			// appDir.resolvePath(formatString("textures/{0}x", scaleFactor))
			/*assets.enqueue(appDir.resolvePath("assets/1x"));

			assets.loadQueue(function(ratio:Number):void {
				trace("Loading assets, progress:", ratio);

				if (ratio == 1.0) {
					state = new GameState();
				}
			});*/

			state = new Level1();
		}

	}
}
