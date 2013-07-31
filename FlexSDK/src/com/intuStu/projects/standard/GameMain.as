package com.intustu.projects.standard
{
	/**
	 * GameMain Class
	 * @author vanier,peng
	 * 應用程式主要程序：繼承GameInstance類別並且實做內容，封裝狀態機機制以及常用的方法函式以簡化開發工作。
	 *   標準化作業流程
	 *   自訂物件，根據專案需要客製開發各類物件和類別
	 *   公用變數及方法函式、事件監聽和派送
	 *   外部影片的載入容器及管理者
	 * 
	 */

	//System classes declaration 
	import flash.display.*;	
	import flash.ui.*;
	import flash.geom.*;
	import flash.filters.*;	
	import flash.events.*;	
	import flash.net.*;
	import flash.utils.getDefinitionByName;
	import flash.external.ExternalInterface;
	import flash.errors.IllegalOperationError;	
	//framework classes
	import com.intustu.framework.core.*;
	import com.intustu.framework.managers.core.*
	import com.intustu.dimension.bi.core.*;
	import com.intustu.dimension.tri.core.*;	
	//feature classes	
	import com.intustu.utils.*;
	
	//project required classes
	import com.intustu.common.*;
	import com.intustu.common.managers.*;	
	
	//third-party classes
	//tween animation
	import aeon.animators.*;
	import aeon.*;
	import aeon.easing.*;
	import aeon.events.AnimationEvent;

	/** 
	 * constructor 
	 */
	public class GameMain extends GameInstance
	{
		//game configuration:	
		
		//外部動畫、影片加載
		private var safeLoadMan:FlSafeLoaderMan;
		
		public function GameMain(coordinate:String = '2d') {
			super(coordinate);
		}
		
		override public function init():void
		{
			super.init();
			desktop.addEventListener(Event.RESIZE, onResizeStage, false, 0, true);
			launch();
		}
		
		override public function launch():void
		{
			//TODO lauch application 		
			
			//create safeLoadMan when need to loading external movieclips
			//safeLoadMan = new FlSafeLoaderMan(this);			
			
			trace('launch Intustuappp');
				
			//--------------------
			playingNow = true;			
			super.launch();
		}

		override protected function onCaptureStageEvents(e:*):void 
		{
			if (e is MouseEvent) {
				(e.type === MouseEvent.MOUSE_DOWN)
				?onPressMouse(e):(e.type === MouseEvent.MOUSE_MOVE)?onMovingMouse(e):null;
			}
			
			if ( e is KeyboardEvent)
			{
				(e.type === KeyboardEvent.KEY_DOWN)
				?onPressKeyboard(e):(e.type === KeyboardEvent.KEY_UP)?onReleaseKeyboard(e):null;
			}						
		}		
		
		
		
		
		
		override protected function gameStep(frameMs:Number):void
		{
			if (playingNow)
			{
				var elapsed:Number = frameMs / 1000;
				//-------------------------
			
		
				
				//-------------------------
				renderScene();
			}
		}
		
		override protected function renderScene():void
		{
			//--------call objects' rendering method------------

			

		}
		
		//------------------------------------------------		
	
		
		private function makePoint(geo:String = '2d'):*
		{
			var point:*;
			var dest:Object;
			
			if (geo === '2d')
			{
				//dest = MathTools.getRandomPoint(_stage.stageWidth, _stage.stageHeight);
				dest = MathTools.getRandomPoint(desktop.stageWidth, desktop.stageHeight);
				point = new Point2d(dest.x, dest.y);
			}
			
			if (geo === '3d')
			{
				//dest = MathTools.getRandomPoint(_stage.stageWidth >> 1, _stage.stageHeight >> 1, 125);
				dest = MathTools.getRandomPoint(desktop.stageWidth >> 1, desktop.stageHeight >> 1, 125);
				point = new Point3d(dest.x, dest.y, dest.z);
				point.perspective = projection;
				point.perspective.center = new Vector3D(0, 0, 200);
			}
			
			return point;
		}
						
		//---------------------------------------------------------;
		private function checkBounds(obj:*):void
		{
			var size:Number = 0;
			var offsetx:Number = obj.size * .5;
			var offsetz:Number = obj.size * .5;
			
			if (obj.x > boundary.right - size + offsetx)
			{
				trace('hit right');
				obj.x = boundary.right - size + offsetx;
				obj.vx *= bounce;
			}
			
			if (obj.x < boundary.left - size * .5 + offsetx)
			{
				trace('hit left');
				obj.x = boundary.left - size * .5 + offsetx;
				obj.vx *= bounce;
			}
			
			if (obj.z > boundary.fore - size + offsetz)
			{
				trace('hit fore');
				obj.z = boundary.fore - size + offsetz;
				obj.vz *= bounce;
			}
			
			if (obj.z < boundary.back - size * .5 + offsetz)
			{
				trace('hit back');
				obj.z = boundary.back - size * .5 + offsetz;
				obj.vz *= bounce;
			}
			
			if (obj.y > boundary.bottom)
			{
				obj.y = boundary.bottom;
				obj.vy *= bounce;
			}
		}
		
		private function checkCollisions():void
		{
		
		}
		
		private function onCaptureMouse(e:MouseEvent):void
		{
			//Mouse.cursor = MouseCursor.HAND;
			
		}
		
		private function onCaptureTouch(e:TouchEvent):void
		{
			
		}
		
		private function onCaptureKeyboard(e:KeyboardEvent):void
		{
			
		}
		
		
		private function onPressMouse(e:MouseEvent):void
		{
			//stage.addEventListener(MouseEvent.MOUSE_UP, onReleaseMouse);
			desktop.addEventListener(MouseEvent.MOUSE_UP, onReleaseMouse);

		}
		
		private function onMovingMouse(e:MouseEvent):void
		{

		}

		
		private function onReleaseMouse(e:MouseEvent):void
		{
			Mouse.cursor = MouseCursor.ARROW;
			stopDrag();
			//stage.removeEventListener(MouseEvent.MOUSE_UP, onReleaseMouse);
			desktop.removeEventListener(MouseEvent.MOUSE_UP, onReleaseMouse);
		}
 
		private function onPressKeyboard(e:KeyboardEvent):void
		{
			var pageIndex:int = 0;
			trace('press keyboard ' , e.keyCode);			
			switch (e.keyCode)
			{
				case Keyboard.UP: 
								
					break;
				case Keyboard.DOWN: 
					
					break;
				case Keyboard.RIGHT:
					
					break;
				case Keyboard.LEFT:
					
					break;
				case Keyboard.SPACE: 
					break;
				case Keyboard.M: 
					break;
				case Keyboard.SHIFT: 
					 
					break;
				default: 
					break;
			}
			
		}
		
		private function onReleaseKeyboard(e:KeyboardEvent):void
		{
			trace('release keyboard ' , e.keyCode);			
			switch (e.keyCode)
			{
				case Keyboard.UP:					
					break;
				case Keyboard.DOWN:					
					break;
				case Keyboard.RIGHT:					
					break;
				case Keyboard.LEFT:
					
					break;
				case Keyboard.SPACE: 
					break;
				case Keyboard.SHIFT: 
					 
					break;
			}
			//stage.removeEventListener (KeyboardEvent.KEY_UP,onReleaseKeyboard);
		}
	
		public function get desktop():Stage
		{
			return GameInstance.desktop;
		}		
		
	}//EndOfClass
}//EndOfPackage