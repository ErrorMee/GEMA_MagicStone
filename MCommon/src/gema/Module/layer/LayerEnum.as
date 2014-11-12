package gema.Module.layer
{
	import gema.structure.EnumVo;

	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class LayerEnum
	{
		/**
		 * 场景层               setValue 用作显示列表深度
		 */		
		public static const LAYER_SCENE:EnumVo 		= new EnumVo().setName("layer_scene").setValue(1);
		/**
		 * UI层 
		 */
		public static const LAYER_UI:EnumVo 		= new EnumVo().setName("layer_ui").setValue(2);
		/**
		 * 窗口层
		 */
		public static const LAYER_WINDOW:EnumVo 	= new EnumVo().setName("layer_window").setValue(3);
		/**
		 * 控制层
		 */
		public static const LAYER_CONTROL:EnumVo 	= new EnumVo().setName("layer_control").setValue(4);
		/**
		 * 提示层
		 */
		public static const LAYER_PROMPT:EnumVo 	= new EnumVo().setName("layer_prompt").setValue(5);
		/**
		 * 所有层
		 */
		public static const LAYERS:Array = [LAYER_SCENE,LAYER_UI,LAYER_WINDOW,LAYER_CONTROL,LAYER_PROMPT];
	}
}