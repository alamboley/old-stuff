package {

	import citrus.core.starling.StarlingCitrusEngine;

	import levels.Level1;

	import objects.Hills;

	import starling.core.Starling;
	import starling.events.Event;
	import starling.utils.AssetManager;

	//import flash.filesystem.File;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	[SWF(backgroundColor="#000000", frameRate="60", width="1024", height="768")]

	/**
	 * @author Aymeric
	 */
	public class Main extends StarlingCitrusEngine {

		static public var assets:AssetManager;

		public function Main() {
			super();
			
			Starling.multitouchEnabled = true;
			
			setUpStarling(true);
		}

		override protected function _context3DCreated(evt:Event):void {
			super._context3DCreated(evt);

			assets = new AssetManager();

			//var appDir:File = File.applicationDirectory;

			// appDir.resolvePath(formatString("textures/{0}x", scaleFactor))
			/*assets.enqueue(appDir.resolvePath("assets/1x"));

			assets.loadQueue(function(ratio:Number):void {
				trace("Loading assets, progress:", ratio);

				if (ratio == 1.0) {
					state = new GameState();
				}
			});*/
			
			 loadXMLFile("level.xml");
		}
		
		private function loadXMLFile(level:String):void
		{
			
			var loader:URLLoader = new URLLoader(new URLRequest(level));
			loader.addEventListener(Event.COMPLETE, levelLOADED);
		}
				
		private function levelLOADED(e:Object):void
		{
			var _xml:XML;
			e.target.removeEventListener(Event.COMPLETE, levelLOADED);
			_xml = XML(e.currentTarget.data);
			
			var base:String = _xml.base.path;
			Hills._pointsY = base.split(',');
			
			//GameVARS.LevelWidth = Hills._pointsY.length;
			
			state = new Level1();
		}

	}
}
