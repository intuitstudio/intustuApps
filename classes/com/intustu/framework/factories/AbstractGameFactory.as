package com.intustu.framework.factories
{	
	/**
	 * AbstractGameFactory Class
	 * @author vanier,peng
	 * 抽象應用程式或遊戲程式框架工廠，封裝實體產出的實做內容
	 * 所有符合需要的互動內容皆可繼承本類別並衍生各自的需求，以簡化相關的初始及設定工作
	 */
	
	import com.intustu.framework.interfaces.*;
	import flash.utils.getDefinitionByName;
	import flash.errors.IllegalOperationError;

	public class AbstractGameFactory implements IGameFactory
	{
		private var classRef:Class;
		
		public function AbstractGameFactory(obj:Class)
		{
			classRef = obj;
		}
		
		public function makeGame(coordinate:String):IGame
		{
			var app:IGame = makeInstance(classRef);
			app.coordinate = coordinate;
			return app; 
		}	 
		
		public function makeInstance(classRef:Class):*
		{			
			return new classRef() as IGame;
		}
		
	}//EndOfClass
}//EndOfPackage