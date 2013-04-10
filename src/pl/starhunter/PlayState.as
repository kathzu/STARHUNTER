package pl.starhunter 
{
	/**
	 * ...
	 * @author Kamil Lysy
	 */
	
	
	import org.flixel.*;
	
	public class PlayState extends FlxState
	{
		[Embed(source = "../../../lib/assets/mp3/ExplosionShip.mp3")] private var SoundExplosionShip:Class;
		[Embed(source = "../../../lib/assets/mp3/ExplosionAlien.mp3")] private var SoundExplosionEnemy:Class;
		[Embed(source = "../../../lib/assets/mp3/Bullet.mp3")] private var SoundBullet:Class;
		
		private var _ship: Ship;
		private var _enemies: FlxGroup;
		private var _bullets: FlxGroup;
		private var _stars: FlxGroup;
		
		private var _scoreText:	FlxText ;
		private var _gameOverText: FlxText;
		
		private var _spawnTimer: Number;
		private var _spawnInterval: Number = 2.5;
		private var _spawnBulletTimer:Number;
		private var _spawnBulletInterval = 2;
		private var _enemySpawnNumber: Number = 1;
		
		private var stars:Stars;
		
		
		
		override public function PlayState() 
		{
			super.create();
		}
		
		
		
		
		//CREATE
		override public function create():void
		{
		
		stars = new Stars(90, 4);
		add(stars);		
			
		
		FlxG.score = 0;	
		
		bgColor = 0x11000000;	
		
		_ship = new Ship();
		add(_ship);
		
		_enemies = new FlxGroup();
		add(_enemies);
		
		_bullets = new FlxGroup();
		add(_bullets);
		
		//WYNIKI
		_scoreText = new FlxText(10, 8, 200, "0");
		_scoreText.setFormat(null, 32, 0xFFFFFFFF, "left");
		add(_scoreText);
		
		resetSpawnTimer();
	
		super.create();
		}
		
		
		
		//UPDATE
		override public function update():void
		{
			//detekcja kolizji
			
			FlxU.overlap(_enemies, _bullets , overlapEnemiesBullet);
			FlxU.overlap(_enemies, _ship, overlapEnemiesShip);
			
			//sprawdzanie czy przycisk został nacisiniety
			if (FlxG.keys.SPACE && _ship.dead == false) {
				spawnBullet(_ship.getBulletSpawnPosition());
			}
			if (FlxG.keys.ENTER && _ship.dead) {
				FlxG.state = new PlayState;
			}
			
			_spawnTimer -= FlxG.elapsed;
			
			if (_spawnTimer < 0) 
			{
				spawnEnemy();
				resetSpawnTimer();
			}
			
			
			if (FlxG.keys.UP && _ship.dead == false) 
			{
				var engineEmitter:FlxEmitter = createEngineEmitter();
				engineEmitter.at(_ship);
			}
			
			//zwiekszenie przyspieszania gwiazd
			stars.velocity.y = 60*(3-_spawnInterval);
			super.update();
			
		    
		}
		
		
		
		//spawnery
		private function spawnEnemy():void 
		{
		var x: Number = Math.random() * (FlxG.width - 60)+15;
		var y: Number = 0;
		
		_enemies.add(new Enemy(x, y,_enemySpawnNumber));
		if (_enemySpawnNumber == 20) {	_enemySpawnNumber = 1;
		}else {		_enemySpawnNumber++; }	
		
		}
		
		
		private function resetSpawnTimer():void
		{
		_spawnTimer		=	_spawnInterval;
		_spawnInterval	*= 0.95;
			if (_spawnInterval < 0.25) 
			{
			_spawnInterval = 0.25;
			}
		}
		
		
		
		//POCISKI
		private function spawnBullet(p: FlxPoint):void {
		var bullet: Bullet = new Bullet(p.x, p.y , 0);
		_bullets.add(bullet);
		//var emitter:FlxEmitter = createEmitter();
		//emitter.at(_ship);
		//FlxG.play(SoundBullet);
		}
		
		
		
		
		// detekcja kolizji
		//POCISKI KOLICJA
		private function overlapEnemiesBullet(enemies: Enemy, bullet:Bullet)
		{
		var emitter:FlxEmitter = createDestroyEmitter();
		emitter.at(enemies);
		enemies.kill();
		bullet.kill();
		FlxG.play(SoundExplosionEnemy);
		FlxG.score += 1;
		_scoreText.text = FlxG.score.toString();
		}
		
		//SMIERC POJAZDU KOLIZJA
		private function overlapEnemiesShip(enemies: Enemy, ship: Ship) {
			var emitter:FlxEmitter = createDestroyEmitter();
			emitter.at(ship);
			ship.kill();
			enemies.kill();
			FlxG.quake.start(0.02);
			FlxG.play(SoundExplosionShip);
			
			_gameOverText = new FlxText( 0, FlxG.height*0.45, FlxG.width, "GAME OVER\n ENTER TO PLAY AGAIN");
			_gameOverText.setFormat(null, 16, 0xFFFFFFFF, "center");
			add(_gameOverText);
		}
		
		// CZASTECZKI
		private function createDestroyEmitter():FlxEmitter 
		{
		var emitter:FlxEmitter = new FlxEmitter();
		emitter.delay = 1;
		emitter.gravity = 0;
		emitter.maxRotation = 0;
		emitter.setXSpeed( -100, 100);
		emitter.setYSpeed( -100, 100);
		var particles: int = 10;
		for (var i: int = 0; i < particles; i++) 
		{
			var particle:FlxSprite = new FlxSprite();
			particle.createGraphic(1, 1, 0xFF3300FF);
			particle.exists = false;
			emitter.add(particle);
		}
		emitter.start();
		add(emitter);
		return emitter;
		}
		
		private function createEngineEmitter():FlxEmitter 
		{
		var emitter:FlxEmitter = new FlxEmitter(-32,10);
		emitter.delay = 0;
		emitter.setSize(32, 0);
		emitter.gravity = 100;
		emitter.maxRotation = 0;
		emitter.setXSpeed( -10, 10);
		emitter.setYSpeed( 30, 50);
		var particles: int = 2;
		for (var i: int = 0; i < particles; i++) 
		{
			var particle:FlxSprite = new FlxSprite();
			particle.createGraphic(1, 1, 0xFFFFFF00);
			particle.exists = false;
			emitter.add(particle);
		}
		emitter.start();
		add(emitter);
		return emitter;
		} 
				
	}
}