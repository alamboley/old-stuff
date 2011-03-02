package pages.son {

	import pages.Pages;
	import com.gaiaframework.api.Gaia;
	import com.gaiaframework.api.ISound;
	import com.gaiaframework.utils.SoundGroup;
	
	/**
	 * @author Aymeric
	 */
	 
	public class PlaylistSon {
		
		private static const _MAX_SON:uint = 5;
		
		private static var _playlistSon:Array;
		private static var _soundGroup:SoundGroup;
		private static var _son1:ISound, _son2:ISound, _son3:ISound, _son4:ISound;
		
		public function PlaylistSon() {
			
		}
		
		public static function init():void {
			
			_son1 = (Math.random() > 0.5) ? Gaia.api.getPage(Pages.JEU).assets.myMusic1 : Gaia.api.getPage(Pages.JEU).assets.myMusic1;
			_son2 = (Math.random() > 0.5) ? Gaia.api.getPage(Pages.JEU).assets.myMusic2 : Gaia.api.getPage(Pages.JEU).assets.myMusic2;
			_son3 = (Math.random() > 0.5) ? Gaia.api.getPage(Pages.JEU).assets.myMusic3 : Gaia.api.getPage(Pages.JEU).assets.myMusic3;
			_son4 = (Math.random() > 0.5) ? Gaia.api.getPage(Pages.JEU).assets.myMusic4 : Gaia.api.getPage(Pages.JEU).assets.myMusic4;
			
			_soundGroup = new SoundGroup();
			
			_playlistSon = [];
			
			for (var i:uint; i < _MAX_SON; ++i) {
				
				switch (uint(Math.random() * 4 + 1)) {
					
					case 1:
						_playlistSon.push(["myMusic1", 1, 1]);
						_soundGroup.addSound(ISound(_son1));
					break;
					
					case 2:
						_playlistSon.push(["myMusic2", 2, 1]);
						_soundGroup.addSound(ISound(_son2));
					break;
					
					case 3:
						_playlistSon.push(["myMusic3", 3, 2]);
						_soundGroup.addSound(ISound(_son3));
					break;
					
					case 4:
						_playlistSon.push(["myMusic4", 4, 3]);
						_soundGroup.addSound(ISound(_son4));
					break;
				}
			}
		}
		
		public static function getPlaylist():Array {
			
			return _playlistSon;
		}
		
		public static function getSoundGroup():SoundGroup {
			
			return _soundGroup;
		}
		
		public static function getMySound($son:String):ISound {
			
			switch ($son) {
				
				case "myMusic1":
					return _son1;
					break;
					
				case "myMusic2":
					return _son2;
					break;
				
				case "myMusic3":
					return _son3;
					break;
					
				case "myMusic4":
					return _son4;
					break;
			}
			
			return null;
		}
	}
}
