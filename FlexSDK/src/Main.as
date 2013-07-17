package 
{
	/**
	 * Main Class
	 * @author vanier,peng ,2013.7.17
	 * 自訂文件類別，應用程式的進入點
	 * 宣告舞台大小、預載程式以及應用程式主檔所在
	 * 視需要定義全域變數或行為，例如改變滑鼠游標、設定舞台縮放模式...
	 */

	//System classed declaration 
	import flash.display.*;
	import flash.utils.getDefinitionByName;
	
	//Custom classes declaration : 
	//應用程式框架	
	import com.intustu.framework.core.*;
	import com.intustu.framework.factories.abstracts.AbstractGameFactory;
	import com.intustu.framework.managers.core.*;
	//專案客製
	import com.intustu.projects.appFramework.managers.*;
	import com.intustu.projects.appFramework.factories.*;
	
	//use metaTage define size and preloader
	[SWF(width="1000",height="700",frameRate="30",backgroundColor="#cccccc")]
	[Frame(factoryClass='AppPreloader')]	
	
	/**
	 * constructor
	 */
	public class Main extends DocumentMain
	{		
		private var classParser: ClassResolver;
		//singleton->建立單一程式物件 ; multiple->建立一般內容動畫,可載入
      	private var mode:String = 'singleton';
		//2d,3d或其他座標模式或third-party模組
		private var coordinate:String = '2d';
		
		override protected function createApp():void
		{
			//預先定義和登記需要使用到的類別
			preDefineClasses();
			
			if (mode === 'single')
			{
				AppShell.setFactory(new AbstractGameFactory(classParser.getClass('game')));
				myApp = AppShell.getInstance(coordinate) as GameInstance;
			}
			else
			{
				myApp = new GameMain(coordinate); //做為動畫內容時採用
			}
			_stage.addChild(myApp);
		}
		
		/**
		 * 設定舞台基本屬性
		 */
		override protected function setupStage():void
		{
			super.setupStage();
			//TODO , 設定基本舞台物件屬性內容
			_stage.scaleMode = StageScaleMode.NO_BORDER;
		}
		
		/**
		 * 登記應用程式中所使用的所有類別；具有類別宣告及實際滙入的作用
		 */
		private function preDefineClasses():Boolean
		{
			//宣告並使用工廠方法建立一個獨體的類別解析器實體，用來登記程式中所使用到的重要類別
			ClassResolverSingleton.setFactory(new ClassFrameworkFactory());
			classParser = ClassResolverSingleton.getInstance();
            //TODO , register useful defined classes :
			// classDefines.registerClass(ClassName , 'custom classID');
		}
	
	}//endOfClass
}