package pl.starhunter 
{
	/**
	 * ...
	 * @author Kamil Lysy
	 */
	
	 import org.flixel.*; 
	 
	public class Ship extends FlxSprite
	{
	[Embed(source = "../../../lib/assets/png/SpaceShip1.png")]
	private var _ImgShip:Class;
		
	
	private var _shipSpeed:Number = 250;
	
		public function Ship():void 
		{
			super( (FlxG.width*0.5)-16 ,(FlxG.height*0.9),_ImgShip);
		}
		override public function update():void
		{
			velocity.x = 0;
			velocity.y = 0;
		
			
		if(FlxG.keys.LEFT){
		velocity.x = - _shipSpeed;	
		}else if(FlxG.keys.RIGHT){
		velocity.x = _shipSpeed;
		}
		if (FlxG.keys.UP) {
		velocity.y = - _shipSpeed;	
		}else if (FlxG.keys.DOWN) {
		velocity.y = _shipSpeed;	
		}
		
		
		super.update();
		
		//NIE WYJEZDZA ZA LINIE 
		if (x > FlxG.width - width - 8) {
			x = FlxG.width - width - 8;
		}else if (x < 8) {
			x = 8;
		}
		if (y > FlxG.height - height - 8) {
			y = FlxG.height - height - 8;
		}else if (y < 32) {
			y = 32;
		}
		
		}
		public function getBulletSpawnPosition():FlxPoint {
			var p:FlxPoint = new FlxPoint(x + 15, y);
			return p;
		}
	}
}