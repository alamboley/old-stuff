package objects 
{
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.utils.Dictionary;
	import starling.animation.IAnimatable;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.display.BlendMode;

	public class Lucioles extends Sprite implements IAnimatable
	{
		
		public var radius : Number = 120;
		
		private var _lucioleText:Texture;
		private var _lucioles:Vector.<Object>;
		
		private var _initialized:Boolean = false;
		
		public function Lucioles() 
		{
			super();
			
			_lucioles = new Vector.<Object>();
			touchable = false;
			
			gen();
		}
		
		private function gen():void
		{
			var s:Shape = new Shape();
			s.graphics.beginFill(0x97FDE6);
			s.graphics.drawCircle(2, 2, 2);
			var b:BitmapData = new BitmapData(20, 20, true, 0x00000000);
			b.draw(s);
			
			_lucioleText = Texture.fromBitmapData(b);
			
			var i:uint = 0;
			var img:Image;
			var p:Number;
			for (i = 0; i < 30; i++)
			{
				img = new Image(_lucioleText);
				img.alpha = Math.random();
				p = Math.random() * 100;
				img.x = Math.random() * radius - radius/2;
				img.y = Math.random() * radius - radius/2;
				_lucioles.push({l:img,phase:p});
				addChild(img);
			}
		}
		
		private var lo:Object = { };
		private var ti:Image;
		public function advanceTime(passedTime:Number):void
		{
			for each(lo in _lucioles)
			{
				ti = (lo.l as Image);
				ti.x += Math.random()*2 - 1;
				ti.y += Math.random() * 2 - 1;
				ti.alpha =  Math.cos(lo.phase/5)*0.5+0.5;
				lo.phase ++;
			}
		}
		
	}

}