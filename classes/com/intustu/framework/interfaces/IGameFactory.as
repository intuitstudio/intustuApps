package com.intustu.framework.interfaces
{	
	import com.intustu.framework.interfaces.IGame;	
	import flash.display.DisplayObjectContainer;
	
	public interface IGameFactory
	{
		function makeGame(coordinate:String):IGame;
	}
}