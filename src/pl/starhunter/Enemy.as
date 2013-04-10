package pl.starhunter 
{
	/**
	 * ...
	 * @author Kamil Lysy
	 */
	import org.flixel.*;
	 
	public class Enemy extends FlxSprite
	{
	[Embed(source = "../../../lib/assets/png/EnemyShip1.png")]
	private var ImgEnemy0:Class;
	[Embed(source = "../../../lib/assets/png/EnemyShip2.png")]
	private var ImgEnemy1:Class;
		
		public function Enemy(x:Number,y:Number,e:Number):void 
		{
			
			super(x, y, whatEnemy(e));
			velocity.y = 100;
		}
		override public function update():void
		{
			velocity.x = Math.cos(y / 30) * 30;
			super.update();
		}
		
		//DO WYRZUCENIA CO 20 WYSKAKUJE INNY SPRITE
		public function whatEnemy(e:Number):Class {
			var What:Class;
			if (e == 20) {
				What = ImgEnemy0;
			}else {
				What = ImgEnemy1;
			}
			return What;
		}
	}

}