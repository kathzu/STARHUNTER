package pl.starhunter 
{
	/**
	 * ...
	 * @author Kamil Lysy
	 */
	
	import org.flixel.*;
	
	
	
	public class Bullet extends FlxSprite 
	{
		[Embed(source = "../../../lib/assets/png/Bullet0.png")]
		private var ImgBullet0:Class;
		
		public function Bullet(x:Number,y:Number,bulletType:Number):void 
		{
			super(x, y,ImgBullet0);
			velocity.y = -500;
		}
		
	}

}