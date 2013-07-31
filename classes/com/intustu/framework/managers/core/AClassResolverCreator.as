package com.intustu.framework.managers.core
{	
	/**
	 * AClassResolverCreator Class
	 * @author vanier peng,2013.5.20
	 * ClassResolver的抽象建構者
	 */
	
	import com.intustu.framework.managers.interfaces.IClassResolverCreator;
	
	public class AClassResolverCreator extends Object implements IClassResolverCreator
	{		
		public function AClassResolverCreator()	{}
		
		public function makeUniqueCR():ClassResolver
		{
			return new ClassResolver();
		}
		
	}//EndOfClass
}//EndOfPackage