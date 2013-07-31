package com.intustu.framework.core
{
	/**
	 * DocumentMain Class
	 * @author vanier,peng
	 * 文件類別的抽象基底類別，
	 * 封裝了loading相關屬性與方法
	 * 可當做元件使用，例如MovieClip影片
	 * Question :
	 *  1. Main類別所使用的metaTag 所定義的prloader程式與 loaderSp的功能是否重複?
	 *  2. 對於一般簡單的動畫內容是否需要複雜的框架來產出，有無其他簡單有效的解決方案?
	 */
	
	//System classes declaration 
	import flash.display.*;
	import flash.events.*;
	import flash.errors.IllegalOperationError;
	import flash.text.*;
	//Custom classes declaration
	import com.intustu.framework.core.GameInstance;
	import com.intustu.framework.interfaces.IGame;
	
	public class DocumentMain extends MovieClip
	{
		//applicatioin instance 
		protected var myApp:GameInstance;
		//content contianer ,it may be stage,sprite,movieclip
		protected var _container:DisplayObjectContainer;
		protected var _stage:Stage;
		protected var contentClip:MovieClip;
		
		private var startLoading:Boolean = false;
		private var preloadSp:Sprite;
		private var preloadTextField:TextField;
		private var preloadAni:MovieClip;
		
		public function DocumentMain()
		{
			// constructor code
			if (stage != null)
			{
				_container = stage;
				init();
			}
			else
			{
				addEventListener(Event.ADDED_TO_STAGE, init, false, 0, true);
			}
		}
		
		public function init(e:Event = null):void
		{
			if (e)
			{
				_container = (e.currentTarget as DisplayObjectContainer).parent;
				removeEventListener(Event.ADDED_TO_STAGE, init);
			}
			
			if (_stage == null)
			{
				
				if (_container is Stage)
				{
					_stage = _container as Stage;
				}
				else
				{
					_stage = _container.stage;
				}
				
			}
			setupStage();
		}
		
		protected function setupStage():void
		{		
			_stage.frameRate = 30;
			_stage.align = StageAlign.TOP_LEFT;
			_stage.scaleMode = StageScaleMode.NO_SCALE;
			
			//
			contentClip = root.loaderInfo.content as MovieClip;
			contentClip.stop();
			
			if (!(parent is Stage))
			{
				contentClip.nextFrame();
				createApp();
			}
			else
			{
				//當父容器為非舞台表示是由其他動畫物件載入 ,
				//TODO : 需要驗證是否有效執行??				
				this.loaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgressLoading);
				this.loaderInfo.addEventListener(Event.COMPLETE, onCompleteLoading);
			}
		}
		
		private function onProgressLoading(e:ProgressEvent):void
		{
			if (!startLoading)
			{
				drawPreload();
				startLoading = true;
			}
			
			var loadedBytes:uint = e.bytesLoaded;
			var totalBytes:uint = e.bytesTotal;
			var percentLoaded:uint = Math.ceil((loadedBytes / totalBytes) * 100);
			updatePreload(percentLoaded);
		}
		
		private function onCompleteLoading(e:Event):void
		{
			this.loaderInfo.removeEventListener(ProgressEvent.PROGRESS, onProgressLoading);
			this.loaderInfo.removeEventListener(Event.COMPLETE, onCompleteLoading);
			
			if (contentClip.currentFrame == 1)
			{
				contentClip.nextFrame();
			}
			
			if (preloadSp)
			{
				preloadSp.removeChild(preloadTextField);
				preloadTextField = null;
				_stage.removeChild(preloadSp);
				//createApp();
			}
		}
		
		private function drawPreload():void
		{
			preloadSp = new Sprite();
			preloadSp.graphics.clear();
			_stage.addChild(preloadSp);
			//draw background;
			drawPreloadBg(preloadSp.graphics);
			//draw percentage Bar
			drawPreloadBar(preloadSp.graphics, 0);
			//
			preloadTextField = new TextField();
			preloadTextField.multiline = false;
			preloadTextField.width = 150;
			preloadTextField.height = 30;
			var format:TextFormat = new TextFormat();
			format.color = 0xFFEEEE;
			format.size = 18;
			format.align = TextFormatAlign.LEFT;
			preloadTextField.defaultTextFormat = format;
			preloadTextField.text = "";
			preloadSp.addChild(preloadTextField);
		
		}
		
		private function drawPreloadBg(g:Graphics):void
		{
			g.beginFill(0);
			g.drawRect(0, 0, _stage.stageWidth, _stage.stageHeight);
			g.endFill();
		}
		
		private function drawPreloadBar(g:Graphics, w:Number, h:Number = 20):void
		{
			g.lineStyle(1, 0xCCCCCC);
			g.beginFill(0x333333, .64);
			g.drawRoundRect(225, (_stage.stageHeight - h) * .5, 100, h, 2, 2);
			g.endFill();
			g.lineStyle(1, 0xCCCCCC);
			g.beginFill(0xFFFFFF, .64);
			g.drawRoundRect(225, (_stage.stageHeight - h) * .5, w, h, 2, 2);
			g.endFill();
			//
			if (w > 0)
			{
				drawPerloadTxt(w, 225 + 100 + 10, (_stage.stageHeight - h) * .5);
			}
		}
		
		private function drawPerloadTxt(value:Number, x:Number, y:Number):void
		{
			preloadTextField.text = "loading... " + value.toFixed(0) + " %";
			preloadTextField.x = x;
			preloadTextField.y = y;
		}
		
		public function updatePreload(value:uint):void
		{
			preloadSp.graphics.clear();
			//draw background;
			drawPreloadBg(preloadSp.graphics);
			//draw percentage Bar
			drawPreloadBar(preloadSp.graphics, value);
		}
		
		protected function createApp():void
		{
			throw new IllegalOperationError('createApp must be overridden');
		}
		
		public function get container():DisplayObjectContainer
		{
			return _container;
		}
		
		public function get app():GameInstance
		{
			return myApp;
		}
		
		public function setStage(theStage:Stage):void
		{
			_stage = theStage;
		}
		
		public function getStage():Stage
		{
			return _stage;
		}
		
		public function get params():Object
		{
            var myParams:Object;
            if ( this.loaderInfo.parameters.length != null ) {
                myParams = this.loaderInfo.parameters;
            } else {
                // run alt code to init
				trace('cannot find parames');
            }
			return myParams;
		}
		
		public function showParams(obj:Object):void
		{
            for ( var sItem:String in obj ) {
              trace( "Name : " + sItem + ", Value : " + obj[ sItem ] );
            }
		}
	}//EndOfClass
}//EndOfPackage