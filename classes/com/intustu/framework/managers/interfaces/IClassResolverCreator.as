package com.intustu.framework.managers.interfaces 
{
	/**
	 * IClassResolverCreator Interface
	 * @author vanier peng , 2013.5.20
	 * ClassRrsolver的建構界面
	 */
	
	import com.intustu.framework.managers.core.ClassResolver;
	
	public interface IClassResolverCreator 
	{		
		 function makeUniqueCR():ClassResolver;
	}

}