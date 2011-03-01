package pages.son {

	import pages.Pages;
	import com.gaiaframework.api.Gaia;
	import com.gaiaframework.api.ISound;
	import com.gaiaframework.utils.SoundGroup;
	
	/**
	 * @author Aymeric
	 */
	 
	public class PlaylistSon {
		
		private static const _MAX_SON:uint = 15;
		
		private static var _playlistSon:Array;
		private static var _soundGroup:SoundGroup;
		
		public function PlaylistSon() {
			
		}
		
		public static function init():void {
			
			var son1:ISound = (Math.random() > 0.5) ? Gaia.api.getPage(Pages.JEU).assets.myMusic1 : Gaia.api.getPage(Pages.JEU).assets.myMusic1;
			var son2:ISound = (Math.random() > 0.5) ? Gaia.api.getPage(Pages.JEU).assets.myMusic2 : Gaia.api.getPage(Pages.JEU).assets.myMusic2;
			var son3:ISound = (Math.random() > 0.5) ? Gaia.api.getPage(Pages.JEU).assets.myMusic3 : Gaia.api.getPage(Pages.JEU).assets.myMusic3;
			var son4:ISound = (Math.random() > 0.5) ? Gaia.api.getPage(Pages.JEU).assets.myMusic4 : Gaia.api.getPage(Pages.JEU).assets.myMusic4;
			
			_soundGroup = new SoundGroup();
			
			_playlistSon = [];
			
			for (var i:uint; i < _MAX_SON; ++i) {
				
				switch (uint(Math.random() * 4 + 1)) {
					
					case 1:
						_playlistSon.push(["myMusic1", 1, 1]);
						_soundGroup.addSound(ISound(son1));
					break;
					
					case 2:
						_playlistSon.push(["myMusic2", 2, 1]);
						_soundGroup.addSound(ISound(son2));
					break;
					
					case 3:
						_playlistSon.push(["myMusic3", 3, 2]);
						_soundGroup.addSound(ISound(son3));
					break;
					
					case 4:
						_playlistSon.push(["myMusic4", 4, 3]);
						_soundGroup.addSound(ISound(son4));
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
	}
}
