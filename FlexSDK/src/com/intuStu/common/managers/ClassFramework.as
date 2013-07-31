package com.intustu.common.managers
{
	/**
	 * ClassFramework Class
	 * @author vanier peng
	 *  宣告及登記程式所使用到的系統框架類型的類別集合
	 */
	
	import com.intustu.framework.managers.core.ClassResolver;
	import com.intustu.projects.standard.GameMain;
	 
	public class ClassFramework  extends ClassResolver 
	{		
		public function ClassFramework() 
		{
			super();
			registerClass(GameMain, 'game');
		}

	}//EndOfClass
}//EndOfPackage