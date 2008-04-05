package fc.errors 
{
	/**
	 * 定义一些出错信息
	 * Value Object
	 * @author GaoXian
	 */
	public class Errors 
	{
		public static const paramIsInvalid  :String = "参数为空或者不合法!";
		public static const objectNotExist  :String = "访问的对象不存在!";
		public static const URLisEmpty		:String = "URL不能为空";
		public static const PhidIsInValid   :String = "组图帐号不合法!";
		public static const dataIsInValid		:String = "数据加载出错!";
		public static const fileSizeInValid  :String = "文件大小超过限定.";
		public static const keyGetInvalid : String = "从服务器获取key失败";
	}
}
