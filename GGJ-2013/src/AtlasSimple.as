package
{
	import flash.display.Bitmap;
	import flash.media.Sound;
	import flash.net.getClassByAlias;
	import flash.text.TextRenderer;
	import flash.utils.Dictionary;
	import starling.text.BitmapFont;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import flash.display.BlendMode;
	import flash.utils.ByteArray
	import starling.display.Image;
	
	
	/**
	 * ...
	 * @author 3wg
	 */
	public class AtlasSimple
	{
		
		private static var sTextures:Dictionary = new Dictionary();
		private static var sTextureAtlas:TextureAtlas;
		
		
		
		public function AtlasSimple()
		{
		
		}
		
		private static var FontAtlas:BitmapFont;
		[Embed(source = "../embed/police7_0.png")]

		private static const BitmapFontChars:Class;
		[Embed(source = "../embed/police7.fnt", mimeType = "application/octet-stream")]
		private static const BitmapFontXML:Class;
	
		
		[Embed(source = "../embed/sol.png")] public static const TheTexture:Class;
			
			
		[Embed(source = "../embed/sol.xml", mimeType = "application/octet-stream")] public static const AtlasXml:Class;
	
	//	[Embed(source = "../embed/bg-bleu.jpg")] public static const BgPIC:Class;
	
		
		
		
		public static function getFontAtlas():BitmapFont
		{
			if (FontAtlas == null)
			{
				//var bitmap:Bitmap = new BitmapFontChars();
				var texture:Texture = getFontTexture("BitmapFontChars");
				
				var xml:XML = XML(new BitmapFontXML());
				FontAtlas = new BitmapFont(texture, xml);
				
			}
			
			return FontAtlas;
		}
		
		/**
		 * Returns a texture from a texture atlas based on a string key.
		 *
		 * @param name A key that matches a static constant of Bitmap type.
		 * @return a starling texture.
		 */
		public static function getFontTexture(name:String):Texture
		{
			if (sTextures[name] == undefined)
			{
				/*
				   var textureAsset:ByteArray = new BitmapFontChars() as ByteArray;
				   sTextures[name] = Texture.fromAtfData(textureAsset, 1);
				 */
				
				var bitmap:Bitmap = new AtlasSimple[name]();
				sTextures[name] = Texture.fromBitmap(bitmap, false);
				
					//bitmap.blendMode = BlendMode.NORMAL;
					//bitmap.bitmapData.dispose();
			}
			
			return sTextures[name];
		}
		
		
				
		public static function getAtlas():TextureAtlas
		{
			//trace ("getAtlas");
			if (sTextureAtlas == null)
			{
		/*
				var texture:Texture = Texture.fromBitmap(new TheTexture());
				var xml:XML=XML(new AtlasXml());
				
				sTextureAtlas = new TextureAtlas(texture, xml);
		//		trace (sTextureAtlas.getTextures().length,xml);
		*/
				var texture:Texture=getTexture("TheTexture");
				var xml:XML=XML(new AtlasXml());
				sTextureAtlas=new TextureAtlas(texture, xml);
		
		
			}

			return sTextureAtlas;
		}
		
		
				/**
		 * Returns a texture from a texture atlas based on a string key.
		 * 
		 * @param name A key that matches a static constant of Bitmap type.
		 * @return a starling texture.
		 */
		public static function getTexture(name:String):Texture
		{
			if (sTextures[name] == undefined)
			{
				/*
				var textureAsset:ByteArray = new TheTexture() as ByteArray;
				sTextures[name] = Texture.fromAtfData(textureAsset, 1);
				*/
				var bitmap:Bitmap=new AtlasSimple[name]();
				sTextures[name] = Texture.fromBitmap(bitmap, false);
				
				//bitmap.blendMode = BlendMode.NORMAL;
				//bitmap.bitmapData.dispose();
			}

			return sTextures[name];
		}
		
		
		
	
	}

}