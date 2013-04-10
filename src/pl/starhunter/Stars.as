package pl.starhunter 
{
	/**
	 * ...
	 * @author Kamil Lysy
	 */
	import mx.core.FlexSprite;
	import org.flixel.*;
	
	public class Stars extends FlxGroup
	{
		public static const _nubStars:Number = 75;
		private var _angle:Number;
		private var _star:Star;
		
		public function Stars(ang:Number = 90,speedMultiplier:Number=4):void 
		{
			super();
			
			_angle = ang;
			
			var radang:Number = ang * Math.PI / 180;
			var cosang:Number = Math.cos(radang);
			var sinang:Number = Math.sin(radang);
			
			for (var i:int = 0; i < _nubStars; i++ ) {
				var vel:Number = Math.random() * - 16 * speedMultiplier;
				var transp:uint = (Math.round(16 * ( -vel / speedMultiplier) - 1) << 24);
				
				_star = new Star(Math.random() * FlxG.width, Math.random() * FlxG.height,0x00FFFFFF | transp);
				add(_star);
			}
		}
		
		
		
		override public function update():void 
		{
				super.update();
				
				for each(var star:FlxSprite in members)
				{
					if (star.x > FlxG.width){
						star.x = 0;
					}else if (star.x < 0) {
						star.x = FlxG.width;						
					}
					
					if (star.y > FlxG.height) {
						star.y=0;
					}else if (star.y < 0) {
						star.y = FlxG.height;
					}
				}
		}
	}

}