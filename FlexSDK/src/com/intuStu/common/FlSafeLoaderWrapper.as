package com.intustu.common
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
	
	//Adobe fl package safeloader
	import fl.display.SafeLoader;
	import fl.display.SafeLoaderInfo;
    //System classes declaration
	import flash.display.*;
	import flash.events.*;
	import flash.net.URLRequest;
	import flash.errors.IllegalOperationError;

	public class FlSafeLoaderWrapper extends EventDispatcher
	{
		//事件監聽物件
		private var eventHandle:Object;	
		//資源內容
		protected var _url:String;
		protected var _loader:*;
		protected var _request:URLRequest;
		protected var _bytesLoaded:Number = 0;
		protected var _bytesTotal:Number = 0;
		private var _percent:Number = 0;
	

		public function FlSafeLoaderWrapper ()
		{
			_loader = new fl.display.SafeLoader();					
		}
		
	    public function registListeners():void {
			eventHandle = new Object();
			eventHandle.events = [Event.COMPLETE,
			                      Event.OPEN,
								  Event.INIT,
								  Event.UNLOAD,
								  ProgressEvent.PROGRESS,
								  HTTPStatusEvent.HTTP_STATUS,
								  IOErrorEvent.IO_ERROR];
								  
			eventHandle.listeners = [completeHandler,
			                         openHandler,
									 initHandler,
									 unLoadHandler,
									 progressHandler,
									 httpStatusHandler,
									 ioErrorHandler];	
			//regist listeners
			var dispatcher:IEventDispatcher = _loader.contentLoaderInfo as SafeLoaderInfo;
	        for (var i:int = 0; i < eventHandle.events.length;i++ ) {
			   dispatcher.addEventListener (eventHandle.events[i], eventHandle.listeners[i]);			
			}
		}

		public function removeListeners ():void
		{
			var dispatcher:IEventDispatcher = _loader.contentLoaderInfo as SafeLoaderInfo;
	        for (var i:int = 0; i < eventHandle.events.length;i++ ) {
			   dispatcher.removeEventListener (eventHandle.events[i], eventHandle.listeners[i]);			
			}
		}

		protected function completeHandler (e:Event):void
		{
			//trace ('safeLoaderWrapper complete');
			dispatchEvent (e);
		}

		protected function progressHandler (e:ProgressEvent):void
		{
			if (_bytesTotal == 0)
			{
				_bytesTotal = e.bytesTotal;
				if (_bytesTotal == 0 || isNaN(_bytesTotal))
				{
					_bytesTotal = 0.00000001;
				}
			}

			_bytesLoaded = e.bytesLoaded;
			_percent = (_bytesLoaded/_bytesTotal)*100;
			//trace ('loading... '+ _percent.toFixed(2) + ' %' );
		}

		protected function initHandler (e:Event):void
		{
			//trace ('initlizing...',this.width,this.height);
		}

		protected function openHandler (e:Event):void
		{
			//trace ('open resurce');
		}

		protected function unLoadHandler (e:Event):void
		{
			_bytesLoaded = 0;
			_bytesTotal = 0;
			_loader.unloadAndStop ();
			
		}

		protected function httpStatusHandler (e:HTTPStatusEvent):void
		{
			//trace ('http Status is' ,e);
		}

		protected function ioErrorHandler (e:IOErrorEvent):void
		{
			dispatchEvent (e);
		}

		final public function get loader ():*
		{
			return _loader as fl.display.SafeLoader;
		}

		final public function get content ():DisplayObject
		{
			return _loader.content;
		}

		final public function get loadPercent ():Number
		{
			return _percent;
		}

		final public function load (url:String):void
		{
			_url = url;
			_percent = 0;
			doLoad ();
		}

		public function unload ():void
		{
			doUnLoad ();
		}

		protected function doUnLoad ():void
		{
			//throw new IllegalOperationError('doUnLoad must be overridden');
			_loader.unloadAndStop();
			removeListeners ();
		}

		protected function doLoad ():void
		{
			registListeners();
			_loader.load(new URLRequest(_url));
		}
		
	}//EndOfClass
}//EndOfPackage