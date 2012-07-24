package doot {
	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public interface IResolveLink {
		function create(fileName:String,isDynamicAsset:Boolean=false,isMultiLang:Boolean=true):String;
	}
}
