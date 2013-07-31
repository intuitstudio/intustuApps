package com.intustu.common.managers
{
	import com.intustu.framework.managers.core.*;
	
	/**
	 * ClassUtilsFactory Class
	 * @author vanier peng
	 * 負責建構程式框架的類別集合
	 */
	public class ClassFrameworkFactory extends AClassResolverCreator
	{
		
		public function ClassFrameworkFactory(){}
		
		override public function makeUniqueCR():ClassResolver
		{
			return new ClassFramework();
		}
		
	}//EndOfClass
}//EndOfPackage