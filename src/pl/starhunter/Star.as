package pl.starhunter 
{
	/**
	 * ...
	 * @author Kamil Lysy
	 */
	import org.flixel.*;
	public class Star extends FlxSprite
	{
		public function Star(x:Number,y:Number,color:uint):void
		{
			super(x, y);
			createGraphic(2, 2, color);
		}
		
	}

}