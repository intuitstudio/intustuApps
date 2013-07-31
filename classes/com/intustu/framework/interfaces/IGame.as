package com.intustu.framework.interfaces
{	
	/**
	 * IGame Interface
	 * @author vanier,peng
	 * 定義應用程式或遊戲程式的操作界面
	*/
	
	public interface IGame
	{
		//啟動
		function launch():void;		
		//設定
		function setup():void; 
		//結束
		function quit():void;
		//釋放資源
		function dispose():void; 
		//參考座標設定 :2d ,3d
		function get coordinate():String;
		function set coordinate(mode:String):void;
	}	
}