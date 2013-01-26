package {

	import citrus.core.starling.StarlingCitrusEngine;

	import levels.Level1;

	import objects.Hills;

	import starling.core.Starling;
	import starling.events.Event;
	import starling.utils.AssetManager;

	import flash.geom.Rectangle;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	// import flash.filesystem.File;

	[SWF(backgroundColor="#000000", frameRate="60", width="1024", height="768")]

	/**
	 * @author Aymeric
	 */
	public class Main extends StarlingCitrusEngine {

		static public var assets:AssetManager;

		public function Main() {
			super();
			
			Starling.multitouchEnabled = true;
			Starling.handleLostContext = true;
			
			setUpStarling(true, 0, new Rectangle(0, 0, stage.fullScreenWidth, stage.fullScreenHeight));
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
			
			
			GameVars.LevelWidth = Hills._pointsY.length;
			 
			var lastY:Number = Hills._pointsY[Hills._pointsY.length-1];
			
			
			for (var i:int = 0; i < 120; i++) {
				Hills._pointsY.push(lastY);
			}
			
			for each (var obj:XML in _xml.objects)
			{
				var px:Number = obj.posx;
				var py:Number = obj.posy;
				var pt:String = obj.obj;
				//	trace("Je vais creer un " + pt);
				GameVars.Props.push(new Array(px,py,"props"+pt));
			}
			
			state = new Level1();
		}

	}
}
