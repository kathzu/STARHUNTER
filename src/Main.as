package 
{
	import org.flixel.*;
	import pl.starhunter.*;
	
	/**
	 * ...
	 * @author Kamil Lysy
	 */
	[SWF(width = "1024", height = "768", backgroundColor = "#000000")]
	[Frame(factoryClass="Preloader")]
	 
	public class Main extends FlxGame
	{
		public function Main():void 
		{
		super(512, 384, PlayState, 2);
		}		
	}	
}