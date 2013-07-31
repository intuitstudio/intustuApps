package com.intustu.common.managers 
{
	/**
	 * FlSafeLoaderMan class
	 * @author vanier peng
	 * 管理fl.display.SafeLoader所載入的外部資源
	 * 
	 */
	
    //System classes declaration
	import flash.display.*;
	import flash.events.*;
	import flash.net.URLRequest;
	import flash.errors.IllegalOperationError;
	//project feature classes
	import com.intustu.projects.standard.GameMain;
	import com.intustu.common.FlSafeLoaderWrapper;
	 

	//third-party classes
	//tween animation
	import aeon.animators.*;
	import aeon.*;
	import aeon.easing.*;
	import aeon.events.AnimationEvent;
	
	public class FlSafeLoaderMan extends EventDispatcher
	{
		//external swf or application developed with same framework
		private var _parent:GameMain;		
		private var assetLoader:FlSafeLoaderWrapper;
		private var currentApp:MovieClip;
		private var currentGame:MovieClip;
		private var defaultDuration:Number = 800;
		
		public function FlSafeLoaderMan(top:GameMain) 
		{
			_parent = top;
		}
		
		public function load(url:String):void
		{
			var contentLayer:Sprite = _parent.getLayer('contentLayer');
			if (assetLoader != null)
			{
				assetLoader.unload();
			}
			else
			{
				assetLoader = new FlSafeLoaderWrapper();
			}
			
			if (contentLayer.numChildren > 0)
			{
				clearContent();
			}
			
			assetLoader.addEventListener(Event.COMPLETE, onAppLoaded);
			assetLoader.load(url);
		}
		
		private function clearContent():void
		{
			var contentLayer:Sprite = _parent.getLayer('contentLayer');
			trace('clear ', contentLayer.numChildren, currentApp);
			//for (var i:int=contentLayer.numChildren-1; i>=0; i--)
			//{
			//var item:DisplayObject = contentLayer.getChildAt(i) as DisplayObject;
			//contentLayer.removeChild (item);
			//}
			
			if (currentApp)
			{
				if (currentApp.hasOwnProperty('dispose'))
				{
					currentApp.dispose();
				}
				
				if (contentLayer.contains(currentApp))
				{
					currentApp.mask = null;
					contentLayer.removeChild(currentApp);
				}
				
				if (contentLayer.contains(currentGame))
				{
					contentLayer.removeChild(currentGame);
				}
				
			}
		}
		
		private function onAppLoaded(e:Event):void
		{
			var contentLayer:Sprite = _parent.getLayer('contentLayer');
			var desktop:Stage = _parent.desktop;
			currentGame = assetLoader.content as MovieClip;
			assetLoader.removeEventListener(Event.COMPLETE, onAppLoaded);
			contentLayer.addChild(currentGame);
			
			if (currentGame)
			{
				if (currentGame.hasOwnProperty("app"))
				{
					currentApp = currentGame.app;
				}
				else
				{
					currentApp = currentGame;
				}
				
				if ( desktop.contains(currentApp))
				{
					trace('remove app from stage ', currentApp);
					desktop.removeChild(currentApp);
				}
				
				currentApp.alpha = 0;
				contentLayer.addChild(currentApp);
				var w:Number = currentApp.width;
				var h:Number = currentApp.height;
				trace('app size ', w, h);
				
				var tween:Tweener = new Tweener(currentApp, {alpha: 0}, {alpha: 1}, defaultDuration * 2, Sine.easeInOut);
				tween.addEventListener(AnimationEvent.END, onEndTween);
				tween.start();
				
				function onEndTween(e:AnimationEvent):void
				{
					tween.removeEventListener(AnimationEvent.END, onEndTween);
					trace('app show ');
				}

			}
		
		}
		
		private function closeApp(e:MouseEvent):void
		{
			clearContent();
		}
		


		
	}//EndOfClass
}//EndOfPackage